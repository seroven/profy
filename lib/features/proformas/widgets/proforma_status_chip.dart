import 'package:flutter/material.dart';

import '../models/proforma_status.dart';

/// Chip visual de estado de proforma (Borrador / Terminada).
class ProformaStatusChip extends StatelessWidget {
  const ProformaStatusChip({super.key, required this.status});

  final ProformaStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDraft = status == ProformaStatus.draft;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (isDraft ? colorScheme.secondary : colorScheme.primary)
            .withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
