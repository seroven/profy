import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
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
  final _nameController = TextEditingController();
  bool _saving = false;
  bool _hydrated = false;
  String? _previewPath;
  bool _previewCleared = false;

  String? get _logoPath {
    if (_previewCleared) return null;
    return _previewPath ??
        ref.watch(userPreferencesProvider).valueOrNull?.companyLogoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _hydrate() {
    final prefs = ref.read(userPreferencesProvider).valueOrNull;
    if (prefs == null || _hydrated) return;
    _nameController.text = prefs.companyName ?? '';
    _hydrated = true;
  }

  Future<void> _saveName() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _saving = true);
    try {
      await ref.read(userPreferencesServiceProvider).updateCompanyProfile(
            userId: userId,
            companyName: _nameController.text,
          );
      ref.invalidate(userPreferencesProvider);
      if (mounted) AppToast.success(context, 'Nombre de empresa guardado');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo guardar el nombre');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
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
    ref.listen(userPreferencesProvider, (previous, next) {
      if (_hydrated) return;
      _hydrate();
      setState(() {});
    });
    _hydrate();

    final logoPath = _logoPath;
    final theme = Theme.of(context);

    return SettingsSubpageScaffold(
      title: 'Empresa',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text('Identidad', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          AppTextField(
            controller: _nameController,
            label: 'Nombre de la empresa',
            hint: 'Se mostrará en tus proformas',
            textInputAction: TextInputAction.done,
            enabled: !_saving,
          ),
          const SizedBox(height: 14),
          AppButton(
            label: 'Guardar nombre',
            isLoading: _saving,
            onPressed: _saving ? null : _saveName,
          ),
          const SizedBox(height: 28),
          Text('Logo', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          AcrylicSurface(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: logoPath == null
                  ? Center(
                      child: Text(
                        'Sin logo',
                        style: theme.textTheme.titleMedium,
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
