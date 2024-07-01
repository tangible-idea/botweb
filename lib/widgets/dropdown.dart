
import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({
    super.key,
    required this.list,
    required this.onSelected,
    this.controller
  });

  final List<String> list;
  final Function(String?) onSelected;
  final TextEditingController? controller;

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  //String dropdownValue = widget.list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: widget.controller,
      initialSelection: widget.list.first,
      onSelected: widget.onSelected, // This is called when the user selects an item.
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
