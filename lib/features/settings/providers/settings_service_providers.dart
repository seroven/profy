import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../auth/services/password_hasher.dart';
import '../services/account_service.dart';
import '../services/local_image_storage.dart';
import '../services/payment_methods_service.dart';
import '../services/profile_bootstrap_service.dart';
import '../services/user_detail_service.dart';
import '../services/user_preferences_service.dart';

final profileBootstrapServiceProvider = Provider<ProfileBootstrapService>((ref) {
  return ProfileBootstrapService(ref.watch(databaseProvider));
});

final userDetailServiceProvider = Provider<UserDetailService>((ref) {
  return UserDetailService(
    database: ref.watch(databaseProvider),
    bootstrapService: ref.watch(profileBootstrapServiceProvider),
  );
});

final userPreferencesServiceProvider = Provider<UserPreferencesService>((ref) {
  return UserPreferencesService(
    database: ref.watch(databaseProvider),
    bootstrapService: ref.watch(profileBootstrapServiceProvider),
  );
});

final paymentMethodsServiceProvider = Provider<PaymentMethodsService>((ref) {
  return PaymentMethodsService(
    database: ref.watch(databaseProvider),
    bootstrapService: ref.watch(profileBootstrapServiceProvider),
  );
});

final accountServiceProvider = Provider<AccountService>((ref) {
  return AccountService(
    database: ref.watch(databaseProvider),
    passwordHasher: PasswordHasher(),
  );
});

final localImageStorageProvider = Provider<LocalImageStorage>((ref) {
  return LocalImageStorage();
});
