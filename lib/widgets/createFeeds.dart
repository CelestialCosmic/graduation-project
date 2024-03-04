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
