import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/button_controller.dart';
import 'app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  RoundedButton({
    Key? key,
    required this.text,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonController = Provider.of<ButtonController>(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        // backgroundColor: buttonController.isButtonEnabled ? AppColors.primaryColor : AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
      ),
      onPressed: onPressed,
      //onPressed: buttonController.isButtonEnabled ? onPressed : null,
      child: isLoading
          ? const CircularProgressIndicator()
          : Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward,
          color: Colors.white,
          ),
        ],
      ),
    );
  }
}
