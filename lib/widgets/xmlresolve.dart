import 'package:flutter/material.dart';
import './storage.dart';
import './webrequest.dart';
import 'package:dart_rss/dart_rss.dart';

class Xml {
  sendrequest() async {
    final storage = SharedPref();
    List li = await storage.readkeys();
    String url = "";
    for (String ky in li) {
      url = await storage.readValue(ky);
    }
    final neet = Network();
    var rawxml = await neet.get(url);
    AtomFeed feed = AtomFeed.parse(rawxml);
    print(feed);
    return feed;
  }

  Widget resolvefeed() {
    List<Widget> list = [];

    Widget a;
    a = FutureBuilder(
        future: sendrequest(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            for (AtomItem item in snapshot.data.items) {
              list.add(ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.links.first.href.toString()),
              ));
            }
            return ListView(
              children: list,
            );
          } else {
            return const Center(child:Row(children:[Text("loading..."),Icon(Icons.blur_circular_sharp)]));
          }
        });
    return a;
  }
}
