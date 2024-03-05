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

  void remove(name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
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
        print(keyList2);
        print(keyList2.runtimeType);
        List<Widget> tiles = [];
        if (keyList2.toString() == "[]") {
          tiles.add(const Center(child: Text("没有订阅，点击左上角添加")));
        } else {
          for (var name in keyList2) {
            tiles.add(ListTile(
              title: Row(children: [
                Text(name),
                Align(
                    alignment: const Alignment(1.0, 0.0),
                    child: OutlinedButton(
                        // onPressed: null,
                        onPressed: () => remove(name),
                        child: const Icon(Icons.delete))),
              ]),
              // onTap: ,
            ));
          }
        }
        return Column(
          children: tiles,
        );
      },
    );
  }
}
