import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomCalendarTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<CustomCalendarTextField> createState() =>
      _CustomCalendarTextFieldState();
}

class _CustomCalendarTextFieldState extends State<CustomCalendarTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal tidak boleh kosong';
        }
        return null;
      },
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(
              2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

          setState(() {
            widget.controller.text = formattedDate;
          });
        }
      },
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}
