import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_responsive_list_demo/utils/datex.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/data_controller.dart';
import '../../models/data_grid.dart';

enum GridCrossAxisType {
  xxs,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

extension GridCrossAxisX on GridCrossAxisType {
  int get getCrossAxis {
    switch (this) {
      case GridCrossAxisType.xxs:
        return 2;
      case GridCrossAxisType.xs:
        return 3;
      case GridCrossAxisType.sm:
        return 4;
      case GridCrossAxisType.md:
        return 5;
      case GridCrossAxisType.lg:
        return 6;
      case GridCrossAxisType.xl:
        return 7;
      case GridCrossAxisType.xxl:
        return 8;
      case GridCrossAxisType.xxxl:
        return 9;
      default:
        return 10;
    }
  }
}

class CustomGridView extends ConsumerWidget {
  const CustomGridView({
    super.key,
    required this.config,
    required this.crossAxisType,
  });

  final SuperListConfig config;
  final GridCrossAxisType crossAxisType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(dataControllerProvider(config.url));

    return dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err) => Center(
              child: Text('Error: $err'),
            ),
        success: (multiDataGrids) => multiDataGrids.isEmpty
            ? const Center(
                child: Text('No data found'),
              )
            : DataGridView(multiDataGrids: multiDataGrids));
  }
}

class DataGridView extends StatefulWidget {
  const DataGridView({
    super.key,
    required this.multiDataGrids,
  });

  final List<List<DataGrid>> multiDataGrids;

  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  List<DataGrid> _dataGridColumns = [];
  List<List<DataGrid>> _dataGrids = [];
  late GridDataSource _gridDataSource;

  @override
  void initState() {
    super.initState();
    _dataGridColumns = widget.multiDataGrids.first;
    _dataGrids = widget.multiDataGrids;
    _gridDataSource = GridDataSource(multiDataGrids: _dataGrids);
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      isScrollbarAlwaysShown: true,
      source: _gridDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: List.generate(
        _dataGridColumns.length,
        (index) => GridColumn(
          columnName: _dataGridColumns[index].label,
          label: Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              _dataGridColumns[index].label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class GridDataSource extends DataGridSource {
  GridDataSource({required List<List<DataGrid>> multiDataGrids}) {
    _dataGrids = multiDataGrids
        .map<DataGridRow>(
          (list) => DataGridRow(
            cells: List.generate(
              list.length,
              (index) => DataGridCell<String>(
                columnName: list[index].label,
                value: getCellValue(
                  list[index].type,
                  list[index].value,
                ),
              ),
            ).toList(),
          ),
        )
        .toList();
  }

  String getCellValue(String type, dynamic value) {
    if (type == 'date') {
      final date = DateTime.tryParse(value);
      if (date != null && value is String) {
        return value.formatDate;
      }
      return 'Date Not Found';
    }
    return value.toString();
  }

  List<DataGridRow> _dataGrids = [];

  @override
  List<DataGridRow> get rows => _dataGrids;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
