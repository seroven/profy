import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';

class ProformaScreen extends ConsumerStatefulWidget {
  const ProformaScreen({super.key});

  static const String routeName = 'proformas';
  static const String routePath = '/proformas';

  @override
  ConsumerState<ProformaScreen> createState() => _ProformaScreenState();
}

class _ProformaScreenState extends ConsumerState<ProformaScreen> {
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proformas'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Proforma screen'),
            const SizedBox(height: 24),
            // Temporal: solo para probar el flujo de auth.
            FilledButton.tonal(
              onPressed: _isLoggingOut ? null : _logout,
              child: _isLoggingOut
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    )
                  : const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
