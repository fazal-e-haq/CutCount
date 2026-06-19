import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool isdark = false;

  void changeTheme(bool value) {
    isdark = value;
    notifyListeners();
  }
}
