import 'dart:typed_data';

import '../../../core/database/app_database.dart';
import '../../settings/services/payment_methods_service.dart';
import '../../settings/services/user_detail_service.dart';
import '../../settings/services/user_preferences_service.dart';
import '../models/proforma_document.dart';
import '../models/proforma_status.dart';
import 'proforma_pdf_builder.dart';
import 'proforma_pdf_context.dart';

/// Orquesta datos de settings + generación del PDF.
class ProformaPdfService {
  ProformaPdfService({
    required this.preferencesService,
    required this.userDetailService,
    required this.paymentMethodsService,
    ProformaPdfBuilder? builder,
  }) : _builder = builder ?? ProformaPdfBuilder();

  final UserPreferencesService preferencesService;
  final UserDetailService userDetailService;
  final PaymentMethodsService paymentMethodsService;
  final ProformaPdfBuilder _builder;

  Future<Uint8List> buildBytes(Proforma proforma) async {
    if (ProformaStatus.fromCode(proforma.status) != ProformaStatus.finished) {
      throw StateError('Solo se puede exportar una proforma terminada.');
    }

    final prefs = await preferencesService.getForUser(proforma.userId);
    final profile = await userDetailService.getForUser(proforma.userId);
    final payments = await paymentMethodsService.listForUser(proforma.userId);
    final document = ProformaDocument.fromJsonString(proforma.documentJson);

    final context = ProformaPdfContext(
      proforma: proforma,
      document: document,
      companyName: prefs.companyName,
      companyLogoPath: prefs.companyLogoPath,
      profile: profile,
      paymentMethods: payments,
    );

    return _builder.build(context);
  }
}
