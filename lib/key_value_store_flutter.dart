import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//---adding abstract class to setup key store value---
abstract class KeyValueStore {
  String? getStringValue(String key);
  Future<bool> setStringValue(String key, String value);
}

class StoreKeyValue extends KeyValueStore {
  StoreKeyValue(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  //---getting value through shared preference using key
  @override
  String? getStringValue(String key) => _sharedPreferences.getString(key);

  //---setting value associated with particular key
  @override
  Future<bool> setStringValue(String key, String value) =>
      _sharedPreferences.setString(key, value);
}
