//
import 'package:flutter/material.dart';
import '../widgets/storage.dart';

TextEditingController rssUrlController = TextEditingController();
TextEditingController rssNameController = TextEditingController();

class Star extends StatefulWidget {
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  List<Widget> tiles = [];
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
                                      var instance = SharedPref();
                                      instance.save(rssNameController.text,
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

  Widget build(BuildContext context) {
    final jjj = _ShowFeedUrlsState();
    List<Widget> a = jjj._waitName();
    return Stack(children: [_addFeedButton(context), ListView(children: a)]);
  }
}

class _ShowFeedUrls extends StatefulWidget {
  const _ShowFeedUrls({super.key});
  State<_ShowFeedUrls> createState() => _ShowFeedUrlsState();
}

class _ShowFeedUrlsState extends State<_ShowFeedUrls>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Widget> tiles = [];
  _waitValue() async {
    var storage = SharedPref();
    List<String> values = [];
    values = await storage.readkeys();
    return values;
  }

  List<Widget> _waitName() {
    var storage = SharedPref();
    List<String> values = [];
    storage.readkeys().then((j) {
      for (String name in j) {
        String value = "";
        storage.readValue(name).then((z) => value = z);
        tiles.add(FutureBuilder(
            future: _waitValue(),
            builder: (context, snapshot) {
              return ListTile(title: Text(name), subtitle: Text(value));
            }));
      }
    });
    return tiles;
  }

  Widget build(BuildContext context) {
    return Stack(children: [
      Star(),
      Text("123"),
      ListView(
        children: _waitName(),
      )
    ]);
  }
}
