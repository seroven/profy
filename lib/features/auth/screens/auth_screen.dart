import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_background.dart';
import '../widgets/password_strength_meter.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const String routeName = 'auth';
  static const String routePath = '/auth';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String _password = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final error = await ref.read(authProvider.notifier).loginOrRegister(
          username: _usernameController.text,
          password: _passwordController.text,
        );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AppToast.error(context, error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return authAsync.when(
      loading: () => Scaffold(
        body: AuthBackground(
          child: Center(
            child: AcrylicSurface(
              padding: const EdgeInsets.all(22),
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
      error: (error, _) => Scaffold(
        body: AuthBackground(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AcrylicSurface(
                padding: const EdgeInsets.all(22),
                child: Text(
                  'No se pudo iniciar la app.\n$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      data: (auth) {
        final needsSetup = auth.needsSetup;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AuthBackground(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppConstants.appName,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.2,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Center(
                            child: AcrylicSurface(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              borderRadius: BorderRadius.circular(999),
                              blur: 16,
                              shadow: false,
                              tint: colorScheme.primary,
                              opacity: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? 0.16
                                  : 0.28,
                              child: Text(
                                needsSetup
                                    ? 'Crea tu acceso local'
                                    : 'Bienvenido de nuevo',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            needsSetup
                                ? 'Como es la primera vez, estos datos serán tu usuario y contraseña.'
                                : 'Ingresa para continuar con tus proformas.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.78),
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 36),
                          AcrylicSurface(
                            padding: const EdgeInsets.all(22),
                            tint: colorScheme.primary,
                            opacity: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? 0.10
                                : 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppTextField(
                                  controller: _usernameController,
                                  label: 'Usuario',
                                  hint:
                                      'Mínimo ${AppConstants.minUsernameLength} caracteres',
                                  prefixIcon: Icons.person_outline_rounded,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.username],
                                  enabled: !_isSubmitting,
                                  validator: (value) {
                                    final text = value?.trim() ?? '';
                                    if (text.length <
                                        AppConstants.minUsernameLength) {
                                      return 'El usuario debe tener al menos ${AppConstants.minUsernameLength} caracteres';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  controller: _passwordController,
                                  label: 'Contraseña',
                                  hint:
                                      'Mínimo ${AppConstants.minPasswordLength} caracteres',
                                  obscureText: _obscurePassword,
                                  prefixIcon: Icons.lock_outline_rounded,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  enabled: !_isSubmitting,
                                  onChanged: (value) {
                                    setState(() => _password = value);
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: _isSubmitting
                                        ? null
                                        : () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                  validator: (value) {
                                    final text = value ?? '';
                                    if (text.length <
                                        AppConstants.minPasswordLength) {
                                      return 'La contraseña debe tener al menos ${AppConstants.minPasswordLength} caracteres';
                                    }
                                    return null;
                                  },
                                ),
                                if (needsSetup) ...[
                                  const SizedBox(height: 16),
                                  PasswordStrengthMeter(password: _password),
                                ],
                                const SizedBox(height: 24),
                                AppButton(
                                  label: needsSetup
                                      ? 'Crear acceso'
                                      : 'Iniciar sesión',
                                  isLoading: _isSubmitting,
                                  onPressed: _isSubmitting ? null : _submit,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: AcrylicSurface(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              borderRadius: BorderRadius.circular(999),
                              blur: 14,
                              shadow: false,
                              child: Text(
                                'Solo en este dispositivo',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.72),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
