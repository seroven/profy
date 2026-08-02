import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_section.dart';

class ConfiguracionScreen extends ConsumerStatefulWidget {
  const ConfiguracionScreen({super.key});

  static const String routeName = 'configuracion';
  static const String routePath = '/configuracion';

  @override
  ConsumerState<ConfiguracionScreen> createState() =>
      _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends ConsumerState<ConfiguracionScreen> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);
    await ref.read(authProvider.notifier).logout();
    if (mounted) setState(() => _isLoggingOut = false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider).valueOrNull;
    final detailAsync = ref.watch(userDetailProvider);
    final prefsAsync = ref.watch(userPreferencesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isLoadingProfile = detailAsync.isLoading || prefsAsync.isLoading;

    return ColoredBox(
      color: colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Configuración',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (isLoadingProfile)
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AppLoadingPanel(message: 'Cargando perfil…'),
                  ),
                ),
              )
            else
              Expanded(
                child: Builder(
                  builder: (context) {
                    final detail = detailAsync.valueOrNull;
                    final prefs = prefsAsync.valueOrNull;
                    final displayName = [
                      detail?.firstName,
                      detail?.lastName,
                    ]
                        .where(
                          (part) => part != null && part.trim().isNotEmpty,
                        )
                        .join(' ');

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
                      children: [
                        SettingsSection(
                          title: 'Resumen',
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundColor: theme.colorScheme.primary
                                    .withValues(alpha: 0.25),
                                backgroundImage: detail?.photoPath != null
                                    ? FileImage(File(detail!.photoPath!))
                                    : null,
                                child: detail?.photoPath == null
                                    ? Icon(
                                        Icons.person_rounded,
                                        color: theme.colorScheme.primary,
                                      )
                                    : null,
                              ),
                              title: Text(
                                displayName.isEmpty
                                    ? (auth?.user?.username ?? 'Usuario')
                                    : displayName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                [
                                  if (auth?.user?.username != null)
                                    '@${auth!.user!.username}',
                                  if (detail?.email != null) detail!.email!,
                                ].join(' · '),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.65),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SettingsSection(
                          title: 'Mi cuenta',
                          children: [
                            SettingsTile(
                              icon: Icons.badge_outlined,
                              title: 'Datos personales',
                              subtitle: 'Nombres, contacto, DNI y RUC',
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/perfil',
                              ),
                            ),
                            SettingsTile(
                              icon: Icons.person_outline_rounded,
                              title: 'Usuario',
                              subtitle: auth?.user?.username,
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/usuario',
                              ),
                            ),
                            SettingsTile(
                              icon: Icons.lock_outline_rounded,
                              title: 'Contraseña',
                              subtitle: 'Actualizar acceso',
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/contrasena',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SettingsSection(
                          title: 'Preferencias',
                          children: [
                            SettingsTile(
                              icon: Icons.palette_outlined,
                              title: 'Apariencia y defaults',
                              subtitle: prefs == null
                                  ? 'Tema, moneda y unidades'
                                  : '${prefs.themeMode == 'light' ? 'Claro' : 'Oscuro'} · ${prefs.currency.label} · ${prefs.unit.label}',
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/preferencias',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SettingsSection(
                          title: 'Empresa',
                          children: [
                            SettingsTile(
                              icon: Icons.business_outlined,
                              title: 'Empresa',
                              subtitle: () {
                                final name = prefs?.companyName?.trim();
                                final hasName =
                                    name != null && name.isNotEmpty;
                                final hasLogo = prefs?.companyLogoPath != null;
                                if (hasName && hasLogo) return name;
                                if (hasName) return '$name · Sin logo';
                                if (hasLogo) {
                                  return 'Sin nombre · Logo configurado';
                                }
                                return 'Nombre y logo para proformas';
                              }(),
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/empresa',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SettingsSection(
                          title: 'Medios de pago',
                          children: [
                            SettingsTile(
                              icon: Icons.account_balance_wallet_outlined,
                              title: 'Yape, Plin y bancos',
                              subtitle: 'Opcional · puedes agregar varios',
                              onTap: () => context.push(
                                '${ConfiguracionScreen.routePath}/medios-pago',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SettingsSection(
                          title: 'Sesión',
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 10, 16, 14),
                              child: AppButton(
                                label: 'Cerrar sesión',
                                isLoading: _isLoggingOut,
                                onPressed: _isLoggingOut ? null : _logout,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
