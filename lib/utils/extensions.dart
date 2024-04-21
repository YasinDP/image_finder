import 'package:flutter/material.dart';

extension SizeExtenions on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get width => size.width;
  double get height => size.height;
  double get topPadding => MediaQuery.of(this).padding.top;
}

extension DurationExtensions on num {
  Duration get seconds => Duration(seconds: toInt());
  Duration get milliSeconds => Duration(milliseconds: toInt());
}

extension ThemeExtensions on BuildContext {
  ThemeData get themeData => Theme.of(this);
  Color get primaryColor => themeData.primaryColor;
  Color get bgColor => themeData.scaffoldBackgroundColor;
}

extension RouteExtensions on String {
  String get path => "/$this";
}
