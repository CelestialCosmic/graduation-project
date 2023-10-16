import 'package:flutter/material.dart';

TextEditingController rssController = TextEditingController();

class RssStorage {
  static const urlList = [
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
}

List<Widget> _newsBlock() {
  List<Widget> list = [];
  for (var i = 0; i < RssStorage.urlList.length; i++) {
    list.add(
      Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 233, 33, 33)),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        height: 120,
        child: Column(children: [
          const Expanded(
              child: Text(
            "title",
            maxLines: 1,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          Row(children: [
            const Expanded(child: Text("123")),
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
  }
  return list;
}

_addFeedButton(context) {
  return Stack(
    children: [
      Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(35.0),
            child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("添加订阅源"),
                          content: Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 200,
                                child: TextField(
                                  controller: rssController,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    hintText: '输入网站的rssurl',
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(5.0)),
                              ElevatedButton(
                                child: const Text("添加"),
                                onPressed: () {
                                  if (rssController.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text("提示"),
                                            content: Text("不能为空！"),
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
