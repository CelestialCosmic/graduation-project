import 'package:flutter/material.dart';
import '../widgets/storage.dart';

class ShowFeedUrls extends StatefulWidget {
  const ShowFeedUrls({super.key});
  State<ShowFeedUrls> createState() => ShowFeedUrlsState();
}

class ShowFeedUrlsState extends State<ShowFeedUrls>
    with AutomaticKeepAliveClientMixin {
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
        print(value);
        print(name);
        tiles.add(FutureBuilder(
            future: _waitValue(),
            builder: (context, snapshot) {
              return ListTile(title: Text(name), subtitle: Text(value));
            }));
      }
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _waitName(),
    );
  }
}

class Pagestar extends StatefulWidget {
  const Pagestar({super.key});
  State<Pagestar> createState() => _PagestarState();
}

class _PagestarState extends State<Pagestar> {
  TextEditingController rssUrlController = TextEditingController();
  TextEditingController rssNameController = TextEditingController();
  List<Widget> tiles = [];
  _addFeedButton(context) {
    return Align(
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
        ));
  }

  Widget build(BuildContext context) {
    return Column(
        children: [ShowFeedUrls(), _addFeedButton(context)],
      );
  }
}
