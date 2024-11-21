import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Fonts.dart';
import 'app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText; // Default false for password-like input
  final Icon? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: tSStyleBlack16400.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: controller.text.isEmpty ? hintText : null, // Show hint if empty
            hintStyle: tSStyleBlack16400.copyWith(
              fontSize: 14.sp,
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
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            suffixIcon: suffixIcon,
          ),
          onChanged: (_) {
            // Rebuild UI to update hint visibility when typing
            (context as Element).markNeedsBuild();
          },
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
