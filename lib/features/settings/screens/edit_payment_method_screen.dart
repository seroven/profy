import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../models/payment_method_type.dart';
import '../providers/settings_providers.dart';
import '../widgets/settings_subpage_scaffold.dart';

class EditPaymentMethodScreen extends ConsumerStatefulWidget {
  const EditPaymentMethodScreen({super.key, this.methodId});

  static const routeNewPath = '/configuracion/medios-pago/nuevo';

  final int? methodId;

  bool get isEditing => methodId != null;

  @override
  ConsumerState<EditPaymentMethodScreen> createState() =>
      _EditPaymentMethodScreenState();
}

class _EditPaymentMethodScreenState
    extends ConsumerState<EditPaymentMethodScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _accountController = TextEditingController();
  final _interbankController = TextEditingController();

  PaymentMethodType _type = PaymentMethodType.yape;
  bool _saving = false;
  bool _hydrated = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _accountController.dispose();
    _interbankController.dispose();
    super.dispose();
  }

  Future<void> _hydrateIfNeeded() async {
    if (!widget.isEditing || _hydrated) return;
    final method =
        await ref.read(paymentMethodsServiceProvider).getById(widget.methodId!);
    if (method == null || !mounted) return;

    setState(() {
      _type = PaymentMethodType.fromCode(method.type);
      _nameController.text = method.name;
      _phoneController.text = method.phone ?? '';
      _accountController.text = method.accountNumber ?? '';
      _interbankController.text = method.interbankNumber ?? '';
      _hydrated = true;
    });
  }

  void _onTypeChanged(PaymentMethodType type) {
    setState(() {
      _type = type;
      if (!widget.isEditing) {
        _nameController.text = type.label;
      }
    });
  }

  Future<void> _save() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    if (_nameController.text.trim().isEmpty) {
      AppToast.error(context, 'Ingresa un nombre');
      return;
    }

    setState(() => _saving = true);
    try {
      final service = ref.read(paymentMethodsServiceProvider);
      if (widget.isEditing) {
        await service.update(
          id: widget.methodId!,
          type: _type,
          name: _nameController.text,
          phone: _phoneController.text,
          accountNumber: _accountController.text,
          interbankNumber: _interbankController.text,
        );
      } else {
        await service.create(
          userId: userId,
          type: _type,
          name: _nameController.text.isEmpty ? _type.label : _nameController.text,
          phone: _phoneController.text,
          accountNumber: _accountController.text,
          interbankNumber: _interbankController.text,
        );
      }
      ref.invalidate(paymentMethodsProvider);
      if (mounted) {
        AppToast.success(
          context,
          widget.isEditing ? 'Medio actualizado' : 'Medio agregado',
        );
        context.pop();
      }
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'No se pudo guardar el medio de pago');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing && !_hydrated) {
      _hydrateIfNeeded();
    } else if (!widget.isEditing && _nameController.text.isEmpty) {
      _nameController.text = _type.label;
    }

    final isWallet =
        _type == PaymentMethodType.yape || _type == PaymentMethodType.plin;

    return SettingsSubpageScaffold(
      title: widget.isEditing ? 'Editar medio' : 'Nuevo medio',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text('Tipo', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final type in PaymentMethodType.values)
                ChoiceChip(
                  label: Text(type.label),
                  selected: _type == type,
                  onSelected:
                      _saving ? null : (_) => _onTypeChanged(type),
                ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _nameController,
            label: isWallet ? 'Nombre' : 'Nombre del banco / cuenta',
            enabled: !_saving,
          ),
          const SizedBox(height: 14),
          if (isWallet)
            AppTextField(
              controller: _phoneController,
              label: 'Número de teléfono',
              keyboardType: TextInputType.phone,
              enabled: !_saving,
            )
          else ...[
            AppTextField(
              controller: _accountController,
              label: 'Número de cuenta',
              enabled: !_saving,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _interbankController,
              label: 'Cuenta interbancaria (CCI)',
              enabled: !_saving,
            ),
          ],
          const SizedBox(height: 24),
          AppButton(
            label: 'Guardar',
            isLoading: _saving,
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }
}
