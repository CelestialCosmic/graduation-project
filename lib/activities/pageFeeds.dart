import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutterrss/activities/FeedReader.dart';
import 'package:flutterrss/widgets/feedResolver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterrss/activities/pageFeeds.dart';

class ShowFeeds extends StatelessWidget {
  feedUrl(key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key).toString();
    return value;
  }

  final String name;
  const ShowFeeds({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: FutureBuilder(
            future: feedUrl(name),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Text("waiting data"),
                    Spacer(
                      flex: 1,
                    )
                  ],
                );
              } else {
                return FutureBuilder(
                    future: Resolver().sendrequest(snapshot.data.toString()),
                    builder: (context, AsyncSnapshot snapshot) {
                      List<Widget> tiles = [];
                      if (snapshot.hasData) {
                        for (AtomItem item in snapshot.data.items) {
                          String authors = "";
                          String url = "";
                          url = item.links.first.href.toString();
                          if (item.authors.length != 0) {
                            for (var author in item.authors) {
                              authors = "${author.name} ";
                            }
                          } else {
                            authors = "no author";
                          }
                          tiles.add(ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FeedDetail(
                                              text: item.content.toString(),
                                              title: name,
                                              url: url,
                                            )));
                              },
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(item.title.toString()),
                                      const Spacer(
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(authors),
                                      const SizedBox(width: 20),
                                      Flexible(
                                          child: Text(
                                        url,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                      ))
                                    ],
                                  )
                                ],
                              )));
                        }
                      }
                      return ListView(
                        children: tiles,
                      );
                    });
              }
            }),
      ),
    );
  }
}
