import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../settings/providers/settings_providers.dart';
import '../pdf/proforma_pdf_service.dart';
import '../services/proforma_service.dart';

final proformaServiceProvider = Provider<ProformaService>((ref) {
  return ProformaService(ref.watch(databaseProvider));
});

final proformaPdfServiceProvider = Provider<ProformaPdfService>((ref) {
  return ProformaPdfService(
    preferencesService: ref.watch(userPreferencesServiceProvider),
    userDetailService: ref.watch(userDetailServiceProvider),
    paymentMethodsService: ref.watch(paymentMethodsServiceProvider),
  );
});

final proformasListProvider =
    FutureProvider.autoDispose<List<Proforma>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];
  return ref.watch(proformaServiceProvider).listForUser(userId);
});

final proformaByIdProvider =
    FutureProvider.autoDispose.family<Proforma?, int>((ref, id) async {
  return ref.watch(proformaServiceProvider).getById(id);
});

/// Re-export útil al crear borradores con moneda por defecto.
final proformaDefaultCurrencyProvider = Provider((ref) {
  return ref.watch(userPreferencesProvider).valueOrNull?.currency;
});
