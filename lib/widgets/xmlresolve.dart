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
    return feed;
  }

  List<Widget> resolvefeed() {
    var feed;
    List<Widget> list = [];
    list.add(FutureBuilder(
        future: sendrequest(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListTile(
              title: Text(snapshot.data.title.toString()),
              subtitle: Text(snapshot.data.links.first.toString()),
            );
          } else {
            return const Padding(padding: EdgeInsets.zero);
          }
        }));
    return list;
  }
}
