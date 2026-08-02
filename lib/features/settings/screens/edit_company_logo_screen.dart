import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_toast.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class EditCompanyLogoScreen extends ConsumerStatefulWidget {
  const EditCompanyLogoScreen({super.key});

  static const routePath = '/configuracion/empresa';

  @override
  ConsumerState<EditCompanyLogoScreen> createState() =>
      _EditCompanyLogoScreenState();
}

class _EditCompanyLogoScreenState
    extends ConsumerState<EditCompanyLogoScreen> {
  bool _saving = false;
  /// Vista local inmediata; el path fijo cacheaba la imagen anterior.
  String? _previewPath;
  bool _previewCleared = false;

  String? get _logoPath {
    if (_previewCleared) return null;
    return _previewPath ??
        ref.watch(userPreferencesProvider).valueOrNull?.companyLogoPath;
  }

  Future<void> _pickLogo() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 90,
    );
    if (file == null) return;

    setState(() => _saving = true);
    try {
      final prefs = ref.read(userPreferencesProvider).valueOrNull;
      final storage = ref.read(localImageStorageProvider);
      final previousPath = prefs?.companyLogoPath;
      final path = await storage.saveImage(
        source: File(file.path),
        folder: 'logos',
        fileName: 'company_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      );
      await ref.read(userPreferencesServiceProvider).updateCompanyLogo(
            userId: userId,
            logoPath: path,
          );
      await storage.deleteIfExists(
        previousPath == path ? null : previousPath,
      );
      if (previousPath != null) {
        imageCache.evict(FileImage(File(previousPath)));
      }
      ref.invalidate(userPreferencesProvider);
      if (mounted) {
        setState(() {
          _previewPath = path;
          _previewCleared = false;
        });
        AppToast.success(context, 'Logo actualizado');
      }
    } catch (_) {
      if (mounted) AppToast.error(context, 'No se pudo actualizar el logo');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _removeLogo() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _saving = true);
    try {
      final prefs = ref.read(userPreferencesProvider).valueOrNull;
      final previousPath = prefs?.companyLogoPath ?? _previewPath;
      await ref.read(userPreferencesServiceProvider).updateCompanyLogo(
            userId: userId,
            logoPath: null,
          );
      await ref.read(localImageStorageProvider).deleteIfExists(previousPath);
      if (previousPath != null) {
        imageCache.evict(FileImage(File(previousPath)));
      }
      ref.invalidate(userPreferencesProvider);
      if (mounted) {
        setState(() {
          _previewPath = null;
          _previewCleared = true;
        });
        AppToast.success(context, 'Logo eliminado');
      }
    } catch (_) {
      if (mounted) AppToast.error(context, 'No se pudo eliminar el logo');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoPath = _logoPath;

    return SettingsSubpageScaffold(
      title: 'Logo de empresa',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          AcrylicSurface(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: logoPath == null
                  ? Center(
                      child: Text(
                        'Sin logo',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(logoPath),
                        key: ValueKey(logoPath),
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: logoPath == null ? 'Subir logo' : 'Cambiar logo',
            isLoading: _saving,
            onPressed: _saving ? null : _pickLogo,
          ),
          if (logoPath != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _saving ? null : _removeLogo,
              child: const Text('Eliminar logo'),
            ),
          ],
        ],
      ),
    );
  }
}
