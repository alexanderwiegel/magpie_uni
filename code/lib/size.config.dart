import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double hori;
  static late double vert;
  static late bool isTablet;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    hori = screenWidth / 100;
    vert = screenHeight / 100;
    screenWidth > 600 ? isTablet = true : isTablet = false;
  }
}
