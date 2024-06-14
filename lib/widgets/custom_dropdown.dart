import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  String? selectedValue;
  final String hintText;

  CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.selectedValue,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      hint: Text(hintText),
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        selectedValue = value.toString();
        onChanged(value.toString());
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 10), // No padding for the button
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        padding: const EdgeInsets.symmetric(
            horizontal: 10), // No padding for the dropdown
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.zero, // No padding for the menu items
      ),
    );
  }
}
