import 'package:flutter/material.dart';
import 'package:flutterrss/activities/page_feeds.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NoSubscriptionWarning extends StatelessWidget {
  const NoSubscriptionWarning({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("no subscription,tap button on top-left to add one"));
  }
}

class ShowSite extends StatefulWidget {
  const ShowSite({super.key});
  @override
  State<ShowSite> createState() => ShowSiteState();
}

class ShowSiteState extends State<ShowSite> {
  List<Widget> tiles = [];
  keys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> key = prefs.getKeys().toList();
    return key;
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
        if (!snapshot.hasData) {
          return const NoSubscriptionWarning();
        } else {
          String keyListmid = jsonEncode(snapshot.data.toString());
          var keyList = keyListmid
              .substring(2, keyListmid.length - 2)
              .replaceAll(" ", "");
          var keyList2 = (keyList.split(','));
          return ListView.builder(
              itemCount: keyList2.length,
              itemBuilder: (context, index) {
                String name = keyList2[index];
                return Card(
                    color: const Color.fromARGB(255, 209, 231, 254),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageFrame(
                                  name: name,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            Expanded(
                              child: Text(name),
                            ),
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
              });
        }
      },
    );
  }
}
