import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/widgets/password_strength_meter.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class EditPasswordScreen extends ConsumerStatefulWidget {
  const EditPasswordScreen({super.key});

  static const routePath = '/configuracion/contrasena';

  @override
  ConsumerState<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends ConsumerState<EditPasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _saving = false;
  bool _obscure = true;
  String _newPassword = '';

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    if (_newController.text != _confirmController.text) {
      AppToast.error(context, 'Las contraseñas nuevas no coinciden');
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(accountServiceProvider).updatePassword(
            userId: userId,
            currentPassword: _currentController.text,
            newPassword: _newController.text,
          );
      _currentController.clear();
      _newController.clear();
      _confirmController.clear();
      setState(() => _newPassword = '');
      if (mounted) AppToast.success(context, 'Contraseña actualizada');
    } on AuthException catch (error) {
      if (mounted) AppToast.error(context, error.message);
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo actualizar la contraseña');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSubpageScaffold(
      title: 'Contraseña',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          AppTextField(
            controller: _currentController,
            label: 'Contraseña actual',
            obscureText: _obscure,
            enabled: !_saving,
          ),
          const SizedBox(height: 26),
          AppTextField(
            controller: _newController,
            label: 'Nueva contraseña',
            hint: 'Mínimo ${AppConstants.minPasswordLength} caracteres',
            obscureText: _obscure,
            enabled: !_saving,
            onChanged: (value) => setState(() => _newPassword = value),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          if (_newPassword.isNotEmpty) ...[
            const SizedBox(height: 12),
            PasswordStrengthMeter(password: _newPassword),
          ],
          const SizedBox(height: 14),
          AppTextField(
            controller: _confirmController,
            label: 'Confirmar nueva contraseña',
            obscureText: _obscure,
            enabled: !_saving,
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
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
