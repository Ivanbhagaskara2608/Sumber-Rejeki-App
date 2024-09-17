import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdownBarang extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final ValueChanged<String?> onChanged;
  String? selectedValue;
  final String hintText;
  final String? Function(String?)? validator; 

  CustomDropdownBarang({
    super.key,
    required this.items,
    required this.onChanged,
    required this.selectedValue,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      validator: validator,
      value: selectedValue,
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
                value: item['id'].toString(),
                child: Text(item['nama']),
              ))
          .toList(),
      onChanged: (value) {
        selectedValue = value;
        onChanged(value);
      },
      onSaved: (value) {
        selectedValue = value;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.zero,
      ),
    );
  }
}
