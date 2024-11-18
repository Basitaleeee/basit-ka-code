import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class CustomSmallButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double? width;
  final double? height;

  const CustomSmallButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.secondary, // Default to secondary color
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 100.w, // Default width if not provided
        height: height ?? 40.h, // Default height if not provided
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(50.r),
          color: color,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 2.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w), // Adjust spacing as needed
            Icon(icon, color: Colors.white, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
