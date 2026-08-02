import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/section_placeholder_screen.dart';
import '../../auth/providers/auth_provider.dart';

class ConfiguracionScreen extends ConsumerStatefulWidget {
  const ConfiguracionScreen({super.key});

  static const String routeName = 'configuracion';
  static const String routePath = '/configuracion';

  @override
  ConsumerState<ConfiguracionScreen> createState() =>
      _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends ConsumerState<ConfiguracionScreen> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);
    await ref.read(authProvider.notifier).logout();
    if (mounted) {
      setState(() => _isLoggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionPlaceholderScreen(
      name: 'Configuración',
      footer: SizedBox(
        width: 220,
        child: AppButton(
          label: 'Cerrar sesión',
          isLoading: _isLoggingOut,
          expanded: true,
          onPressed: _isLoggingOut ? null : _logout,
        ),
      ),
    );
  }
}
