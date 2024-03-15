import 'dart:async';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutterrss/activities/page_feed_detail.dart';
import 'package:flutterrss/widgets/base_resolver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:charset_converter';

class ErrorLoading extends StatelessWidget {
  final Function() refresh;
  const ErrorLoading({super.key, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(children: [
      Spacer(flex: 1),
      Card(
          color: Color.fromARGB(255, 209, 231, 254),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text("fetch error"),
                Text("tap button to refresh"),
                Text("or check whether the link is valid"),
              ]))),
      Spacer(flex: 1),
    ]));
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Card(
            color: Color.fromARGB(255, 209, 231, 254),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("fetching data"),
                ],
              ),
            )),
        Spacer(
          flex: 1,
        ),
      ],
    ));
  }
}

class FeedCard extends StatelessWidget {
  final String text;
  final String title;
  final String url;
  final String time;
  final String authors;
  const FeedCard(
      {super.key,
      required this.text,
      required this.title,
      required this.url,
      required this.time,
      required this.authors});
  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(255, 209, 231, 254),
        child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedDetail(
                            text: text,
                            title: title,
                            url: url,
                          )));
            },
            title: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      title,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      softWrap: true,
                    )),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      authors,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 12),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    )),
                    const SizedBox(width: 20),
                    Flexible(
                        child: Text(
                      time,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 12),
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      softWrap: false,
                    ))
                  ],
                )
              ],
            )));
  }
}

class PageFrame extends StatefulWidget {
  final String name;
  const PageFrame({super.key, required this.name});
  @override
  State<PageFrame> createState() => PageFrameState();
}

class PageFrameState extends State<PageFrame> {
  feedUrl(key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key).toString();
    return value;
  }

  refresh() {
    setState(() {});
  }

  utf8Convert(txt) {
    Utf8Decoder decode = const Utf8Decoder();
    String converted = jsonDecode(decode.convert(txt));
    print(converted);
    return converted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 249, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 208, 251),
        title: Row(children: [
          Text(widget.name),
          const Spacer(
            flex: 1,
          ),
          OutlinedButton(onPressed: refresh, child: const Icon(Icons.refresh))
        ]),
      ),
      body: Center(
          child: FutureBuilder(
              future: feedUrl(widget.name),
              builder: (context, snapshot) {
                {
                  return FutureBuilder(
                      future: Resolver().sendrequest(snapshot.data.toString()),
                      builder: (context, AsyncSnapshot snapshot) {
                        List<Widget> tiles = [];
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData == false) {
                          return ErrorLoading(
                            refresh: refresh,
                          );
                        } else if (!snapshot.hasData) {
                          bool timeoutFlag = false;
                          Timer(const Duration(seconds: 20), () {
                            timeoutFlag = true;
                          });
                          if (timeoutFlag == false) {
                            return const Loading();
                          } else {
                            return ErrorLoading(
                              refresh: refresh,
                            );
                          }
                        } else {
                          String time = "";
                          String authors = "";
                          String url = "";
                          String title = "";
                          String text = "";
                          Object items = snapshot.data;
                          if (items.runtimeType == RssFeed) {
                            RssFeed items = snapshot.data;
                            return ListView.builder(
                                itemCount: items.items.length,
                                itemBuilder: (context, index) {
                                  RssItem item = items.items[index];
                                  text =
                                      utf8Convert(item.description.toString());
                                  title = item.title.toString();
                                  url = item.link.toString();
                                  time = item.pubDate.toString();
                                  authors = item.author.toString();
                                  return FeedCard(
                                    text: text,
                                    title: title,
                                    url: url,
                                    time: time,
                                    authors: authors,
                                  );
                                });
                          } else if (items.runtimeType == AtomFeed) {
                            AtomFeed items = snapshot.data;
                            return ListView.builder(
                                itemCount: items.items.length,
                                itemBuilder: (context, index) {
                                  AtomItem item = items.items[index];
                                  text = item.summary.toString();
                                  if (text == "null") {
                                    text = item.content.toString();
                                  }
                                  title = item.title.toString();
                                  url = item.links.first.href.toString();
                                  time = item.updated.toString();
                                  if (item.authors.isNotEmpty) {
                                    for (var author in item.authors) {
                                      authors = "${author.name} ";
                                    }
                                  } else {
                                    authors = "no author";
                                  }
                                  return FeedCard(
                                    text: text,
                                    title: title,
                                    url: url,
                                    time: time,
                                    authors: authors,
                                  );
                                });
                          }
                          // for (AtomItem item in snapshot.data.items) {
                          //   String time = item.updated.toString();
                          //   article = item.content.toString();
                          //   if (article == "null") {
                          //     article = item.summary.toString();
                          //   }
                          //   title = item.title.toString();
                          //   url = item.links.first.href.toString();
                          //   if (item.authors.isNotEmpty) {
                          //     for (var author in item.authors) {
                          //       authors = "${author.name} ";
                          //     }
                          //   } else {
                          //     authors = "no author";
                          //   }
                          // }
                        }
                        return ListView(children: tiles);
                      });
                }
              })),
    );
  }
}
