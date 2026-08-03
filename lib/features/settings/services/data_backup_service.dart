import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/database/app_database.dart';

/// Exporta / importa un respaldo `.profy` (ZIP: manifest + data JSON + assets).
class DataBackupService {
  DataBackupService(this.database);

  static const formatId = 'profy-backup';
  static const formatVersion = 1;
  static const _imagesRoot = 'profy_images';

  final AppDatabase database;

  /// Genera bytes `.profy` con los datos del [userId] actual.
  Future<Uint8List> exportForUser(int userId) async {
    final user = await (database.select(database.users)
          ..where((t) => t.id.equals(userId)))
        .getSingleOrNull();
    if (user == null) {
      throw StateError('Usuario no encontrado');
    }

    final detail = await (database.select(database.userDetails)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
    if (detail == null) {
      throw StateError('Perfil no encontrado');
    }

    final prefs = await (database.select(database.userPreferences)
          ..where((t) => t.userDetailId.equals(detail.id)))
        .getSingleOrNull();
    if (prefs == null) {
      throw StateError('Preferencias no encontradas');
    }

    final payments = await (database.select(database.paymentMethods)
          ..where((t) => t.userDetailId.equals(detail.id)))
        .get();
    final proformas = await (database.select(database.proformas)
          ..where((t) => t.userId.equals(userId)))
        .get();

    final assetKeys = <String>{};
    void collect(String? absolutePath) {
      final key = _assetKeyFromAbsolute(absolutePath);
      if (key != null) assetKeys.add(key);
    }

    collect(detail.photoPath);
    collect(prefs.companyLogoPath);
    for (final proforma in proformas) {
      for (final path in _imagePathsFromDocument(proforma.documentJson)) {
        collect(path);
      }
    }

    final data = <String, dynamic>{
      'user': user.toJson(),
      'userDetail': _withAssetPaths(detail.toJson(), {
        'photoPath': detail.photoPath,
      }),
      'preferences': _withAssetPaths(prefs.toJson(), {
        'companyLogoPath': prefs.companyLogoPath,
      }),
      'paymentMethods': payments.map((e) => e.toJson()).toList(),
      'proformas': [
        for (final item in proformas)
          _withRewrittenDocumentJson(item.toJson(), item.documentJson),
      ],
    };

    final archive = Archive();
    final manifest = utf8.encode(
      jsonEncode({
        'format': formatId,
        'version': formatVersion,
        'schemaVersion': database.schemaVersion,
        'createdAt': DateTime.now().toIso8601String(),
        'app': 'profy',
      }),
    );
    archive.addFile(
      ArchiveFile('manifest.json', manifest.length, manifest),
    );

    final dataBytes = utf8.encode(jsonEncode(data));
    archive.addFile(ArchiveFile('data.json', dataBytes.length, dataBytes));

    for (final key in assetKeys) {
      final absolute = await _absoluteFromAssetKey(key);
      final file = File(absolute);
      if (!await file.exists()) continue;
      final bytes = await file.readAsBytes();
      archive.addFile(ArchiveFile('assets/$key', bytes.length, bytes));
    }

    return Uint8List.fromList(ZipEncoder().encode(archive));
  }

  /// Restaura el respaldo sobre el usuario local [userId] (reemplazo).
  Future<void> importForUser({
    required int userId,
    required Uint8List bytes,
  }) async {
    final archive = ZipDecoder().decodeBytes(bytes);
    final manifestFile = _fileOf(archive, 'manifest.json');
    final dataFile = _fileOf(archive, 'data.json');
    if (manifestFile == null || dataFile == null) {
      throw StateError('Archivo .profy inválido');
    }

    final manifest = jsonDecode(utf8.decode(manifestFile.content))
        as Map<String, dynamic>;
    if (manifest['format'] != formatId) {
      throw StateError('Formato de respaldo no reconocido');
    }

    final data =
        jsonDecode(utf8.decode(dataFile.content)) as Map<String, dynamic>;

    final docs = await getApplicationDocumentsDirectory();
    final pathMap = <String, String>{};

    for (final file in archive.files) {
      if (!file.isFile) continue;
      final name = file.name.replaceAll('\\', '/');
      if (!name.startsWith('assets/$_imagesRoot/')) continue;
      final assetKey = name.substring('assets/'.length);
      final target = p.join(docs.path, assetKey);
      await File(target).parent.create(recursive: true);
      await File(target).writeAsBytes(file.content);
      pathMap[assetKey] = target;
      // También mapear posibles absolutos viejos que terminen con el mismo key.
      pathMap.putIfAbsent(assetKey.replaceAll('/', '\\'), () => target);
    }

    String? resolvePath(dynamic value) {
      if (value == null) return null;
      final raw = value.toString();
      if (raw.isEmpty) return null;
      final key = _assetKeyFromAbsolute(raw) ??
          (raw.startsWith(_imagesRoot) ? raw.replaceAll('\\', '/') : null);
      if (key != null && pathMap.containsKey(key)) return pathMap[key];
      if (pathMap.containsKey(raw)) return pathMap[raw];
      return raw;
    }

    String rewriteDocument(String documentJson) {
      try {
        final root = jsonDecode(documentJson);
        if (root is! Map<String, dynamic>) return documentJson;
        final blocks = root['blocks'];
        if (blocks is! List) return jsonEncode(root);
        for (final block in blocks) {
          if (block is! Map) continue;
          final paths = block['imagePaths'];
          if (paths is! List) continue;
          block['imagePaths'] = [
            for (final item in paths) resolvePath(item) ?? item,
          ];
        }
        return jsonEncode(root);
      } catch (_) {
        return documentJson;
      }
    }

    final localDetail = await (database.select(database.userDetails)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
    if (localDetail == null) {
      throw StateError('Perfil local no encontrado');
    }
    final localPrefs = await (database.select(database.userPreferences)
          ..where((t) => t.userDetailId.equals(localDetail.id)))
        .getSingleOrNull();
    if (localPrefs == null) {
      throw StateError('Preferencias locales no encontradas');
    }

    final backupUser = User.fromJson(
      Map<String, dynamic>.from(data['user'] as Map),
    );
    final backupDetail = UserDetail.fromJson(
      Map<String, dynamic>.from(data['userDetail'] as Map),
    );
    final backupPrefs = UserPreference.fromJson(
      Map<String, dynamic>.from(data['preferences'] as Map),
    );
    final backupPayments = (data['paymentMethods'] as List? ?? const [])
        .whereType<Map>()
        .map((e) => PaymentMethod.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    final backupProformas = (data['proformas'] as List? ?? const [])
        .whereType<Map>()
        .map((e) => Proforma.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    await database.transaction(() async {
      await (database.delete(database.proformas)
            ..where((t) => t.userId.equals(userId)))
          .go();
      await (database.delete(database.paymentMethods)
            ..where((t) => t.userDetailId.equals(localDetail.id)))
          .go();

      await (database.update(database.users)
            ..where((t) => t.id.equals(userId)))
          .write(
        UsersCompanion(
          username: Value(backupUser.username),
          password: Value(backupUser.password),
          enable: Value(backupUser.enable),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await (database.update(database.userDetails)
            ..where((t) => t.id.equals(localDetail.id)))
          .write(
        UserDetailsCompanion(
          firstName: Value(backupDetail.firstName),
          lastName: Value(backupDetail.lastName),
          phone: Value(backupDetail.phone),
          dni: Value(backupDetail.dni),
          ruc: Value(backupDetail.ruc),
          email: Value(backupDetail.email),
          photoPath: Value(resolvePath(backupDetail.photoPath)),
          enable: Value(backupDetail.enable),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(localPrefs.id)))
          .write(
        UserPreferencesCompanion(
          themeMode: Value(backupPrefs.themeMode),
          colorTheme: Value(backupPrefs.colorTheme),
          defaultCurrency: Value(backupPrefs.defaultCurrency),
          defaultUnit: Value(backupPrefs.defaultUnit),
          companyName: Value(backupPrefs.companyName),
          companyLogoPath: Value(resolvePath(backupPrefs.companyLogoPath)),
          enable: Value(backupPrefs.enable),
          updatedAt: Value(DateTime.now()),
        ),
      );

      for (final payment in backupPayments) {
        await database.into(database.paymentMethods).insert(
              PaymentMethodsCompanion.insert(
                userDetailId: localDetail.id,
                type: payment.type,
                name: payment.name,
                phone: Value(payment.phone),
                accountNumber: Value(payment.accountNumber),
                interbankNumber: Value(payment.interbankNumber),
                sortOrder: Value(payment.sortOrder),
                enable: Value(payment.enable),
              ),
            );
      }

      for (final proforma in backupProformas) {
        await database.into(database.proformas).insert(
              ProformasCompanion.insert(
                userId: userId,
                code: proforma.code,
                clientName: Value(proforma.clientName),
                projectName: Value(proforma.projectName),
                phone: Value(proforma.phone),
                proformaDate: proforma.proformaDate,
                currency: Value(proforma.currency),
                status: Value(proforma.status),
                documentJson: Value(rewriteDocument(proforma.documentJson)),
                enable: Value(proforma.enable),
              ),
            );
      }
    });
  }

  ArchiveFile? _fileOf(Archive archive, String name) {
    for (final file in archive.files) {
      if (file.name.replaceAll('\\', '/') == name) return file;
    }
    return null;
  }

  String? _assetKeyFromAbsolute(String? absolutePath) {
    if (absolutePath == null || absolutePath.trim().isEmpty) return null;
    final normalized = absolutePath.replaceAll('\\', '/');
    final marker = '/$_imagesRoot/';
    final index = normalized.indexOf(marker);
    if (index < 0) {
      if (normalized.startsWith('$_imagesRoot/')) return normalized;
      return null;
    }
    return normalized.substring(index + 1);
  }

  Future<String> _absoluteFromAssetKey(String assetKey) async {
    final docs = await getApplicationDocumentsDirectory();
    return p.join(docs.path, assetKey.replaceAll('/', p.separator));
  }

  List<String> _imagePathsFromDocument(String documentJson) {
    try {
      final root = jsonDecode(documentJson);
      if (root is! Map) return const [];
      final blocks = root['blocks'];
      if (blocks is! List) return const [];
      final paths = <String>[];
      for (final block in blocks) {
        if (block is! Map) continue;
        final list = block['imagePaths'];
        if (list is! List) continue;
        for (final item in list) {
          if (item is String && item.trim().isNotEmpty) paths.add(item);
        }
      }
      return paths;
    } catch (_) {
      return const [];
    }
  }

  Map<String, dynamic> _withAssetPaths(
    Map<String, dynamic> json,
    Map<String, String?> absoluteFields,
  ) {
    final copy = Map<String, dynamic>.from(json);
    for (final entry in absoluteFields.entries) {
      copy[entry.key] = _assetKeyFromAbsolute(entry.value);
    }
    return copy;
  }

  Map<String, dynamic> _withRewrittenDocumentJson(
    Map<String, dynamic> json,
    String documentJson,
  ) {
    final copy = Map<String, dynamic>.from(json);
    try {
      final root = jsonDecode(documentJson);
      if (root is Map<String, dynamic>) {
        final blocks = root['blocks'];
        if (blocks is List) {
          for (final block in blocks) {
            if (block is! Map) continue;
            final paths = block['imagePaths'];
            if (paths is! List) continue;
            block['imagePaths'] = [
              for (final item in paths)
                _assetKeyFromAbsolute(item?.toString()) ?? item,
            ];
          }
        }
        copy['documentJson'] = jsonEncode(root);
      }
    } catch (_) {
      // leave original
    }
    return copy;
  }
}
