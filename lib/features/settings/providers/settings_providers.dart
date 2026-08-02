import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/app_currency.dart';
import '../models/measure_unit.dart';
import 'settings_service_providers.dart';

export 'settings_service_providers.dart';

final currentUserIdProvider = Provider<int?>((ref) {
  return ref.watch(authProvider).valueOrNull?.user?.id;
});

final userDetailProvider =
    FutureProvider.autoDispose<UserDetail?>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;
  return ref.watch(userDetailServiceProvider).getForUser(userId);
});

final userPreferencesProvider =
    FutureProvider.autoDispose<UserPreference?>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;
  return ref.watch(userPreferencesServiceProvider).getForUser(userId);
});

final paymentMethodsProvider =
    FutureProvider.autoDispose<List<PaymentMethod>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];
  return ref.watch(paymentMethodsServiceProvider).listForUser(userId);
});

extension PreferencesViewX on UserPreference {
  AppCurrency get currency => AppCurrency.fromCode(defaultCurrency);
  MeasureUnit get unit => MeasureUnit.fromCode(defaultUnit);
}
