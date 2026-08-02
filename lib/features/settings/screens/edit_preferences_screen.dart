import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_color_theme.dart';
import '../../../app/theme/theme_provider.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_toast.dart';
import '../models/app_currency.dart';
import '../models/measure_unit.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class EditPreferencesScreen extends ConsumerStatefulWidget {
  const EditPreferencesScreen({super.key});

  static const routePath = '/configuracion/preferencias';

  @override
  ConsumerState<EditPreferencesScreen> createState() =>
      _EditPreferencesScreenState();
}

class _EditPreferencesScreenState
    extends ConsumerState<EditPreferencesScreen> {
  ThemeMode _themeMode = ThemeMode.dark;
  AppColorTheme _colorTheme = AppColorTheme.blue;
  AppCurrency _currency = AppCurrency.pen;
  MeasureUnit _unit = MeasureUnit.m2;
  bool _hydrated = false;
  int _persistToken = 0;

  void _hydrate() {
    final prefs = ref.read(userPreferencesProvider).valueOrNull;
    if (prefs == null || _hydrated) return;
    _themeMode =
        prefs.themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;
    _colorTheme = AppColorTheme.values.firstWhere(
      (item) => item.name == prefs.colorTheme,
      orElse: () => AppColorTheme.blue,
    );
    _currency = prefs.currency;
    _unit = prefs.unit;
    _hydrated = true;
  }

  Future<void> _persistCurrent() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final token = ++_persistToken;
    try {
      await ref.read(userPreferencesServiceProvider).updateAppearanceAndDefaults(
            userId: userId,
            themeMode: _themeMode,
            colorTheme: _colorTheme,
            currency: _currency,
            unit: _unit,
          );
      if (!mounted || token != _persistToken) return;
      ref.invalidate(userPreferencesProvider);
    } catch (_) {
      if (mounted && token == _persistToken) {
        AppToast.error(context, 'No se pudieron guardar las preferencias');
      }
    }
  }

  void _applyThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
    ref.read(themeModeProvider.notifier).setThemeMode(mode);
    _persistCurrent();
  }

  void _applyColorTheme(AppColorTheme theme) {
    setState(() => _colorTheme = theme);
    ref.read(appColorThemeProvider.notifier).setColorTheme(theme);
    _persistCurrent();
  }

  void _applyCurrency(AppCurrency currency) {
    setState(() => _currency = currency);
    _persistCurrent();
  }

  void _applyUnit(MeasureUnit unit) {
    setState(() => _unit = unit);
    _persistCurrent();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userPreferencesProvider, (previous, next) {
      if (_hydrated) return;
      _hydrate();
      setState(() {});
    });
    _hydrate();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SettingsSubpageScaffold(
      title: 'Preferencias',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text(
            'Los cambios se aplican al instante',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 18),
          Text('Modo', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Oscuro'),
                icon: Icon(Icons.dark_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Claro'),
                icon: Icon(Icons.light_mode_outlined),
              ),
            ],
            selected: {_themeMode},
            onSelectionChanged: (value) => _applyThemeMode(value.first),
          ),
          const SizedBox(height: 22),
          Text('Color', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          AcrylicSurface(
            padding: const EdgeInsets.all(14),
            tint: colorScheme.primary,
            opacity: theme.brightness == Brightness.dark ? 0.10 : 0.14,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final item in AppColorTheme.values)
                  GestureDetector(
                    onTap: () => _applyColorTheme(item),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.seedColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _colorTheme == item
                              ? colorScheme.onSurface
                              : colorScheme.onSurface.withValues(alpha: 0.2),
                          width: _colorTheme == item ? 2.5 : 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('Moneda por defecto', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final item in AppCurrency.values)
                ChoiceChip(
                  label: Text(item.label),
                  selected: _currency == item,
                  onSelected: (_) => _applyCurrency(item),
                ),
            ],
          ),
          const SizedBox(height: 22),
          Text('Unidad por defecto', style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in MeasureUnit.values)
                ChoiceChip(
                  label: Text(item.label),
                  selected: _unit == item,
                  onSelected: (_) => _applyUnit(item),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
