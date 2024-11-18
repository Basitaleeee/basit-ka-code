import 'package:flutter/material.dart';

class ButtonController extends ChangeNotifier {
  bool _isButtonEnabled = false;

  bool get isButtonEnabled => _isButtonEnabled;

  void validateFields(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
    notifyListeners();
  }
}
