import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final Color textColor;

  const ReusableText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.textColor, required Color,
    // required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }
}
