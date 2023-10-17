import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController rssUrlController = TextEditingController();
TextEditingController rssNameController = TextEditingController();

class RssStorage {
  List urlList = [
    "feed1",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
    "feed2",
  ];
  static write(feedName, feedUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(feedName, feedUrl);
  }

  static load() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final prefsMap = Map<String, String>();
    for (String key in keys){
      prefsMap[key] = prefs.get(key).toString();
    }
    prefsMap.forEach((key, value) { 
    });
    return;
  }
}

List<Widget> _newsBlock() {
  List<Widget> list = [];
  final prefsMap = RssStorage.load();
  prefsMap.forEach(
    (key,value)
   {
    list.add(
      Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 233, 33, 33)),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        height: 120,
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
              height: 80,
              width: 80,
              child: Image.network(
                  "https://cdn.sstatic.net/Img/teams/teams-illo-free-sidebar-promo.svg?v=47faa659a05e"),
            )
          ]),
        ]),
      ),
    );
  });
  return list;
}

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
                                    RssStorage.write(rssNameController.text,
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

class Star extends StatefulWidget {
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ListView(children: _newsBlock()), _addFeedButton(context)],
    );
  }
}
