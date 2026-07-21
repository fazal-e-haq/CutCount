import 'package:flutter/widgets.dart';

enum LayoutSize { phone, tablet }

class LayoutSizeHelper {
  LayoutSizeHelper._();

  static LayoutSize of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 ? LayoutSize.tablet : LayoutSize.phone;
  }

  static bool isTablet(BuildContext context) => of(context) == LayoutSize.tablet;
  static bool isPhone(BuildContext context) => of(context) == LayoutSize.phone;
}

