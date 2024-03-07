import 'package:flutter/material.dart';
import 'package:flutterrss/activities/page_feeds.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSite extends StatefulWidget {
  const ShowSite({super.key});
  @override
  State<ShowSite> createState() => ShowSiteState();
}

class ShowSiteState extends State<ShowSite> {
  List<Widget> tiles = [];
  keys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys;
  }

  remove(name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
  }

  @override
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
        if (keyList2.toString() == "[]") {
          tiles.add(const Center(
              child:
                  Text("no subscription,tap button on top-left to add one")));
        } else {
          for (var name in keyList2) {
            tiles.add(Card(
                color: const Color.fromARGB(255, 58, 143, 183),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageFrame(
                            name: name,
                          ),
                        ));
                  },
                  title: Row(children: [
                    Text(name),
                    const Spacer(),
                    Align(
                        alignment: const Alignment(1.0, 0.0),
                        child: OutlinedButton(
                            onPressed: () {
                              remove(name);
                              setState(() {});
                            },
                            child: const Icon(Icons.delete))),
                  ]),
                )));
          }
        }
        return Column(
          children: tiles,
        );
      },
    );
  }
}
