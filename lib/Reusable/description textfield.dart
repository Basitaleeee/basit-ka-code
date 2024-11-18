import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'Fonts.dart';

class CustomDescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLines; // Max lines for the text field
  final int? minLines; // Min lines for the text field
  final Icon? suffixIcon;

  CustomDescriptionTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLines, // You can leave maxLines optional
    this.minLines = 1, // Default minLines to 1
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: tSStyleBlack16400),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          maxLines: maxLines, // Set the max lines to allow text expansion
          minLines: minLines, // Minimum line count when the field starts
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.greylight,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
