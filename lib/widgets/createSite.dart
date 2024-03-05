import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSite extends StatefulWidget {
  const ShowSite({super.key});
  State<ShowSite> createState() => ShowSiteState();
}

class ShowSiteState extends State<ShowSite> {
  List<Widget> tiles = [];
  keys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys;
  }

  Widget build(BuildContext context) {
    List<String> names = [];
    List<Widget> tiles = [];
    for (String name in names) {
      tiles.add(ListTile(
        title: Text(name),
      ));
    }
    return FutureBuilder(
      future: keys(),
      builder: (context, snapshot) {
        String keyListmid = jsonEncode(snapshot.data.toString());
        var keyList =
            keyListmid.substring(2, keyListmid.length - 2).replaceAll(" ", "");
        var keyList2 = (keyList.split(','));
        List<Widget> tiles = [];
        for (var name in keyList2) {
          tiles.add(ListTile(
            title: Text(name),
            // onTap: ,
          ));
        }
        return Column(
          children: tiles,
        );
      },
    );
  }
}
