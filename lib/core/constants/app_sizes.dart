import 'package:flutter/widgets.dart';

class AppSizes {
  AppSizes._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
  static const EdgeInsets screenPaddingSmall = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets sectionSpacing = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets itemSpacing = EdgeInsets.symmetric(horizontal: md);
}

