import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 0;

  void init(BoxConstraints constraints) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
  }

  double getPropotionateHeight(double actualHeight) {
    // divide - artboard height that designer use
    return (actualHeight / 812.0) * _screenHeight;
  }

  double getPropotionateWidth(double actualWidth) {
    //divide - artboard width that designer use
    return (actualWidth / 375.0) * _screenWidth;
  }

  double getTextSize(double val) {
    return double.parse((val / textMultiplier).toStringAsFixed(2)) * textMultiplier;
  }
}
