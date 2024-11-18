import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Fonts.dart';
import 'app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool? obscureText; // Nullable obscureText
  final Icon? suffixIcon;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon, required String label, bool isPasswordField = false,
  }) : super(key: key);

  get optionalIcon => null;

  get errorText => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style:tSStyleBlack16400.copyWith(fontSize: 14) ),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
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
              borderRadius: BorderRadius.circular(50.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greylight,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            errorText: errorText,
          suffixIcon: optionalIcon != null
              ? Icon(optionalIcon, color: AppColors.greylight)
              : suffixIcon,
          ),        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
