import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_loading_panel.dart';
import '../../../shared/widgets/app_toast.dart';
import '../providers/proforma_providers.dart';

/// Vista previa del PDF con la estética de Profy (el documento no cambia).
class ProformaPdfPreviewScreen extends ConsumerStatefulWidget {
  const ProformaPdfPreviewScreen({super.key, required this.proformaId});

  static const routeName = 'proforma-pdf';

  final int proformaId;

  @override
  ConsumerState<ProformaPdfPreviewScreen> createState() =>
      _ProformaPdfPreviewScreenState();
}

class _ProformaPdfPreviewScreenState
    extends ConsumerState<ProformaPdfPreviewScreen> {
  static const _loader = Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: AppLoadingPanel(message: 'Generando PDF…'),
    ),
  );

  static const _pagesLoader = Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: AppLoadingPanel(message: 'Cargando páginas…'),
    ),
  );

  Uint8List? _bytes;
  String _fileName = 'proforma.pdf';
  String? _error;
  bool _actionBusy = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    try {
      final proforma = await ref
          .read(proformaServiceProvider)
          .getById(widget.proformaId);
      if (proforma == null) {
        throw StateError('Proforma no encontrada');
      }
      final bytes =
          await ref.read(proformaPdfServiceProvider).buildBytes(proforma);
      if (!mounted) return;
      setState(() {
        _bytes = bytes;
        _fileName = '${proforma.code}.pdf';
        _error = null;
      });
    } catch (error, stackTrace) {
      debugPrint('PDF preview load failed: $error\n$stackTrace');
      if (!mounted) return;
      setState(() => _error = 'No se pudo generar el PDF');
    }
  }

  Future<void> _share() async {
    final bytes = _bytes;
    if (bytes == null || _actionBusy) return;
    setState(() => _actionBusy = true);
    try {
      await Printing.sharePdf(bytes: bytes, filename: _fileName);
    } catch (error, stackTrace) {
      debugPrint('PDF share failed: $error\n$stackTrace');
      if (mounted) {
        AppToast.error(context, 'No se pudo compartir el PDF');
      }
    } finally {
      if (mounted) setState(() => _actionBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text('Vista previa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody(theme, colorScheme, isDark)),
          if (_bytes != null) _buildActions(colorScheme, isDark),
        ],
      ),
    );
  }

  Widget _buildBody(
    ThemeData theme,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.picture_as_pdf_outlined,
                size: 40,
                color: colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _error = null;
                    _bytes = null;
                  });
                  _load();
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (_bytes == null) return _loader;

    return PdfPreview(
      build: (_) async => _bytes!,
      initialPageFormat: PdfPageFormat.a4,
      canChangePageFormat: false,
      canChangeOrientation: false,
      canDebug: false,
      allowPrinting: false,
      allowSharing: false,
      useActions: false,
      dynamicLayout: false,
      pdfFileName: _fileName,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      previewPageMargin: const EdgeInsets.symmetric(vertical: 8),
      scrollViewDecoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(
          alpha: isDark ? 0.35 : 0.45,
        ),
      ),
      pdfPreviewPageDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.35 : 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      loadingWidget: _pagesLoader,
      onError: (context, error) => Center(
        child: Text(
          'No se pudo mostrar el PDF',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.error,
          ),
        ),
      ),
    );
  }

  Widget _buildActions(ColorScheme colorScheme, bool isDark) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: AcrylicSurface(
          borderRadius: BorderRadius.circular(18),
          blur: 18,
          shadow: true,
          opacity: isDark ? 0.22 : 0.16,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppButton(
              label: 'Compartir',
              icon: Icons.ios_share_rounded,
              isLoading: _actionBusy,
              onPressed: _actionBusy ? null : _share,
            ),
          ),
        ),
      ),
    );
  }
}
