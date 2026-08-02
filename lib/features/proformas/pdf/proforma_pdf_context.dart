import '../../../core/database/app_database.dart';
import '../models/proforma_document.dart';

/// Datos inmutables necesarios para renderizar el PDF.
class ProformaPdfContext {
  const ProformaPdfContext({
    required this.proforma,
    required this.document,
    this.companyName,
    this.companyLogoPath,
    this.profile,
    this.paymentMethods = const [],
  });

  final Proforma proforma;
  final ProformaDocument document;
  final String? companyName;
  final String? companyLogoPath;
  final UserDetail? profile;
  final List<PaymentMethod> paymentMethods;
}
