import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Fonts.dart';
import 'app_colors.dart';

class CustomDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> items;

  CustomDropdownField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.items,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: tSStyleBlack16400),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 50.h, // Same height as the text field
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greylight),
            borderRadius: BorderRadius.circular(50.r),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: false,
              value: selectedItem,
              hint: Text(
                'Select an option',
                style: TextStyle(color: AppColors.greylight,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedItem = newValue;
                  widget.controller.text = newValue!;
                });
              },
              icon: Icon(Icons.arrow_drop_down, color: AppColors.greylight),
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}