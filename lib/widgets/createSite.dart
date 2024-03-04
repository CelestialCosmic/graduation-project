import 'package:flutter/material.dart';
import '../widgets/storage.dart';
import 'package:provider/provider.dart';

class ShowSite extends StatefulWidget {
  const ShowSite({super.key});
  State<ShowSite> createState() => ShowSiteState();
}

class ShowSiteState extends State<ShowSite> {
  @override
  var storage = SharedPref();
  _waitValue() async {
    List<String> values = [];
    values = await storage.readkeys();
    return values;
  }

  _waitUrl(String name) {
    String url = storage.readValue(name);
    return url;
  }

  static List<Widget> a = [
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
    Text("1"),
  ];

  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    tiles.add(
      FutureBuilder(
        future: _waitValue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _waitValue().then((values) {
              for (String name in values) {
                tiles.add(Column(
                  children: [Text(name)],
                ));
                // return const Text("nomore");
              }
            });
          } else if (!snapshot.hasData) {
            // return const Text("nomore");
          }
          // return const Text("nomore");
        },
      ),
    );
    return ListView(
      children: tiles,
    );
  }
}
