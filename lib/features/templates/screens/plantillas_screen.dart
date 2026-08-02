import 'package:flutter/material.dart';

import '../../../shared/widgets/section_placeholder_screen.dart';

class PlantillasScreen extends StatelessWidget {
  const PlantillasScreen({super.key});

  static const String routeName = 'plantillas';
  static const String routePath = '/plantillas';

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholderScreen(name: 'Plantillas');
  }
}
