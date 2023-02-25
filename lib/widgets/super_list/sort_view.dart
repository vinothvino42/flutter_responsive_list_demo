import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/utils/sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/data_controller.dart';
import '../custom_dropdown_tile.dart';

class SortView extends ConsumerStatefulWidget {
  const SortView({super.key});

  @override
  ConsumerState<SortView> createState() => _SortViewState();
}

class _SortViewState extends ConsumerState<SortView> {
  final List<SuperListDropDown> _items = [];
  int _firstItemIndex = 0;
  int _secondItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _firstItemIndex = ref.read(firstItemProvider);
    _secondItemIndex = ref.read(secondItemProvider);
    final dataGrids = ref.read(keyListProvider);
    dataGrids.asMap().forEach((index, value) {
      _items.add(SuperListDropDown(name: value.label, index: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.paddingH12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropDownTile<SuperListDropDown>(
            label: 'Title: ',
            items: _items,
            onItemSelected: (SuperListDropDown value) =>
                _firstItemIndex = value.index,
          ),
          CustomDropDownTile<SuperListDropDown>(
            label: 'Subtitle: ',
            items: _items,
            onItemSelected: (SuperListDropDown value) =>
                _secondItemIndex = value.index,
          ),
          const SizedBox(height: Sizes.paddingV12),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(firstItemProvider.notifier).state = _firstItemIndex;
              ref.read(secondItemProvider.notifier).state = _secondItemIndex;
            },
          )
        ],
      ),
    );
  }
}
