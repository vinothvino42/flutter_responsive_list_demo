import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/utils/sizes.dart';

abstract class DropDownItem {
  final String name;

  DropDownItem({required this.name});
}

class SuperListDropDown extends DropDownItem {
  SuperListDropDown({required super.name, required this.index});

  final int index;
}

class CustomDropDownTile<T extends DropDownItem> extends StatefulWidget {
  const CustomDropDownTile({
    super.key,
    required this.label,
    required this.items,
    required this.onItemSelected,
  });

  final String label;
  final List<T> items;
  final Function(T) onItemSelected;

  @override
  CustomDropDownTileState<T> createState() => CustomDropDownTileState<T>();
}

class CustomDropDownTileState<T extends DropDownItem>
    extends State<CustomDropDownTile<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.paddingV12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '${widget.label} : ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButton<T>(
              value: _currentValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: widget.items.map((T item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (T? newValue) {
                setState(() {
                  _currentValue = newValue!;
                });
                widget.onItemSelected(_currentValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
