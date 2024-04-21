import 'package:flutter/material.dart';

class ScreenBreakpoints {
  static const double smallWidth = 600.0;
  static const double mediumWidth = 900.0;
  static const double largeWidth = 1200.0;
  static const double extraLargeWidth = 1600.0;

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallWidth;
  }

  static bool isMediumScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= smallWidth && screenWidth < mediumWidth;
  }

  static bool isLargeScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= mediumWidth && screenWidth < largeWidth;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeWidth;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isSmallScreen(context)) {
      return 2;
    }
    if (isMediumScreen(context)) {
      return 3;
    }
    if (isLargeScreen(context)) {
      return 4;
    }
    return 6;
  }
}
