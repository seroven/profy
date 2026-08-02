import 'package:pdf/widgets.dart' as pw;

import '../../../../core/database/app_database.dart';
import '../../../settings/models/payment_method_type.dart';
import '../pdf_card.dart';
import '../proforma_pdf_theme.dart';

/// Bloque medios de pago en card moderna.
pw.Widget buildPaymentMethodsBlockPdf(List<PaymentMethod> methods) {
  return pdfBlockCard(
    title: 'Medios de pago',
    icon: PdfDrawnIcon.wallet,
    child: methods.isEmpty
        ? pw.Text(
            'Sin medios de pago configurados.',
            style: ProformaPdfTheme.caption(),
          )
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < methods.length; i++) ...[
                _methodCard(methods[i]),
                if (i < methods.length - 1) pw.SizedBox(height: 8),
              ],
            ],
          ),
  );
}

pw.Widget _methodCard(PaymentMethod method) {
  final type = PaymentMethodType.fromCode(method.type);
  final details = _details(method, type);
  final name = method.name.trim().isEmpty ? 'Sin nombre' : method.name.trim();

  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: pw.BoxDecoration(
      color: ProformaPdfTheme.white,
      borderRadius: pw.BorderRadius.circular(6),
      border: pw.Border.all(color: ProformaPdfTheme.line, width: 0.7),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pdfDrawnIcon(PdfDrawnIcon.wallet, size: 18),
        pw.SizedBox(width: 10),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                name,
                style: ProformaPdfTheme.body().copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (details.isNotEmpty) ...[
                pw.SizedBox(height: 2),
                pw.Text(details, style: ProformaPdfTheme.caption()),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

String _details(PaymentMethod method, PaymentMethodType type) {
  return switch (type) {
    PaymentMethodType.yape || PaymentMethodType.plin =>
      (method.phone ?? '').trim(),
    PaymentMethodType.bankAccount => [
        if ((method.accountNumber ?? '').trim().isNotEmpty)
          'Cuenta ${method.accountNumber!.trim()}',
        if ((method.interbankNumber ?? '').trim().isNotEmpty)
          'CCI ${method.interbankNumber!.trim()}',
      ].join(' | '),
  };
}
