import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the selected date

class CustomDateTextField extends StatefulWidget {
  final TextEditingController controller;

  const CustomDateTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomDateTextFieldState createState() => _CustomDateTextFieldState();
}

class _CustomDateTextFieldState extends State<CustomDateTextField> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          TextField(
          controller: widget.controller,
          readOnly: true, // Makes the field non-editable directly
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () {
                _selectDate(context);
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
              ),
        ],
      );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date is pre-selected
      firstDate: DateTime(2000),   // Earliest date selectable
      lastDate: DateTime(2101),    // Latest date selectable
    );

    if (pickedDate != null) {
      // Format the selected date and set it in the controller
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        widget.controller.text = formattedDate; // Populate the text field with selected date
      });
    }
  }
}
