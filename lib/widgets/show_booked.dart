// 添加订阅按钮
import 'package:flutter/material.dart';
import 'storage.dart';

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
