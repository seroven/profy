import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../settings/models/measure_unit.dart';
import '../models/proforma_document.dart';
import '../models/proforma_totals.dart';

typedef ProformaDocumentChanged = void Function(ProformaDocument document);

/// Builder de tablas: secciones → (ítems XOR subsecciones → ítems) + suma/dto.
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

  void _addTable() {
    _emit([..._blocks, ProformaTableBlock.create()]);
  }

  void _replaceTable(ProformaTableBlock table) {
    _emit([
      for (final block in _blocks)
        if (block.id == table.id) table else block,
    ]);
  }

  void _removeTable(String tableId) {
    _emit(_blocks.where((block) => block.id != tableId).toList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tables = document.tables;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Documento', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Agrega tablas con secciones, subsecciones, ítems, sumas y descuentos.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < tables.length; i++) ...[
          _TableCard(
            index: i + 1,
            table: tables[i],
            defaultUnit: defaultUnit,
            onChanged: _replaceTable,
            onRemove: () => _removeTable(tables[i].id),
          ),
          const SizedBox(height: 14),
        ],
        AppButton(
          label: tables.isEmpty ? 'Crear tabla' : 'Agregar otra tabla',
          icon: Icons.table_chart_outlined,
          onPressed: _addTable,
        ),
      ],
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({
    required this.index,
    required this.table,
    required this.defaultUnit,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final ProformaTableBlock table;
  final MeasureUnit defaultUnit;
  final ValueChanged<ProformaTableBlock> onChanged;
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

    return AcrylicSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tabla $index',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar tabla',
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _BoundField(
            key: ValueKey('table_name_${table.id}'),
            label: 'Nombre de la tabla',
            initialValue: table.name,
            onChanged: (value) => onChanged(table.copyWith(name: value)),
          ),
          const SizedBox(height: 12),
          for (final section in table.sections) ...[
            _SectionCard(
              section: section,
              defaultUnit: defaultUnit,
              onChanged: _updateSection,
              onRemove: () => _removeSection(section.id),
            ),
            const SizedBox(height: 12),
          ],
          OutlinedButton.icon(
            onPressed: _addSection,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Agregar sección'),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasScopeItems = section.usesSubsections
        ? section.subsections.any(
            (sub) => sub.rows.any((row) => row is ProformaItemRow),
          )
        : section.usesItems;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Sección',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar sección',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _BoundField(
            key: ValueKey('sec_desc_${section.id}'),
            label: 'Descripción de la sección',
            initialValue: section.description,
            onChanged: (value) =>
                onChanged(section.copyWith(description: value)),
          ),
          const SizedBox(height: 12),
          if (section.usesSubsections) ...[
            for (final sub in section.subsections) ...[
              _SubsectionCard(
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
              const SizedBox(height: 10),
            ],
            TextButton.icon(
              onPressed: _addSubsection,
              icon: const Icon(Icons.subdirectory_arrow_right_rounded),
              label: const Text('Agregar subsección'),
            ),
            const SizedBox(height: 8),
            _FinanceRows(
              rows: section.rows,
              section: section,
              onRowsChanged: _setRows,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if ((hasScopeItems || ProformaTotals.hasAnySum(section.rows)) &&
                    ProformaTotals.canAddSum(section.rows))
                  TextButton.icon(
                    onPressed: _addSum,
                    icon: const Icon(Icons.functions_rounded),
                    label: Text(
                      ProformaTotals.hasAnySum(section.rows)
                          ? 'Agregar suma neta'
                          : 'Agregar suma de sección',
                    ),
                  ),
                if (ProformaTotals.canAddDiscount(section.rows))
                  TextButton.icon(
                    onPressed: () => _addDiscount(context),
                    icon: const Icon(Icons.percent_rounded),
                    label: const Text('Agregar descuento'),
                  ),
              ],
            ),
          ] else ...[
            _ItemAndFinanceRows(
              rows: section.rows,
              section: section,
              defaultUnit: defaultUnit,
              onRowsChanged: _setRows,
              onAddItem: _addItem,
              onAddSum: hasScopeItems ? _addSum : null,
              onAddDiscount: () => _addDiscount(context),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (section.isEmpty)
                  TextButton.icon(
                    onPressed: _addSubsection,
                    icon: const Icon(Icons.account_tree_outlined),
                    label: const Text('Agregar subsección'),
                  ),
                if (section.usesItems)
                  TextButton.icon(
                    onPressed: () =>
                        onChanged(section.wrapItemsInSubsection()),
                    icon: const Icon(Icons.wrap_text_rounded),
                    label: const Text('Englobar en subsección'),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SubsectionCard extends StatelessWidget {
  const _SubsectionCard({
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasItems = subsection.rows.any((row) => row is ProformaItemRow);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Subsección',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar subsección',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          _BoundField(
            key: ValueKey('sub_desc_${subsection.id}'),
            label: 'Descripción de la subsección',
            initialValue: subsection.description,
            onChanged: (value) =>
                onChanged(subsection.copyWith(description: value)),
          ),
          const SizedBox(height: 10),
          _ItemAndFinanceRows(
            rows: subsection.rows,
            section: section,
            subsection: subsection,
            defaultUnit: defaultUnit,
            onRowsChanged: _setRows,
            onAddItem: _addItem,
            onAddSum: hasItems ? _addSum : null,
            onAddDiscount: () => _addDiscount(context),
          ),
        ],
      ),
    );
  }
}

class _ItemAndFinanceRows extends StatelessWidget {
  const _ItemAndFinanceRows({
    required this.rows,
    required this.section,
    required this.defaultUnit,
    required this.onRowsChanged,
    required this.onAddItem,
    required this.onAddDiscount,
    this.subsection,
    this.onAddSum,
  });

  final List<ProformaTableRow> rows;
  final ProformaSection section;
  final ProformaSubsection? subsection;
  final MeasureUnit defaultUnit;
  final ValueChanged<List<ProformaTableRow>> onRowsChanged;
  final VoidCallback onAddItem;
  final VoidCallback? onAddSum;
  final VoidCallback onAddDiscount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final row in rows) ...[
          if (row is ProformaItemRow) ...[
            _ItemCard(
              item: row,
              onChanged: (updated) {
                onRowsChanged([
                  for (final item in rows)
                    if (item.id == updated.id) updated else item,
                ]);
              },
              onRemove: () {
                onRowsChanged(rows.where((item) => item.id != row.id).toList());
              },
            ),
            const SizedBox(height: 8),
          ] else if (row is ProformaSumRow || row is ProformaDiscountRow) ...[
            _FinanceRowCard(
              row: row,
              rows: rows,
              section: section,
              subsection: subsection,
              onChanged: (updated) {
                onRowsChanged([
                  for (final item in rows)
                    if (item.id == updated.id) updated else item,
                ]);
              },
              onRemove: () {
                onRowsChanged(ProformaTotals.removeRow(rows, row.id));
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            TextButton.icon(
              onPressed: onAddItem,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Agregar ítem'),
            ),
            if (onAddSum != null && ProformaTotals.canAddSum(rows))
              TextButton.icon(
                onPressed: onAddSum,
                icon: const Icon(Icons.functions_rounded),
                label: Text(
                  ProformaTotals.hasAnySum(rows)
                      ? 'Agregar suma neta'
                      : 'Agregar suma',
                ),
              ),
            if (ProformaTotals.canAddDiscount(rows))
              TextButton.icon(
                onPressed: onAddDiscount,
                icon: const Icon(Icons.percent_rounded),
                label: const Text('Agregar descuento'),
              ),
          ],
        ),
      ],
    );
  }
}

class _FinanceRows extends StatelessWidget {
  const _FinanceRows({
    required this.rows,
    required this.section,
    required this.onRowsChanged,
  });

  final List<ProformaTableRow> rows;
  final ProformaSection section;
  final ValueChanged<List<ProformaTableRow>> onRowsChanged;

  @override
  Widget build(BuildContext context) {
    final finance = rows.where(
      (row) => row is ProformaSumRow || row is ProformaDiscountRow,
    );
    if (finance.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (final row in finance) ...[
          _FinanceRowCard(
            row: row,
            rows: rows,
            section: section,
            onChanged: (updated) {
              onRowsChanged([
                for (final item in rows)
                  if (item.id == updated.id) updated else item,
              ]);
            },
            onRemove: () {
              onRowsChanged(ProformaTotals.removeRow(rows, row.id));
            },
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _FinanceRowCard extends StatelessWidget {
  const _FinanceRowCard({
    required this.row,
    required this.rows,
    required this.section,
    required this.onChanged,
    required this.onRemove,
    this.subsection,
  });

  final ProformaTableRow row;
  final List<ProformaTableRow> rows;
  final ProformaSection section;
  final ProformaSubsection? subsection;
  final ValueChanged<ProformaTableRow> onChanged;
  final VoidCallback onRemove;

  String _money(double value) => value.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.primary.withValues(alpha: 0.10),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.28),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.functions_rounded, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isChain ? 'Suma neta' : 'Suma',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close_rounded, size: 18),
                ),
              ],
            ),
            _BoundField(
              key: ValueKey('sum_label_${sum.id}'),
              label: 'Etiqueta',
              initialValue: sum.label,
              onChanged: (value) => onChanged(sum.copyWith(label: value)),
            ),
            const SizedBox(height: 8),
            Text(
              isChain ? 'Total: ${_money(value)}' : 'Subtotal: ${_money(value)}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (!isChain && net != value)
              Text(
                'Neto tras descuentos: ${_money(net)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
          ],
        ),
      );
    }

    final discount = row as ProformaDiscountRow;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.error.withValues(alpha: 0.08),
        border: Border.all(
          color: colorScheme.error.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.percent_rounded, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Descuento',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 18),
              ),
            ],
          ),
          _BoundField(
            key: ValueKey('disc_label_${discount.id}'),
            label: 'Etiqueta',
            initialValue: discount.label,
            onChanged: (value) => onChanged(discount.copyWith(label: value)),
          ),
          const SizedBox(height: 8),
          Text(
            'Monto: -${_money(discount.amount)}',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
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

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.item,
    required this.onChanged,
    required this.onRemove,
  });

  final ProformaItemRow item;
  final ValueChanged<ProformaItemRow> onChanged;
  final VoidCallback onRemove;

  String _money(double value) => value.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Ítem',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Eliminar ítem',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 18),
              ),
            ],
          ),
          _BoundField(
            key: ValueKey('item_desc_${item.id}'),
            label: 'Descripción',
            initialValue: item.description,
            onChanged: (value) => onChanged(item.copyWith(description: value)),
          ),
          const SizedBox(height: 10),
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
              const SizedBox(width: 10),
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
          const SizedBox(height: 10),
          Text('Unidad', style: theme.textTheme.labelMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: [
              for (final unit in MeasureUnit.values)
                ChoiceChip(
                  label: Text(unit.code),
                  selected: item.unit == unit.code,
                  onSelected: (_) =>
                      onChanged(item.copyWith(unit: unit.code)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: ${_money(item.total)}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _stripTrailingZeros(double value) {
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toString();
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
