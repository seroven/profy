import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/providers/auth_provider.dart';

/// Renueva la actividad de sesión con interacción y al volver a primer plano.
class SessionLifecycle extends ConsumerStatefulWidget {
  const SessionLifecycle({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<SessionLifecycle> createState() => _SessionLifecycleState();
}

class _SessionLifecycleState extends ConsumerState<SessionLifecycle>
    with WidgetsBindingObserver {
  DateTime _lastTouch = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(authProvider.notifier).ensureSessionValid();
    }
  }

  void _onInteraction() {
    final now = DateTime.now();
    if (now.difference(_lastTouch) < const Duration(seconds: 30)) return;
    _lastTouch = now;
    ref.read(authProvider.notifier).touchSession();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _onInteraction(),
      child: widget.child,
    );
  }
}
