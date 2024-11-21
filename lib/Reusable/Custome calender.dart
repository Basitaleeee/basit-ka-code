import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'Fonts.dart';
import 'app_colors.dart'; // For formatting the selected date

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
            hintText: '2025-01-01',
            hintStyle: tSStyleBlack16400.copyWith(
              fontSize: 14.sp,
              color: AppColors.greylight,
            ),
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
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        widget.controller.text = formattedDate; // Populate the text field with selected date
      });
    }
  }
}
