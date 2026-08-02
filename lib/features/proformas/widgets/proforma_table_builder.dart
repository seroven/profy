import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme/app_motion.dart';
import '../../../shared/widgets/acrylic_surface.dart';
import '../../../shared/widgets/app_button.dart';
import '../../settings/models/measure_unit.dart';
import '../models/proforma_document.dart';
import '../models/proforma_totals.dart';

typedef ProformaDocumentChanged = void Function(ProformaDocument document);

/// Paso horizontal único entre niveles (sección → subsección → fila).
const double _indentStep = 16;

/// Builder tipográfico: una sola caja (tabla) + chips + sangría. Sin cards internas.
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
        for (final table in tables) ...[
          _TableBlock(
            table: table,
            defaultUnit: defaultUnit,
            onChanged: _replaceTable,
            onRemove: () => _removeTable(table.id),
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

class _TableBlock extends StatelessWidget {
  const _TableBlock({
    required this.table,
    required this.defaultUnit,
    required this.onChanged,
    required this.onRemove,
  });

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
              const _TypeChip(label: 'Tabla', tone: _ChipTone.table),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  table.name.trim().isEmpty
                      ? 'Sin nombre'
                      : table.name.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
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
          ),
          const SizedBox(height: 10),
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
        ],
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
      storageKey: 'sec_${section.id}',
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
        storageKey: 'sub_${subsection.id}',
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

enum _ChipTone { table, section, subsection, item, sum, discount }

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
    required this.storageKey,
    required this.initiallyExpanded,
    required this.headerBuilder,
    required this.body,
  });

  final String storageKey;
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
  static final Map<String, bool> _expandedByKey = {};

  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = _expandedByKey[widget.storageKey] ?? widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _expandedByKey[widget.storageKey] = _expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.headerBuilder(context, _expanded, _toggle),
        AnimatedSize(
          duration: AppMotion.fast,
          curve: AppMotion.standard,
          alignment: Alignment.topCenter,
          child: _expanded
              ? widget.body
              : const SizedBox(width: double.infinity),
        ),
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
