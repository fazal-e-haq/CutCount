import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Settings are stored in SharedPreferences so the app keeps the user's choices after restart.
enum AppCurrency { pkr, usd, inr, gbp, eur }

class SettingsProvider with ChangeNotifier {
  // Load previously saved settings before the first frame of the app uses them.
  SettingsProvider(this._prefs)
      : currency = AppCurrency.values[_prefs.getInt(_currencyKey) ?? 0],
        biometricsEnabled = _prefs.getBool(_biometricsKey) ?? false,
        notificationsEnabled = _prefs.getBool(_notificationsKey) ?? true,
        darkModeEnabled = _prefs.getBool(_themeKey) ?? false,
        userName = _prefs.getString(_nameKey) ?? 'Your Name',
        userSubtitle = _prefs.getString(_subtitleKey) ?? 'Barber shop owner';

  final SharedPreferences _prefs;

  static const String _currencyKey = 'settings_currency';
  static const String _biometricsKey = 'settings_biometrics';
  static const String _notificationsKey = 'settings_notifications';
  static const String _themeKey = 'settings_dark_mode';
  // Profile identity keys – stored alongside other settings for simplicity.
  static const String _nameKey = 'profile_name';
  static const String _subtitleKey = 'profile_subtitle';

  AppCurrency currency = AppCurrency.pkr;
  bool biometricsEnabled = false;
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  // Profile fields displayed on the ProfileScreen header.
  String userName = 'Your Name';
  String userSubtitle = 'Barber shop owner';

  String get currencySymbol {
    switch (currency) {
      case AppCurrency.pkr: return 'Rs.';
      case AppCurrency.usd: return '\$';
      case AppCurrency.inr: return '₹';
      case AppCurrency.gbp: return '£';
      case AppCurrency.eur: return '€';
    }
  }

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

  // --- Profile editing -------------------------------------------------

  /// Persists the display name shown at the top of the profile screen.
  void updateName(String name) {
    userName = name;
    _prefs.setString(_nameKey, name);
    notifyListeners();
  }

  /// Persists the subtitle / tagline shown below the profile name.
  void updateSubtitle(String subtitle) {
    userSubtitle = subtitle;
    _prefs.setString(_subtitleKey, subtitle);
    notifyListeners();
  }
}
