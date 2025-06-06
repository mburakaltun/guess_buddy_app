import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKey.selectedLanguage, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesKey.selectedLanguage) ?? 'en';
  }
}