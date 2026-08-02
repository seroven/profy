import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_color_theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/min_duration.dart';
import '../models/app_currency.dart';
import '../models/measure_unit.dart';
import 'profile_bootstrap_service.dart';

class UserPreferencesService {
  UserPreferencesService({
    required this.database,
    required this.bootstrapService,
  });

  final AppDatabase database;
  final ProfileBootstrapService bootstrapService;

  Future<UserPreference> getForUser(int userId) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      return ensured.preferences;
    });
  }

  Future<UserPreference> updateTheme({
    required int userId,
    required ThemeMode themeMode,
    required AppColorTheme colorTheme,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      final mode = themeMode == ThemeMode.light ? 'light' : 'dark';

      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(ensured.preferences.id)))
          .write(
        UserPreferencesCompanion(
          themeMode: Value(mode),
          colorTheme: Value(colorTheme.name),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return _reload(ensured.preferences.id);
    });
  }

  Future<UserPreference> updateDefaults({
    required int userId,
    required AppCurrency currency,
    required MeasureUnit unit,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(ensured.preferences.id)))
          .write(
        UserPreferencesCompanion(
          defaultCurrency: Value(currency.code),
          defaultUnit: Value(unit.code),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return _reload(ensured.preferences.id);
    });
  }

  Future<UserPreference> updateAppearanceAndDefaults({
    required int userId,
    required ThemeMode themeMode,
    required AppColorTheme colorTheme,
    required AppCurrency currency,
    required MeasureUnit unit,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      final mode = themeMode == ThemeMode.light ? 'light' : 'dark';
      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(ensured.preferences.id)))
          .write(
        UserPreferencesCompanion(
          themeMode: Value(mode),
          colorTheme: Value(colorTheme.name),
          defaultCurrency: Value(currency.code),
          defaultUnit: Value(unit.code),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return _reload(ensured.preferences.id);
    });
  }

  Future<UserPreference> updateCompanyLogo({
    required int userId,
    required String? logoPath,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(ensured.preferences.id)))
          .write(
        UserPreferencesCompanion(
          companyLogoPath: Value(logoPath),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return _reload(ensured.preferences.id);
    });
  }

  Future<UserPreference> updateCompanyProfile({
    required int userId,
    required String? companyName,
    String? logoPath,
    bool updateLogo = false,
  }) {
    return withMinDuration(() async {
      final ensured = await bootstrapService.ensureForUser(userId);
      final trimmed = companyName?.trim();
      await (database.update(database.userPreferences)
            ..where((t) => t.id.equals(ensured.preferences.id)))
          .write(
        UserPreferencesCompanion(
          companyName: Value(
            trimmed == null || trimmed.isEmpty ? null : trimmed,
          ),
          companyLogoPath:
              updateLogo ? Value(logoPath) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return _reload(ensured.preferences.id);
    });
  }

  Future<UserPreference> _reload(int id) {
    return (database.select(database.userPreferences)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }
}
