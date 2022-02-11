import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {




  SharedPreferencesService._();


  static SharedPreferencesService get instance => SharedPreferencesService._();

  static SharedPreferences? _prefs;


  ///initializing
  initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Helper functions for saving data
  saveStringData(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  saveBooleanData(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  saveIntData(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  String? getStringData(String key) {
    return _prefs?.getString(key)??"";
  }

  int? getIntData(String key) {
    return _prefs?.getInt(key)??-1;
  }

  bool? getBoolData(String key) {
    return _prefs?.getBool(key)??false;
  }

  clearSharedPreferences() async {
    await _prefs?.clear();
  }
}
