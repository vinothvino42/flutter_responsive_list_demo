import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/models/data_grid.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/sort_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';

import '../../constants/app_constants.dart';
import '../../controllers/data_controller.dart';
import '../../utils/sizes.dart';

class CustomListView extends ConsumerWidget {
  const CustomListView({super.key, required this.config});

  final SuperListConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(dataControllerProvider(config.url));

    ref.listen(dataControllerProvider(config.url),
        (_, state) => _handleListView(ref, state));

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appBar),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showColumnUpdateSheet(context),
          )
        ],
      ),
      body: dataState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err) => Center(
                child: Text('Error: $err'),
              ),
          success: (multiDataGrids) => multiDataGrids.isEmpty
              ? const Center(
                  child: Text('No data found'),
                )
              : _CustomListView(multiDataGrids: multiDataGrids)),
    );
  }

  void _handleListView(WidgetRef ref, DataState state) {
    if (state is DataStateSuccess) {
      final multiGrids = state.whenOrNull(success: (multiGrids) => multiGrids);
      if (multiGrids != null && multiGrids.isNotEmpty) {
        ref.read(keyListProvider.notifier).state = multiGrids.first;
      }
    }
  }

  void _showColumnUpdateSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const SortView());
  }
}

class _CustomListView extends ConsumerStatefulWidget {
  const _CustomListView({required this.multiDataGrids});

  final List<List<DataGrid>> multiDataGrids;

  @override
  ConsumerState<_CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends ConsumerState<_CustomListView> {
  late List<List<DataGrid>> multiDataGrids;

  @override
  void initState() {
    super.initState();
    multiDataGrids = widget.multiDataGrids;
  }

  @override
  Widget build(BuildContext context) {
    final firstItemIndex = ref.watch(firstItemProvider);
    final secondItemIndex = ref.watch(secondItemProvider);

    return ListView.separated(
      itemCount: multiDataGrids.length,
      separatorBuilder: (context, _) => const Divider(),
      itemBuilder: (context, index) => CustomListTile(
        firstGridItem: multiDataGrids[index][firstItemIndex],
        secondGridItem: multiDataGrids[index][secondItemIndex],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.firstGridItem,
    required this.secondGridItem,
  });

  final DataGrid firstGridItem;
  final DataGrid secondGridItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Corners.radius10),
      ),
      padding: const EdgeInsets.all(Sizes.paddingH12),
      child: Column(
        children: [
          CustomListItem(
            title: '${firstGridItem.label}: ',
            value: firstGridItem.value.toString(),
          ),
          const SizedBox(height: Sizes.paddingV12),
          CustomListItem(
            title: '${secondGridItem.label}: ',
            value: secondGridItem.value.toString(),
          ),
        ],
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
