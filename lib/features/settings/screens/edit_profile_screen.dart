import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  static const routePath = '/configuracion/perfil';

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dniController = TextEditingController();
  final _rucController = TextEditingController();
  final _emailController = TextEditingController();

  bool _loaded = false;
  bool _saving = false;
  String? _photoPath;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    _rucController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _hydrate() {
    final detail = ref.read(userDetailProvider).valueOrNull;
    if (detail == null || _loaded) return;
    _firstNameController.text = detail.firstName ?? '';
    _lastNameController.text = detail.lastName ?? '';
    _phoneController.text = detail.phone ?? '';
    _dniController.text = detail.dni ?? '';
    _rucController.text = detail.ruc ?? '';
    _emailController.text = detail.email ?? '';
    _photoPath = detail.photoPath;
    _loaded = true;
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (file == null) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _saving = true);
    try {
      final storage = ref.read(localImageStorageProvider);
      final previous = _photoPath;
      final path = await storage.saveImage(
        source: File(file.path),
        folder: 'avatars',
        fileName: 'user_$userId',
      );
      await ref.read(userDetailServiceProvider).updatePhotoPath(
            userId: userId,
            photoPath: path,
          );
      await storage.deleteIfExists(previous == path ? null : previous);
      ref.invalidate(userDetailProvider);
      setState(() => _photoPath = path);
      if (mounted) AppToast.success(context, 'Foto actualizada');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo actualizar la foto');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _saving = true);
    try {
      await ref.read(userDetailServiceProvider).updatePersonalData(
            userId: userId,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            phone: _phoneController.text,
            dni: _dniController.text,
            ruc: _rucController.text,
            email: _emailController.text,
          );
      ref.invalidate(userDetailProvider);
      if (mounted) AppToast.success(context, 'Datos guardados');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudieron guardar los datos');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(userDetailProvider);
    ref.listen(userDetailProvider, (previous, next) => _hydrate());
    _hydrate();

    final showLoader = detailAsync.isLoading || !_loaded;

    return SettingsSubpageScaffold(
      title: 'Datos personales',
      child: showLoader
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: AppLoadingPanel(message: 'Cargando perfil…'),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.25),
                        backgroundImage: _photoPath != null
                            ? FileImage(File(_photoPath!))
                            : null,
                        child: _photoPath == null
                            ? const Icon(Icons.person_rounded, size: 42)
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _saving ? null : _pickPhoto,
                        child: const Text('Cambiar foto'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _firstNameController,
                  label: 'Nombres',
                  textInputAction: TextInputAction.next,
                  enabled: !_saving,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _lastNameController,
                  label: 'Apellidos',
                  textInputAction: TextInputAction.next,
                  enabled: !_saving,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _phoneController,
                  label: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  enabled: !_saving,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _dniController,
                  label: 'DNI',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  enabled: !_saving,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _rucController,
                  label: 'RUC',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  enabled: !_saving,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  enabled: !_saving,
                ),
                const SizedBox(height: 24),
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
