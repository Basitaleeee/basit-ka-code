import 'package:flutter/material.dart';
import 'Fonts.dart';
import 'app_colors.dart';

class ReusableTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final IconData? icon;
  final TextStyle? textStyle; // New parameter for text style

  const ReusableTextButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor, // Nullable background color
    this.icon, // Nullable icon
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? AppColors.secondary,
        fixedSize: Size(350, 45 ),
        textStyle: textStyle ??
            TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              buttonText,
              style: textStyle, // Apply the custom text style here
            ),
          ),
          const Spacer(),
          if (icon != null) Icon(icon)
        ],
      ),
    );
  }
}
