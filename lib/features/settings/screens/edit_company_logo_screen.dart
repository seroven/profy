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

  String? _originalLogoPath;
  String? _pendingLogoPath;
  bool _logoRemoved = false;

  String? get _displayLogoPath {
    if (_logoRemoved) return null;
    return _pendingLogoPath ?? _originalLogoPath;
  }

  @override
  void dispose() {
    final pending = _pendingLogoPath;
    final original = _originalLogoPath;
    _nameController.dispose();
    super.dispose();
    // Descarta un logo nuevo que nunca se guardó.
    if (pending != null && pending != original) {
      final file = File(pending);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }

  void _hydrate() {
    final prefs = ref.read(userPreferencesProvider).valueOrNull;
    if (prefs == null || _hydrated) return;
    _nameController.text = prefs.companyName ?? '';
    _originalLogoPath = prefs.companyLogoPath;
    _hydrated = true;
  }

  Future<void> _pickLogo() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null || _saving) return;

    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 90,
    );
    if (file == null) return;

    try {
      final storage = ref.read(localImageStorageProvider);
      final previousPending = _pendingLogoPath;
      final path = await storage.saveImage(
        source: File(file.path),
        folder: 'logos',
        fileName: 'company_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      );
      if (previousPending != null && previousPending != _originalLogoPath) {
        await storage.deleteIfExists(previousPending);
      }
      if (!mounted) return;
      setState(() {
        _pendingLogoPath = path;
        _logoRemoved = false;
      });
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo cargar el logo');
      }
    }
  }

  void _markLogoRemoved() {
    if (_saving) return;
    setState(() => _logoRemoved = true);
  }

  Future<void> _save() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null || _saving) return;

    setState(() => _saving = true);
    try {
      final storage = ref.read(localImageStorageProvider);
      final updateLogo = _logoRemoved || _pendingLogoPath != null;
      final nextLogoPath =
          _logoRemoved ? null : (_pendingLogoPath ?? _originalLogoPath);

      await ref.read(userPreferencesServiceProvider).updateCompanyProfile(
            userId: userId,
            companyName: _nameController.text,
            logoPath: nextLogoPath,
            updateLogo: updateLogo,
          );

      if (updateLogo) {
        final previous = _originalLogoPath;
        if (_logoRemoved) {
          await storage.deleteIfExists(previous);
          if (_pendingLogoPath != null) {
            await storage.deleteIfExists(_pendingLogoPath);
          }
          if (previous != null) {
            imageCache.evict(FileImage(File(previous)));
          }
        } else if (_pendingLogoPath != null) {
          await storage.deleteIfExists(
            previous == _pendingLogoPath ? null : previous,
          );
          if (previous != null && previous != _pendingLogoPath) {
            imageCache.evict(FileImage(File(previous)));
          }
        }
      }

      ref.invalidate(userPreferencesProvider);
      if (!mounted) return;
      setState(() {
        _originalLogoPath = nextLogoPath;
        _pendingLogoPath = null;
        _logoRemoved = false;
      });
      AppToast.success(context, 'Empresa actualizada');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo guardar la empresa');
      }
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

    final logoPath = _displayLogoPath;
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
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: _saving ? null : _pickLogo,
            child: Text(logoPath == null ? 'Subir logo' : 'Cambiar logo'),
          ),
          if (logoPath != null) ...[
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _saving ? null : _markLogoRemoved,
              child: const Text('Eliminar logo'),
            ),
          ],
          const SizedBox(height: 28),
          AppButton(
            label: 'Guardar',
            isLoading: _saving,
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }
}
