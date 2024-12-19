import 'package:flutter/material.dart';

class DefaultDropdownInput extends StatelessWidget {
  final List<String> list;
  final Function(String?) onSelected;
  final String? initialSelection;
  final double? width;
  const DefaultDropdownInput(
      {super.key, required this.list,required this.onSelected, this.initialSelection, required this.width});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey),
              borderRadius:BorderRadius.all(Radius.circular(5))),
          constraints:
              BoxConstraints(maxHeight:48),
          isDense: true),
      initialSelection:initialSelection,
      requestFocusOnTap:
          false,
      width: width,
      onSelected:onSelected,
      dropdownMenuEntries: list.map<
          DropdownMenuEntry<
              String>>((String
          value) {
        return DropdownMenuEntry<
                String>(
            value: value,
            label: value);
      }).toList(),
    );
  }
}