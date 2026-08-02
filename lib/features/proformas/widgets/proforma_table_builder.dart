import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/theme/app_motion.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../settings/models/measure_unit.dart';
import '../../settings/models/payment_method_type.dart';
import '../../../core/database/app_database.dart';
import '../../settings/providers/settings_providers.dart';
import '../models/proforma_document.dart';
import '../models/proforma_totals.dart';

typedef ProformaDocumentChanged = void Function(ProformaDocument document);

/// Paso horizontal único entre niveles (sección → subsección → fila).
const double _indentStep = 16;

/// Builder de documento: tablas, texto, perfil y medios de pago.
class ProformaTableBuilder extends StatelessWidget {
  const ProformaTableBuilder({
    super.key,
    required this.document,
    required this.defaultUnit,
    required this.onChanged,
  });

  final ProformaDocument document;
  final MeasureUnit defaultUnit;
  final ProformaDocumentChanged onChanged;

  List<ProformaBlock> get _blocks => List<ProformaBlock>.from(document.blocks);

  void _emit(List<ProformaBlock> blocks) {
    onChanged(document.copyWith(blocks: blocks));
  }

  void _replaceBlock(ProformaBlock block) {
    _emit([
      for (final item in _blocks)
        if (item.id == block.id) block else item,
    ]);
  }

  void _removeBlock(String blockId) {
    _emit(_blocks.where((block) => block.id != blockId).toList());
  }

  void _addBlock(ProformaBlock block) {
    _emit([..._blocks, block]);
  }

  List<_AddAction> _documentActions() {
    final hasProfile = _blocks.any((b) => b is ProformaProfileBlock);
    final hasPayments = _blocks.any((b) => b is ProformaPaymentMethodsBlock);
    return [
      const _AddAction(
        id: 'table',
        label: 'Tabla',
        icon: Icons.table_chart_outlined,
      ),
      const _AddAction(
        id: 'text',
        label: 'Texto',
        icon: Icons.notes_rounded,
      ),
      if (!hasProfile)
        const _AddAction(
          id: 'profile',
          label: 'Perfil',
          icon: Icons.person_outline_rounded,
        ),
      if (!hasPayments)
        const _AddAction(
          id: 'payment',
          label: 'Medios de pago',
          icon: Icons.payments_outlined,
        ),
    ];
  }

  void _onDocumentAction(String id) {
    switch (id) {
      case 'table':
        _addBlock(ProformaTableBlock.create());
      case 'text':
        _addBlock(ProformaTextBlock.create());
      case 'profile':
        _addBlock(ProformaProfileBlock.create());
      case 'payment':
        _addBlock(ProformaPaymentMethodsBlock.create());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actions = _documentActions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Documento', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Agrega tablas, textos, perfil o medios de pago al documento.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 14),
        for (final block in _blocks) ...[
          switch (block) {
            final ProformaTableBlock table => _TableBlock(
                table: table,
                defaultUnit: defaultUnit,
                onChanged: _replaceBlock,
                onRemove: () => _removeBlock(table.id),
              ),
            final ProformaTextBlock text => _TextBlockEditor(
                block: text,
                onChanged: _replaceBlock,
                onRemove: () => _removeBlock(text.id),
              ),
            final ProformaProfileBlock profile => _ProfileBlockPreview(
                onRemove: () => _removeBlock(profile.id),
              ),
            final ProformaPaymentMethodsBlock payment =>
              _PaymentMethodsBlockPreview(
                onRemove: () => _removeBlock(payment.id),
              ),
          },
          const SizedBox(height: 14),
        ],
        if (_blocks.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'El documento está vacío. Agrega el primer bloque.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
        AppButton(
          label: _blocks.isEmpty ? 'Agregar bloque' : 'Agregar otro bloque',
          icon: Icons.add_rounded,
          onPressed: () => _openDocumentMenu(context, actions),
        ),
      ],
    );
  }

  Future<void> _openDocumentMenu(
    BuildContext context,
    List<_AddAction> actions,
  ) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final action in actions)
                ListTile(
                  leading: Icon(action.icon),
                  title: Text(action.label),
                  onTap: () => Navigator.of(sheetContext).pop(action.id),
                ),
            ],
          ),
        );
      },
    );
    if (selected != null) _onDocumentAction(selected);
  }
}

class _TextBlockEditor extends ConsumerStatefulWidget {
  const _TextBlockEditor({
    required this.block,
    required this.onChanged,
    required this.onRemove,
  });

  final ProformaTextBlock block;
  final ValueChanged<ProformaBlock> onChanged;
  final VoidCallback onRemove;

  @override
  ConsumerState<_TextBlockEditor> createState() => _TextBlockEditorState();
}

class _TextBlockEditorState extends ConsumerState<_TextBlockEditor> {
  late final TextEditingController _contentController;
  late final FocusNode _contentFocus;
  bool _picking = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.block.content);
    _contentFocus = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _TextBlockEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.block.id != widget.block.id) {
      _contentController.text = widget.block.content;
    } else if (widget.block.content != _contentController.text &&
        !_contentFocus.hasFocus) {
      _contentController.text = widget.block.content;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _contentFocus.dispose();
    super.dispose();
  }

  void _emitContent() {
    widget.onChanged(widget.block.copyWith(content: _contentController.text));
  }

  Future<void> _pickEmoji() async {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: colorScheme.surface,
      constraints: BoxConstraints(
        minWidth: screenWidth,
        maxWidth: screenWidth,
        maxHeight: 420,
      ),
      builder: (sheetContext) {
        return Material(
          color: colorScheme.surface,
          child: SizedBox(
            width: screenWidth,
            height: 360,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                Navigator.of(sheetContext).pop(emoji.emoji);
              },
              config: Config(
                height: 360,
                // En algunos Android el filtro nativo deja el picker en blanco.
                checkPlatformCompatibility: false,
                viewOrderConfig: const ViewOrderConfig(
                  top: EmojiPickerItem.categoryBar,
                  middle: EmojiPickerItem.emojiView,
                  bottom: EmojiPickerItem.searchBar,
                ),
                emojiViewConfig: EmojiViewConfig(
                  backgroundColor: colorScheme.surface,
                  columns: 8,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  noRecents: Text(
                    'Sin recientes',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface.withValues(alpha: 0.45),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                categoryViewConfig: CategoryViewConfig(
                  initCategory: Category.SMILEYS,
                  recentTabBehavior: RecentTabBehavior.NONE,
                  backgroundColor: colorScheme.surface,
                  indicatorColor: colorScheme.primary,
                  iconColorSelected: colorScheme.primary,
                  iconColor: colorScheme.onSurface.withValues(alpha: 0.55),
                  dividerColor: colorScheme.outline.withValues(alpha: 0.2),
                ),
                searchViewConfig: SearchViewConfig(
                  backgroundColor: colorScheme.surface,
                  buttonIconColor: colorScheme.onSurface,
                ),
                bottomActionBarConfig: const BottomActionBarConfig(
                  enabled: false,
                ),
                skinToneConfig: const SkinToneConfig(enabled: false),
              ),
            ),
          ),
        );
      },
    );
    if (selected == null || !mounted) return;
    widget.onChanged(widget.block.copyWith(emoji: selected));
  }

  void _clearEmoji() {
    widget.onChanged(widget.block.copyWith(clearEmoji: true));
  }

  Future<void> _addImage() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (file == null) return;
      final storage = ref.read(localImageStorageProvider);
      final path = await storage.saveImage(
        source: File(file.path),
        folder: 'proforma_text',
        fileName: '${widget.block.id}_${DateTime.now().millisecondsSinceEpoch}',
      );
      widget.onChanged(
        widget.block.copyWith(
          imagePaths: [...widget.block.imagePaths, path],
        ),
      );
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _removeImage(String path) async {
    final next = widget.block.imagePaths.where((item) => item != path).toList();
    widget.onChanged(widget.block.copyWith(imagePaths: next));
    await ref.read(localImageStorageProvider).deleteIfExists(path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final block = widget.block;
    final title = (block.title ?? '').trim().isEmpty
        ? 'Sin título'
        : block.title!.trim();
    final emoji = (block.emoji ?? '').trim();
    final hasEmoji = emoji.isNotEmpty;

    return AcrylicSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _TypeChip(label: 'Texto', tone: _ChipTone.text),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar texto',
                onPressed: widget.onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Tooltip(
                message: hasEmoji
                    ? 'Cambiar emoji (mantener para quitar)'
                    : 'Elegir emoji',
                child: Material(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _pickEmoji,
                    onLongPress: hasEmoji ? _clearEmoji : null,
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: Center(
                        child: hasEmoji
                            ? Text(emoji, style: const TextStyle(fontSize: 26))
                            : Icon(
                                Icons.emoji_emotions_outlined,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BoundField(
                  key: ValueKey('text_title_${block.id}'),
                  label: 'Título',
                  initialValue: block.title ?? '',
                  onChanged: (value) {
                    final trimmed = value.trim();
                    widget.onChanged(
                      trimmed.isEmpty
                          ? block.copyWith(clearTitle: true)
                          : block.copyWith(title: value),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _contentController,
            focusNode: _contentFocus,
            minLines: 5,
            maxLines: 10,
            inputFormatters: const [_MarkdownBulletInputFormatter()],
            onChanged: (_) => _emitContent(),
            decoration: const InputDecoration(
              labelText: 'Contenido',
              alignLabelWithHint: true,
              isDense: true,
              hintText: 'Escribe aquí…\n- Viñeta',
            ),
          ),
          const SizedBox(height: 12),
          if (block.imagePaths.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final path in block.imagePaths)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(path),
                          width: 88,
                          height: 88,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 88,
                            height: 88,
                            color: colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -8,
                        right: -8,
                        child: IconButton.filledTonal(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _removeImage(path),
                          icon: const Icon(Icons.close_rounded, size: 16),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          OutlinedButton.icon(
            onPressed: _picking ? null : _addImage,
            icon: _picking
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.add_photo_alternate_outlined),
            label: Text(_picking ? 'Agregando…' : 'Agregar imagen'),
          ),
        ],
      ),
    );
  }
}

/// Continúa viñetas markdown (`- ` / `* `) al pulsar Enter; sale con viñeta vacía.
class _MarkdownBulletInputFormatter extends TextInputFormatter {
  const _MarkdownBulletInputFormatter();

  static const _prefix = '- ';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length != oldValue.text.length + 1) return newValue;
    final cursor = newValue.selection.baseOffset;
    if (cursor <= 0 || newValue.text[cursor - 1] != '\n') return newValue;

    final before = newValue.text.substring(0, cursor - 1);
    final lineStart = before.lastIndexOf('\n') + 1;
    final prevLine = before.substring(lineStart);
    final isBullet = prevLine.startsWith(_prefix) || prevLine.startsWith('* ');
    if (!isBullet) return newValue;

    if (prevLine == _prefix || prevLine == '* ') {
      final without = newValue.text.replaceRange(lineStart, cursor, '');
      return TextEditingValue(
        text: without,
        selection: TextSelection.collapsed(offset: lineStart),
      );
    }

    final withBullet = newValue.text.replaceRange(cursor, cursor, _prefix);
    return TextEditingValue(
      text: withBullet,
      selection: TextSelection.collapsed(offset: cursor + _prefix.length),
    );
  }
}

class _ProfileBlockPreview extends ConsumerWidget {
  const _ProfileBlockPreview({required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailAsync = ref.watch(userDetailProvider);

    return AcrylicSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _TypeChip(label: 'Perfil', tone: _ChipTone.profile),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Datos del contacto',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar bloque',
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Se muestra el perfil guardado en Configuración.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 12),
          detailAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (_, _) => Text(
              'No se pudo cargar el perfil.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            data: (detail) {
              if (detail == null) {
                return Text(
                  'Completa tu perfil en Configuración para verlo aquí.',
                  style: theme.textTheme.bodyMedium,
                );
              }
              final name = [
                detail.firstName,
                detail.lastName,
              ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' ');
              final lines = <String>[
                if (name.isNotEmpty) name,
                if ((detail.phone ?? '').trim().isNotEmpty) detail.phone!,
                if ((detail.email ?? '').trim().isNotEmpty) detail.email!,
                if ((detail.dni ?? '').trim().isNotEmpty) 'DNI ${detail.dni}',
                if ((detail.ruc ?? '').trim().isNotEmpty) 'RUC ${detail.ruc}',
              ];
              final photo = detail.photoPath;
              final hasPhoto = photo != null && File(photo).existsSync();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        hasPhoto ? FileImage(File(photo)) : null,
                    child: hasPhoto
                        ? null
                        : const Icon(Icons.person_outline_rounded),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: lines.isEmpty
                        ? Text(
                            'Perfil sin datos aún.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.55),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final line in lines)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(line),
                                ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodsBlockPreview extends ConsumerWidget {
  const _PaymentMethodsBlockPreview({required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final methodsAsync = ref.watch(paymentMethodsProvider);

    return AcrylicSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _TypeChip(label: 'Pagos', tone: _ChipTone.payment),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Medios de pago',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar bloque',
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Se listan los medios activos de Configuración.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 12),
          methodsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (_, _) => Text(
              'No se pudieron cargar los medios de pago.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            data: (methods) {
              if (methods.isEmpty) {
                return Text(
                  'Aún no hay medios de pago. Agrégalos en Configuración.',
                  style: theme.textTheme.bodyMedium,
                );
              }
              return Column(
                children: [
                  for (final method in methods) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          switch (PaymentMethodType.fromCode(method.type)) {
                            PaymentMethodType.yape => Icons.qr_code_2_rounded,
                            PaymentMethodType.plin => Icons.bolt_rounded,
                            PaymentMethodType.bankAccount =>
                              Icons.account_balance_outlined,
                          },
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _paymentSubtitle(method),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (method != methods.last) const SizedBox(height: 10),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _paymentSubtitle(PaymentMethod method) {
    final type = PaymentMethodType.fromCode(method.type);
    final extra = switch (type) {
      PaymentMethodType.yape || PaymentMethodType.plin =>
        method.phone ?? 'Sin teléfono',
      PaymentMethodType.bankAccount => [
          if (method.accountNumber != null)
            'Cuenta ${method.accountNumber}',
          if (method.interbankNumber != null)
            'CCI ${method.interbankNumber}',
        ].join(' · '),
    };
    return '${type.label}${extra.isEmpty ? '' : ' · $extra'}';
  }
}

class _TableBlock extends StatelessWidget {
  const _TableBlock({
    required this.table,
    required this.defaultUnit,
    required this.onChanged,
    required this.onRemove,
  });

  final ProformaTableBlock table;
  final MeasureUnit defaultUnit;
  final ValueChanged<ProformaBlock> onChanged;
  final VoidCallback onRemove;

  void _updateSection(ProformaSection section) {
    onChanged(
      table.copyWith(
        sections: [
          for (final item in table.sections)
            if (item.id == section.id) section else item,
        ],
      ),
    );
  }

  void _addSection() {
    onChanged(
      table.copyWith(sections: [...table.sections, ProformaSection.create()]),
    );
  }

  void _removeSection(String sectionId) {
    onChanged(
      table.copyWith(
        sections: table.sections.where((s) => s.id != sectionId).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title =
        table.name.trim().isEmpty ? 'Sin nombre' : table.name.trim();

    return AcrylicSurface(
      padding: const EdgeInsets.all(16),
      child: _CollapseHost(
        key: ValueKey('table_${table.id}'),
        initiallyExpanded: true,
        headerBuilder: (context, expanded, toggle) {
          return _BlockHeader(
            chip: const _TypeChip(label: 'Tabla', tone: _ChipTone.table),
            title: title,
            expanded: expanded,
            onToggle: toggle,
            trailing: [
              _AddMenuButton(
                tooltip: 'Agregar en tabla',
                items: const [
                  _AddAction(
                    id: 'section',
                    label: 'Sección',
                    icon: Icons.view_agenda_outlined,
                  ),
                ],
                onSelected: (_) => _addSection(),
              ),
              IconButton(
                tooltip: 'Eliminar tabla',
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          );
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BoundField(
                key: ValueKey('table_name_${table.id}'),
                label: 'Nombre de la tabla',
                initialValue: table.name,
                onChanged: (value) => onChanged(table.copyWith(name: value)),
              ),
              const SizedBox(height: 14),
              for (final section in table.sections) ...[
                _SectionBlock(
                  section: section,
                  defaultUnit: defaultUnit,
                  onChanged: _updateSection,
                  onRemove: () => _removeSection(section.id),
                ),
                const SizedBox(height: 12),
              ],
              if (table.sections.isEmpty)
                Text(
                  'Agrega una sección con el botón +',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.section,
    required this.defaultUnit,
    required this.onChanged,
    required this.onRemove,
  });

  final ProformaSection section;
  final MeasureUnit defaultUnit;
  final ValueChanged<ProformaSection> onChanged;
  final VoidCallback onRemove;

  void _setRows(List<ProformaTableRow> rows) {
    onChanged(section.copyWith(rows: rows));
  }

  void _addItem() {
    if (section.usesSubsections) return;
    _setRows(
      ProformaTotals.insertItem(
        section.rows,
        ProformaItemRow.create(defaultUnit: defaultUnit.code),
      ),
    );
  }

  void _addSubsection() {
    if (section.usesItems) return;
    onChanged(
      section.copyWith(
        subsections: [...section.subsections, ProformaSubsection.create()],
      ),
    );
  }

  void _addSum() {
    if (!ProformaTotals.canAddSum(section.rows)) return;
    final isChain = ProformaTotals.hasAnySum(section.rows);
    _setRows([
      ...section.rows,
      ProformaSumRow.create(
        targetId: section.id,
        target: isChain
            ? ProformaSumTarget.chain
            : ProformaSumTarget.section,
      ),
    ]);
  }

  Future<void> _addDiscount(BuildContext context) async {
    if (!ProformaTotals.canAddDiscount(section.rows)) return;
    final sum = section.rows.whereType<ProformaSumRow>().lastOrNull;
    if (sum == null) return;
    final base = ProformaTotals.sumValue(
      sum: sum,
      section: section,
      rows: section.rows,
    );
    final amount = await _askDiscountAmount(context, baseAmount: base);
    if (amount == null) return;
    _setRows([...section.rows, ProformaDiscountRow.create(amount: amount)]);
  }

  List<_AddAction> _actions() {
    final hasScopeItems = section.usesSubsections
        ? section.subsections.any(
            (sub) => sub.rows.any((row) => row is ProformaItemRow),
          )
        : section.usesItems;

    final actions = <_AddAction>[];

    if (section.usesSubsections) {
      actions.add(
        const _AddAction(
          id: 'subsection',
          label: 'Subsección',
          icon: Icons.subdirectory_arrow_right_rounded,
        ),
      );
      if ((hasScopeItems || ProformaTotals.hasAnySum(section.rows)) &&
          ProformaTotals.canAddSum(section.rows)) {
        actions.add(
          _AddAction(
            id: 'sum',
            label: ProformaTotals.hasAnySum(section.rows)
                ? 'Suma neta'
                : 'Suma de sección',
            icon: Icons.functions_rounded,
          ),
        );
      }
      if (ProformaTotals.canAddDiscount(section.rows)) {
        actions.add(
          const _AddAction(
            id: 'discount',
            label: 'Descuento',
            icon: Icons.percent_rounded,
          ),
        );
      }
      return actions;
    }

    actions.add(
      const _AddAction(
        id: 'item',
        label: 'Ítem',
        icon: Icons.notes_rounded,
      ),
    );
    if (section.isEmpty) {
      actions.add(
        const _AddAction(
          id: 'subsection',
          label: 'Subsección',
          icon: Icons.account_tree_outlined,
        ),
      );
    }
    if (section.usesItems) {
      actions.add(
        const _AddAction(
          id: 'wrap',
          label: 'Englobar en subsección',
          icon: Icons.wrap_text_rounded,
        ),
      );
    }
    if (hasScopeItems && ProformaTotals.canAddSum(section.rows)) {
      actions.add(
        _AddAction(
          id: 'sum',
          label: ProformaTotals.hasAnySum(section.rows)
              ? 'Suma neta'
              : 'Suma',
          icon: Icons.functions_rounded,
        ),
      );
    }
    if (ProformaTotals.canAddDiscount(section.rows)) {
      actions.add(
        const _AddAction(
          id: 'discount',
          label: 'Descuento',
          icon: Icons.percent_rounded,
        ),
      );
    }
    return actions;
  }

  Future<void> _onAction(BuildContext context, String id) async {
    switch (id) {
      case 'item':
        _addItem();
      case 'subsection':
        _addSubsection();
      case 'wrap':
        onChanged(section.wrapItemsInSubsection());
      case 'sum':
        _addSum();
      case 'discount':
        await _addDiscount(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = section.description.trim().isEmpty
        ? 'Sin descripción'
        : section.description.trim();
    final actions = _actions();

    return _CollapseHost(
      initiallyExpanded: false,
      headerBuilder: (context, expanded, toggle) {
        return _BlockHeader(
          chip: const _TypeChip(label: 'Sección', tone: _ChipTone.section),
          title: title,
          expanded: expanded,
          onToggle: toggle,
          trailing: [
            if (actions.isNotEmpty)
              _AddMenuButton(
                tooltip: 'Agregar en sección',
                items: actions,
                onSelected: (id) => _onAction(context, id),
              ),
            IconButton(
              tooltip: 'Eliminar sección',
              onPressed: onRemove,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BoundField(
              key: ValueKey('sec_desc_${section.id}'),
              label: 'Descripción de la sección',
              initialValue: section.description,
              onChanged: (value) =>
                  onChanged(section.copyWith(description: value)),
            ),
            if (section.usesSubsections) ...[
              for (final sub in section.subsections) ...[
                const SizedBox(height: 12),
                _SubsectionBlock(
                  section: section,
                  subsection: sub,
                  defaultUnit: defaultUnit,
                  onChanged: (updated) {
                    onChanged(
                      section.copyWith(
                        subsections: [
                          for (final item in section.subsections)
                            if (item.id == updated.id) updated else item,
                        ],
                      ),
                    );
                  },
                  onRemove: () {
                    onChanged(
                      section.copyWith(
                        subsections: section.subsections
                            .where((item) => item.id != sub.id)
                            .toList(),
                      ),
                    );
                  },
                ),
              ],
              ..._financeOnlyRows(
                rows: section.rows,
                section: section,
                onRowsChanged: _setRows,
                indent: _indentStep,
              ),
            ] else ...[
              ..._contentRows(
                rows: section.rows,
                section: section,
                defaultUnit: defaultUnit,
                onRowsChanged: _setRows,
                indent: _indentStep,
              ),
            ],
            if (actions.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Agrega un ítem o una subsección con el botón +',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SubsectionBlock extends StatelessWidget {
  const _SubsectionBlock({
    required this.section,
    required this.subsection,
    required this.defaultUnit,
    required this.onChanged,
    required this.onRemove,
  });

  final ProformaSection section;
  final ProformaSubsection subsection;
  final MeasureUnit defaultUnit;
  final ValueChanged<ProformaSubsection> onChanged;
  final VoidCallback onRemove;

  void _setRows(List<ProformaTableRow> rows) {
    onChanged(subsection.copyWith(rows: rows));
  }

  void _addItem() {
    _setRows(
      ProformaTotals.insertItem(
        subsection.rows,
        ProformaItemRow.create(defaultUnit: defaultUnit.code),
      ),
    );
  }

  void _addSum() {
    if (!ProformaTotals.canAddSum(subsection.rows)) return;
    final isChain = ProformaTotals.hasAnySum(subsection.rows);
    _setRows([
      ...subsection.rows,
      ProformaSumRow.create(
        targetId: subsection.id,
        target: isChain
            ? ProformaSumTarget.chain
            : ProformaSumTarget.subsection,
      ),
    ]);
  }

  Future<void> _addDiscount(BuildContext context) async {
    if (!ProformaTotals.canAddDiscount(subsection.rows)) return;
    final sum = subsection.rows.whereType<ProformaSumRow>().lastOrNull;
    if (sum == null) return;
    final base = ProformaTotals.sumValue(
      sum: sum,
      section: section,
      subsection: subsection,
      rows: subsection.rows,
    );
    final amount = await _askDiscountAmount(context, baseAmount: base);
    if (amount == null) return;
    _setRows([
      ...subsection.rows,
      ProformaDiscountRow.create(amount: amount),
    ]);
  }

  List<_AddAction> _actions() {
    final hasItems = subsection.rows.any((row) => row is ProformaItemRow);
    final actions = <_AddAction>[
      const _AddAction(
        id: 'item',
        label: 'Ítem',
        icon: Icons.notes_rounded,
      ),
    ];
    if (hasItems && ProformaTotals.canAddSum(subsection.rows)) {
      actions.add(
        _AddAction(
          id: 'sum',
          label: ProformaTotals.hasAnySum(subsection.rows)
              ? 'Suma neta'
              : 'Suma',
          icon: Icons.functions_rounded,
        ),
      );
    }
    if (ProformaTotals.canAddDiscount(subsection.rows)) {
      actions.add(
        const _AddAction(
          id: 'discount',
          label: 'Descuento',
          icon: Icons.percent_rounded,
        ),
      );
    }
    return actions;
  }

  Future<void> _onAction(BuildContext context, String id) async {
    switch (id) {
      case 'item':
        _addItem();
      case 'sum':
        _addSum();
      case 'discount':
        await _addDiscount(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = subsection.description.trim().isEmpty
        ? 'Sin descripción'
        : subsection.description.trim();
    final actions = _actions();

    return Padding(
      padding: const EdgeInsets.only(left: _indentStep),
      child: _CollapseHost(
        initiallyExpanded: false,
        headerBuilder: (context, expanded, toggle) {
          return _BlockHeader(
            chip: const _TypeChip(
              label: 'Subsección',
              tone: _ChipTone.subsection,
            ),
            title: title,
            expanded: expanded,
            onToggle: toggle,
            trailing: [
              _AddMenuButton(
                tooltip: 'Agregar en subsección',
                items: actions,
                onSelected: (id) => _onAction(context, id),
              ),
              IconButton(
                tooltip: 'Eliminar subsección',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          );
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BoundField(
                key: ValueKey('sub_desc_${subsection.id}'),
                label: 'Descripción de la subsección',
                initialValue: subsection.description,
                onChanged: (value) =>
                    onChanged(subsection.copyWith(description: value)),
              ),
              ..._contentRows(
                rows: subsection.rows,
                section: section,
                subsection: subsection,
                defaultUnit: defaultUnit,
                onRowsChanged: _setRows,
                indent: _indentStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _contentRows({
  required List<ProformaTableRow> rows,
  required ProformaSection section,
  required MeasureUnit defaultUnit,
  required ValueChanged<List<ProformaTableRow>> onRowsChanged,
  required double indent,
  ProformaSubsection? subsection,
}) {
  return [
    for (final row in rows) ...[
      const SizedBox(height: 10),
      if (row is ProformaItemRow)
        _ItemRow(
          item: row,
          indent: indent,
          onChanged: (updated) {
            onRowsChanged([
              for (final item in rows)
                if (item.id == updated.id) updated else item,
            ]);
          },
          onRemove: () =>
              onRowsChanged(ProformaTotals.removeRow(rows, row.id)),
        )
      else if (row is ProformaSumRow || row is ProformaDiscountRow)
        _FinanceRow(
          row: row,
          rows: rows,
          section: section,
          subsection: subsection,
          indent: indent,
          onChanged: (updated) {
            onRowsChanged([
              for (final item in rows)
                if (item.id == updated.id) updated else item,
            ]);
          },
          onRemove: () =>
              onRowsChanged(ProformaTotals.removeRow(rows, row.id)),
        ),
    ],
  ];
}

List<Widget> _financeOnlyRows({
  required List<ProformaTableRow> rows,
  required ProformaSection section,
  required ValueChanged<List<ProformaTableRow>> onRowsChanged,
  required double indent,
}) {
  final finance = rows.where(
    (row) => row is ProformaSumRow || row is ProformaDiscountRow,
  );
  return [
    for (final row in finance) ...[
      const SizedBox(height: 10),
      _FinanceRow(
        row: row,
        rows: rows,
        section: section,
        indent: indent,
        onChanged: (updated) {
          onRowsChanged([
            for (final item in rows)
              if (item.id == updated.id) updated else item,
          ]);
        },
        onRemove: () => onRowsChanged(ProformaTotals.removeRow(rows, row.id)),
      ),
    ],
  ];
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.item,
    required this.onChanged,
    required this.onRemove,
    this.indent = 0,
  });

  final ProformaItemRow item;
  final ValueChanged<ProformaItemRow> onChanged;
  final VoidCallback onRemove;
  final double indent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _TypeChip(label: 'Ítem', tone: _ChipTone.item),
              const Spacer(),
              Text(
                'Total ${_money(item.total)}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                tooltip: 'Eliminar ítem',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _BoundField(
            key: ValueKey('item_desc_${item.id}'),
            label: 'Descripción',
            initialValue: item.description,
            onChanged: (value) => onChanged(item.copyWith(description: value)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _BoundField(
                  key: ValueKey('item_qty_${item.id}'),
                  label: 'Cantidad',
                  initialValue: _stripTrailingZeros(item.quantity),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  onChanged: (value) {
                    final parsed = double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null) return;
                    onChanged(item.copyWith(quantity: parsed));
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _BoundField(
                  key: ValueKey('item_price_${item.id}'),
                  label: 'P. unitario',
                  initialValue: _stripTrailingZeros(item.unitPrice),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  onChanged: (value) {
                    final parsed = double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null) return;
                    onChanged(item.copyWith(unitPrice: parsed));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [
              for (final unit in MeasureUnit.values)
                ChoiceChip(
                  label: Text(unit.code),
                  selected: item.unit == unit.code,
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) =>
                      onChanged(item.copyWith(unit: unit.code)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinanceRow extends StatelessWidget {
  const _FinanceRow({
    required this.row,
    required this.rows,
    required this.section,
    required this.onChanged,
    required this.onRemove,
    this.subsection,
    this.indent = 0,
  });

  final ProformaTableRow row;
  final List<ProformaTableRow> rows;
  final ProformaSection section;
  final ProformaSubsection? subsection;
  final ValueChanged<ProformaTableRow> onChanged;
  final VoidCallback onRemove;
  final double indent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (row is ProformaSumRow) {
      final sum = row as ProformaSumRow;
      final value = ProformaTotals.sumValue(
        sum: sum,
        section: section,
        subsection: subsection,
        rows: rows,
      );
      final net = ProformaTotals.chainNet(
        rows: rows,
        sum: sum,
        sumAmount: value,
      );
      final isChain = sum.target == ProformaSumTarget.chain;

      return Padding(
        padding: EdgeInsets.only(left: indent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _TypeChip(
                  label: isChain ? 'Suma neta' : 'Suma',
                  tone: _ChipTone.sum,
                ),
                const Spacer(),
                Text(
                  _money(value),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close_rounded, size: 20),
                ),
              ],
            ),
            _BoundField(
              key: ValueKey('sum_label_${sum.id}'),
              label: 'Etiqueta',
              initialValue: sum.label,
              onChanged: (value) => onChanged(sum.copyWith(label: value)),
            ),
            if (!isChain && net != value) ...[
              const SizedBox(height: 6),
              Text(
                'Neto tras descuentos: ${_money(net)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      );
    }

    final discount = row as ProformaDiscountRow;
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _TypeChip(label: 'Descuento', tone: _ChipTone.discount),
              const Spacer(),
              Text(
                '-${_money(discount.amount)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.error,
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          _BoundField(
            key: ValueKey('disc_label_${discount.id}'),
            label: 'Etiqueta',
            initialValue: discount.label,
            onChanged: (value) => onChanged(discount.copyWith(label: value)),
          ),
        ],
      ),
    );
  }
}

enum _ChipTone {
  table,
  section,
  subsection,
  item,
  sum,
  discount,
  text,
  profile,
  payment,
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.label, required this.tone});

  final String label;
  final _ChipTone tone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = switch (tone) {
      _ChipTone.table => colorScheme.primary,
      _ChipTone.section => colorScheme.tertiary,
      _ChipTone.subsection => colorScheme.secondary,
      _ChipTone.item => colorScheme.outline,
      _ChipTone.sum => colorScheme.primary,
      _ChipTone.discount => colorScheme.error,
      _ChipTone.text => colorScheme.secondary,
      _ChipTone.profile => colorScheme.tertiary,
      _ChipTone.payment => colorScheme.primary,
    };

    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
    );
  }
}

class _BlockHeader extends StatelessWidget {
  const _BlockHeader({
    required this.chip,
    required this.title,
    required this.expanded,
    required this.onToggle,
    this.trailing = const [],
  });

  final Widget chip;
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: onToggle,
          icon: AnimatedRotation(
            turns: expanded ? 0.5 : 0,
            duration: AppMotion.fast,
            child: const Icon(Icons.expand_more_rounded),
          ),
        ),
        chip,
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        ...trailing,
      ],
    );
  }
}

class _CollapseHost extends StatefulWidget {
  const _CollapseHost({
    super.key,
    required this.initiallyExpanded,
    required this.headerBuilder,
    required this.body,
  });

  final bool initiallyExpanded;
  final Widget Function(
    BuildContext context,
    bool expanded,
    VoidCallback toggle,
  ) headerBuilder;
  final Widget body;

  @override
  State<_CollapseHost> createState() => _CollapseHostState();
}

class _CollapseHostState extends State<_CollapseHost> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.headerBuilder(context, _expanded, _toggle),
        if (_expanded) widget.body,
      ],
    );
  }
}

class _AddAction {
  const _AddAction({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class _AddMenuButton extends StatelessWidget {
  const _AddMenuButton({
    required this.items,
    required this.onSelected,
    required this.tooltip,
  });

  final List<_AddAction> items;
  final ValueChanged<String> onSelected;
  final String tooltip;

  Future<void> _open(BuildContext context) async {
    if (items.isEmpty) return;
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final action in items)
                ListTile(
                  leading: Icon(action.icon),
                  title: Text(action.label),
                  onTap: () => Navigator.of(sheetContext).pop(action.id),
                ),
            ],
          ),
        );
      },
    );
    if (selected != null) onSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: items.isEmpty ? null : () => _open(context),
      icon: const Icon(Icons.add_rounded),
    );
  }
}

Future<double?> _askDiscountAmount(
  BuildContext context, {
  required double baseAmount,
}) {
  return showDialog<double>(
    context: context,
    builder: (dialogContext) {
      return _DiscountAmountDialog(baseAmount: baseAmount);
    },
  );
}

enum _DiscountMode { fixed, percent }

class _DiscountAmountDialog extends StatefulWidget {
  const _DiscountAmountDialog({required this.baseAmount});

  final double baseAmount;

  @override
  State<_DiscountAmountDialog> createState() => _DiscountAmountDialogState();
}

class _DiscountAmountDialogState extends State<_DiscountAmountDialog> {
  final _controller = TextEditingController();
  _DiscountMode _mode = _DiscountMode.fixed;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (raw == null || raw <= 0) return;
    final amount = _mode == _DiscountMode.fixed
        ? raw
        : (widget.baseAmount * raw / 100);
    Navigator.of(context).pop(amount);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar descuento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Base de suma: ${widget.baseAmount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          SegmentedButton<_DiscountMode>(
            segments: const [
              ButtonSegment(
                value: _DiscountMode.fixed,
                label: Text('Monto'),
              ),
              ButtonSegment(
                value: _DiscountMode.percent,
                label: Text('%'),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (value) {
              setState(() => _mode = value.first);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              labelText: _mode == _DiscountMode.fixed
                  ? 'Monto a descontar'
                  : 'Porcentaje',
              suffixText: _mode == _DiscountMode.percent ? '%' : null,
            ),
            autofocus: true,
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}

class _BoundField extends StatefulWidget {
  const _BoundField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<_BoundField> createState() => _BoundFieldState();
}

class _BoundFieldState extends State<_BoundField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _BoundField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        isDense: true,
      ),
    );
  }
}

String _money(double value) => value.toStringAsFixed(2);

String _stripTrailingZeros(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toString();
}
