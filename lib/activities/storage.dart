import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  loadWidget() async{
    List<String> tiles = [];
    final prefs = await SharedPreferences.getInstance();
    for (String key in prefs.getKeys()){
      tiles.add(key);
    }
    return tiles;
  }
}