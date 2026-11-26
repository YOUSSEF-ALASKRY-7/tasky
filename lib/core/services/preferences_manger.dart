import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManger {
  static final PreferencesManger _instance = PreferencesManger._();

  factory PreferencesManger() => _instance;

  PreferencesManger._();

  late SharedPreferences _shard; // شيلت final

  Future<void> init() async {
    _shard = await SharedPreferences.getInstance();
  }

  String? getString(String key) => _shard.getString(key);

  bool? getBool(String key) => _shard.getBool(key);

  Future<bool> setString(String key, String value) => _shard.setString(key, value);

  Future<bool> setBool(String key, bool value) => _shard.setBool(key, value);

  Future<bool> remove(String key) => _shard.remove(key);
  Future<bool> clear(String key) => _shard.clear();
}