import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lookbook/Reusable/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Firebase import

class CustomColorPickerTextField extends StatefulWidget {
  final TextEditingController controller;

  const CustomColorPickerTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomColorPickerTextFieldState createState() =>
      _CustomColorPickerTextFieldState();
}

class _CustomColorPickerTextFieldState extends State<CustomColorPickerTextField> {
  List<Color> _selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greylight),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          // Display selected colors as avatars
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Show selected color avatars with padding between them
                  ..._selectedColors.map((color) => Padding(
                    padding: EdgeInsets.only(right: 8.w), // Add space between avatars
                    child: _buildColorAvatar(color),
                  )).toList(),

                  // Add button as circular avatar (now placed after the selected colors)
                  GestureDetector(
                    onTap: () => _showColorPickerDialog(context),
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build circular avatars for selected colors with a remove icon
  Widget _buildColorAvatar(Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 12.r,
          backgroundColor: color,
        ),
        Positioned(
          top: -2.h,
          right: -2.w,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedColors.remove(color); // Remove the selected color
              });
            },
            child: CircleAvatar(
              radius: 7.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.close,
                size: 10.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method to show the color picker dialog
  Future<void> _showColorPickerDialog(BuildContext context) async {
    Color selectedColor = Colors.red; // Default color for the picker

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                selectedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add Color'),
              onPressed: () {
                setState(() {
                  _selectedColors.add(selectedColor); // Add the selected color
                  widget.controller.text = _getColorCode(selectedColor); // Set color code in controller
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Generate the hex color code from the Color object
  String _getColorCode(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  // Save product data in Firebase (you would call this from somewhere else in your app)
  Future<void> saveProductData() async {
    String colorCode = widget.controller.text;

    await FirebaseFirestore.instance.collection('products').add({
      'color': colorCode,
      // Other product data like name, description, price, etc.
    });
  }
}
