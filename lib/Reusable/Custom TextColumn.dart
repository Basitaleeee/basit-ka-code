import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Fonts.dart';

class CustomTextColumnWidget extends StatelessWidget {
  final String firstText; // Parameter for the first text
  final String secondText; // Parameter for the second text

  const CustomTextColumnWidget({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            firstText, // Use the first text parameter
            style: tSStyleBlack18400.copyWith(
              fontSize: 15.sp,
            ),
          ),
          Text(
            secondText, // Use the second text parameter
            style: tSStyleBlack18400.copyWith(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
