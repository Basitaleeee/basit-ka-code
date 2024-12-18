import 'package:flutter/material.dart';
import 'Fonts.dart';
import 'app_colors.dart';

class ReusableTextButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final IconData? icon;
  final TextStyle? textStyle;

  const ReusableTextButton2({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor,
    this.icon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? AppColors.secondary,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),

        fixedSize: Size(350, 45),
        textStyle: textStyle ??
            TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
      ),
      child: icon == null
          ? Center(
        child: Text(
          buttonText,
          style: textStyle,
        ),
      )
          : Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              buttonText,
              style: textStyle,
            ),
          ),
          const Spacer(),
          Icon(icon),
        ],
      ),
    );
  }
}
