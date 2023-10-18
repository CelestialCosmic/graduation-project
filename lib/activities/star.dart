import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController rssUrlController = TextEditingController();
TextEditingController rssNameController = TextEditingController();

class _RssStorageState {
  static write(feedName, feedUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(feedName, feedUrl);
  }

  static delete(feedName) async {}

  static Future<List<Widget>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    List<Widget> tiles = [];
    // final prefsMap = Map<String, String>();
    // prefsMap[key] = prefs.get(key).toString();
    for (String key in keys) {
      String value = prefs.getString(key) as String;
      tiles.add(Container(
        height: 60,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 233, 33, 33)),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(children: [
          Expanded(
              child: Text(
            key,
            maxLines: 1,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          Row(children: [
            Expanded(child: Text(value)),
            SizedBox(
              child: ElevatedButton(
                child: Icon(Icons.delete),
                onPressed: () {},
              ),
            )
          ]),
        ]),
      ));
      print("load funtion: ${value}");
    }
    return tiles;
  }

  static loadkey() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    return keys;
  }

  static loadvalue() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (String key in keys) {
      prefs.get(key);
    }
  }
}

class Star extends StatefulWidget {
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  // Widget rssBook(name, url) {
  //   return Container(
  //     height: 60,
  //     decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(20)),
  //         color: Color.fromARGB(255, 233, 33, 33)),
  //     padding: const EdgeInsets.all(5),
  //     margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
  //     child: Column(children: [
  //       Expanded(
  //           child: Text(
  //         name,
  //         maxLines: 1,
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       )),
  //       Row(children: [
  //         Expanded(child: Text(url)),
  //         SizedBox(
  //           child: ElevatedButton(
  //             child: Icon(Icons.delete),
  //             onPressed: () {},
  //           ),
  //         )
  //       ]),
  //     ]),
  //   );
  // }

  void _addNew(Widget x) {}

  void _removeSelected(Widget x) {}

  _addFeedButton(context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("添加订阅源"),
                            content: Column(
                              children: [
                                SizedBox(
                                  child: TextField(
                                    controller: rssNameController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '名字',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    controller: rssUrlController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '网站的rssurl',
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5.0)),
                                ElevatedButton(
                                  child: const Text("添加"),
                                  onPressed: () {
                                    if (rssUrlController.text.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("不能为空！"),
                                            );
                                          });
                                    } else {
                                      _RssStorageState.write(
                                          rssNameController.text,
                                          rssUrlController.text);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("添加成功！"),
                                            );
                                          });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ))
      ],
    );
  }
  _readtile() async{
    await _RssStorageState.load();
  }
  @override
  Widget build(BuildContext context) {
    _RssStorageState.load();
    return Stack(children: [
      ListView(children: _readtile()),
      _addFeedButton(context),
    ]);
  }
}
