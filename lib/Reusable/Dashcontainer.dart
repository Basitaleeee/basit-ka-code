import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Fonts.dart';

class CustomListItem extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onTap;

  const CustomListItem({
    Key? key,
    required this.svgPath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 336,
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 60,
              height: 60,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: tSStyleBlack18400.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
