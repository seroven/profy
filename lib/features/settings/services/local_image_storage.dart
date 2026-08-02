import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalImageStorage {
  Future<String> saveImage({
    required File source,
    required String folder,
    required String fileName,
  }) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'profy_images', folder));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final extension = p.extension(source.path).isEmpty
        ? '.jpg'
        : p.extension(source.path);
    final targetPath = p.join(dir.path, '$fileName$extension');
    final saved = await source.copy(targetPath);
    return saved.path;
  }

  Future<void> deleteIfExists(String? path) async {
    if (path == null || path.isEmpty) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
