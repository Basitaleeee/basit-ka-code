import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorText;

  const ErrorMessage({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return errorText.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red, fontSize: 14),
      ),
    )
        : const SizedBox.shrink(); // Return an empty widget if no error
  }
}
