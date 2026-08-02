import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_toast.dart';
import '../models/payment_method_type.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class PaymentMethodsScreen extends ConsumerStatefulWidget {
  const PaymentMethodsScreen({super.key});

  static const routePath = '/configuracion/medios-pago';

  @override
  ConsumerState<PaymentMethodsScreen> createState() =>
      _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends ConsumerState<PaymentMethodsScreen> {
  bool _busy = false;

  Future<void> _delete(int id) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(paymentMethodsServiceProvider).softDelete(id);
      await ref.refresh(paymentMethodsProvider.future);
      if (mounted) AppToast.success(context, 'Medio eliminado');
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo eliminar el medio de pago');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final methodsAsync = ref.watch(paymentMethodsProvider);
    final showLoader = _busy ||
        methodsAsync.isLoading ||
        methodsAsync.isRefreshing ||
        methodsAsync.isReloading;

    return SettingsSubpageScaffold(
      title: 'Medios de pago',
      child: showLoader
          ? const Center(child: CircularProgressIndicator())
          : methodsAsync.when(
              skipLoadingOnReload: false,
              skipLoadingOnRefresh: false,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  const Center(child: Text('No se pudieron cargar')),
              data: (methods) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  children: [
                    AppButton(
                      label: 'Agregar medio de pago',
                      icon: Icons.add_rounded,
                      onPressed: () => context.push(
                        '${PaymentMethodsScreen.routePath}/nuevo',
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (methods.isEmpty)
                      AcrylicSurface(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Aún no agregaste medios de pago. Es opcional.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    else
                      ...methods.map((method) {
                        final type = PaymentMethodType.fromCode(method.type);
                        final subtitle = switch (type) {
                          PaymentMethodType.yape || PaymentMethodType.plin =>
                            method.phone ?? 'Sin teléfono',
                          PaymentMethodType.bankAccount => [
                              if (method.accountNumber != null)
                                'Cuenta ${method.accountNumber}',
                              if (method.interbankNumber != null)
                                'CCI ${method.interbankNumber}',
                            ].join(' · '),
                        };

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AcrylicSurface(
                            child: ListTile(
                              onTap: () => context.push(
                                '${PaymentMethodsScreen.routePath}/${method.id}',
                              ),
                              leading: Icon(
                                switch (type) {
                                  PaymentMethodType.yape =>
                                    Icons.qr_code_2_rounded,
                                  PaymentMethodType.plin => Icons.bolt_rounded,
                                  PaymentMethodType.bankAccount =>
                                    Icons.account_balance_outlined,
                                },
                              ),
                              title: Text(method.name),
                              subtitle: Text(
                                '${type.label}${subtitle.isEmpty ? '' : ' · $subtitle'}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                onPressed: () => _delete(method.id),
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                );
              },
            ),
    );
  }
}
