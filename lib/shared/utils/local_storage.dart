import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> setOnboardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboarding_seen", value);
  }

  static Future<bool> getOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboarding_seen") ?? false;
  }
}
