import 'dart:async' show Future;

import '../_core_exports.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(dynamic key, String defValue) => _prefsInstance!.getString(key.toString()) ?? defValue;

  static Future<bool> setString(key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key.toString(), value);
  }

  static int getInt(key, int defValue) => _prefsInstance!.getInt(key.toString()) ?? defValue;

  static Future<bool> setInt(key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key.toString(), value);
  }

  static double getDouble(key, double defValue) => _prefsInstance!.getDouble(key.toString()) ?? defValue;

  static Future<bool> setDouble(key, double value) async {
    var prefs = await _instance;
    return prefs.setDouble(key.toString(), value);
  }

  static bool getBool(key, bool defValue) => _prefsInstance!.getBool(key.toString()) ?? defValue;

  static Future<bool> setBool(key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key.toString(), value);
  }

  static List getList(key, List defValue) => _prefsInstance!.getStringList(key.toString()) ?? defValue;

  static Future<bool> setList(key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key.toString(), value);
  }
}

enum PreferenceKeys { isLogin }
