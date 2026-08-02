import 'package:flutter/material.dart';

import '../../../shared/widgets/section_placeholder_screen.dart';

class ComprobanteScreen extends StatelessWidget {
  const ComprobanteScreen({super.key});

  static const String routeName = 'comprobantes';
  static const String routePath = '/comprobantes';

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholderScreen(name: 'Comprobante');
  }
}
