import 'package:flutter/material.dart';

import '../../../shared/widgets/section_placeholder_screen.dart';

class ProformaScreen extends StatelessWidget {
  const ProformaScreen({super.key});

  static const String routeName = 'proformas';
  static const String routePath = '/proformas';

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholderScreen(name: 'Proforma');
  }
}
