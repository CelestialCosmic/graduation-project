import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  readValue(key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key).toString();
    return value;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  readkeys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tiles = [];
    for (String key in prefs.getKeys()) {
      tiles.add(key);
    }
    return tiles;
  }
}
