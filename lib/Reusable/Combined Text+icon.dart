import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Fonts.dart'; // Make sure to import this for SVG support

class CombinedTextWithLineWidget extends StatelessWidget {
  final String text; // Parameter for the text
  final double fontSize; // Parameter for font size

  const CombinedTextWithLineWidget({
    Key? key,
    required this.text,
    this.fontSize = 15, // Default font size
  }) : super(key: key); // Initialize parameters

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            text, // Use the text parameter
            style: tSStyleBlack20500,
          ),
          SizedBox(height: 5.h), // Optional space between text and line
          SvgPicture.asset(
            'assets/Icons/line.svg',
            height: 10,
          ),
        ],
      ),
    );
  }
}
