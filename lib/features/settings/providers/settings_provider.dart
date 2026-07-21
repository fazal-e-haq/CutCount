import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Settings are stored in SharedPreferences so the app keeps the user's choices after restart.
enum AppCurrency { pkr, usd, inr }

class SettingsProvider with ChangeNotifier {
  // Load previously saved settings before the first frame of the app uses them.
  SettingsProvider(this._prefs)
      : currency = AppCurrency.values[_prefs.getInt(_currencyKey) ?? 0],
        biometricsEnabled = _prefs.getBool(_biometricsKey) ?? false,
        notificationsEnabled = _prefs.getBool(_notificationsKey) ?? true,
        darkModeEnabled = _prefs.getBool(_themeKey) ?? false;

  final SharedPreferences _prefs;

  static const String _currencyKey = 'settings_currency';
  static const String _biometricsKey = 'settings_biometrics';
  static const String _notificationsKey = 'settings_notifications';
  static const String _themeKey = 'settings_dark_mode';

  AppCurrency currency = AppCurrency.pkr;
  bool biometricsEnabled = false;
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  // Currency selection is kept simple here, but can later feed formatting logic across the app.
  void setCurrency(AppCurrency value) {
    currency = value;
    _prefs.setInt(_currencyKey, value.index);
    notifyListeners();
  }

  void toggleBiometrics(bool value) {
    biometricsEnabled = value;
    _prefs.setBool(_biometricsKey, value);
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    _prefs.setBool(_notificationsKey, value);
    notifyListeners();
  }

  void toggleTheme(bool value) {
    darkModeEnabled = value;
    _prefs.setBool(_themeKey, value);
    notifyListeners();
  }
}
