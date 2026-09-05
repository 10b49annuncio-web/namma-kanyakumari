import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPrefService._();

  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  ///--------------------------------------------------
  /// Keys
  ///--------------------------------------------------

  static const String firstTimeKey = "first_time";
  static const String loginKey = "is_logged_in";
  static const String tokenKey = "user_token";
  static const String userIdKey = "user_id";
  static const String userNameKey = "user_name";
  static const String emailKey = "email";
  static const String phoneKey = "phone";
  static const String languageKey = "language";
  static const String themeKey = "theme";

  ///--------------------------------------------------
  /// Generic Methods
  ///--------------------------------------------------

  static Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  static String getString(String key) {
    return _preferences?.getString(key) ?? "";
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences?.getBool(key) ?? false;
  }

  static Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  static int getInt(String key) {
    return _preferences?.getInt(key) ?? 0;
  }

  static Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  static double getDouble(String key) {
    return _preferences?.getDouble(key) ?? 0.0;
  }

  static Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return await _preferences!.clear();
  }

  ///--------------------------------------------------
  /// First Time
  ///--------------------------------------------------

  static Future<void> setFirstTime(bool value) async {
    await setBool(firstTimeKey, value);
  }

  static bool isFirstTime() {
    return _preferences?.getBool(firstTimeKey) ?? true;
  }

  ///--------------------------------------------------
  /// Login
  ///--------------------------------------------------

  static Future<void> setLoggedIn(bool value) async {
    await setBool(loginKey, value);
  }

  static bool isLoggedIn() {
    return _preferences?.getBool(loginKey) ?? false;
  }

  ///--------------------------------------------------
  /// Token
  ///--------------------------------------------------

  static Future<void> saveToken(String token) async {
    await setString(tokenKey, token);
  }

  static String getToken() {
    return getString(tokenKey);
  }

  ///--------------------------------------------------
  /// User ID
  ///--------------------------------------------------

  static Future<void> saveUserId(String id) async {
    await setString(userIdKey, id);
  }

  static String getUserId() {
    return getString(userIdKey);
  }

  ///--------------------------------------------------
  /// User Name
  ///--------------------------------------------------

  static Future<void> saveUserName(String name) async {
    await setString(userNameKey, name);
  }

  static String getUserName() {
    return getString(userNameKey);
  }

  ///--------------------------------------------------
  /// Email
  ///--------------------------------------------------

  static Future<void> saveEmail(String email) async {
    await setString(emailKey, email);
  }

  static String getEmail() {
    return getString(emailKey);
  }

  ///--------------------------------------------------
  /// Phone
  ///--------------------------------------------------

  static Future<void> savePhone(String phone) async {
    await setString(phoneKey, phone);
  }

  static String getPhone() {
    return getString(phoneKey);
  }

  ///--------------------------------------------------
  /// Language
  ///--------------------------------------------------

  static Future<void> setLanguage(String language) async {
    await setString(languageKey, language);
  }

  static String getLanguage() {
    return _preferences?.getString(languageKey) ?? "en";
  }

  ///--------------------------------------------------
  /// Theme
  ///--------------------------------------------------

  static Future<void> setTheme(bool darkMode) async {
    await setBool(themeKey, darkMode);
  }

  static bool isDarkMode() {
    return _preferences?.getBool(themeKey) ?? false;
  }
}