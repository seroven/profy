import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../settings/providers/settings_providers.dart';
import '../services/template_service.dart';

final templateServiceProvider = Provider<TemplateService>((ref) {
  return TemplateService(
    database: ref.watch(databaseProvider),
    imageStorage: ref.watch(localImageStorageProvider),
  );
});

final templatesListProvider =
    FutureProvider.autoDispose<List<Template>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];
  return ref.watch(templateServiceProvider).listForUser(userId);
});

final templateByIdProvider =
    FutureProvider.autoDispose.family<Template?, int>((ref, id) async {
  return ref.watch(templateServiceProvider).getById(id);
});
