import 'package:flutter/material.dart';

class ProductDetailNotifier extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void onDotTap(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
