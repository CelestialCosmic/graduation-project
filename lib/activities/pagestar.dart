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
  var doneflag = 0;
  _waitValue() async {
    var storage = SharedPref();
    List<String> values = [];
    values = await storage.readkeys();
    return values;
  }

  List<Widget> _waitName() {
    var storage = SharedPref();
    storage.readkeys().then((j) {
      print(j);
      if (doneflag == tiles.length) {
        for (String name in j) {
          String value = "";
          storage.readValue(name).then((z) => value = z);
          tiles.add(FutureBuilder(
              future: _waitValue(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("loading"));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return ListTile(
                    title: Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(60, 0, 0, 0)),
                      Text(name)
                    ]),
                    subtitle: Row(children: [
                      ElevatedButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          storage.remove(name);
                        },
                      ),
                      Text(value)
                    ]),
                  );
                } else {
                  return const Center(child: Text("loading"));
                }
              }));
        }
      }
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(doneflag);
    tiles = _waitName();
    print(tiles);
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: tiles,
    );
  }
}

class FeedButton extends StatefulWidget {
  const FeedButton({super.key});
  State<FeedButton> createState() => _FeedButtonState();
}

class _FeedButtonState extends State<FeedButton> {
  TextEditingController rssUrlController = TextEditingController();
  TextEditingController rssNameController = TextEditingController();
  List<Widget> tiles = [];
  _addFeedButton(context) {
    return OutlinedButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("添加订阅源"),
                  content: SizedBox(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                            instance.save(
                                rssNameController.text, rssUrlController.text);
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
                  )),
                );
              });
        });
  }

  Widget build(BuildContext context) {
    return _addFeedButton(context);
  }
}

class Pagestar extends StatefulWidget {
  const Pagestar({super.key});
  State<Pagestar> createState() => PagestarState();
}

class PagestarState extends State<Pagestar> {
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ShowFeedUrls(),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(35.0),
                  child: FeedButton(),
                ))
          ],
        ));
  }
}
