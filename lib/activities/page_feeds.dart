import 'dart:async';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutterrss/activities/page_feed_detail.dart';
import 'package:flutterrss/widgets/base_resolver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorLoading extends StatelessWidget {
  final Function() refresh;
  const ErrorLoading({super.key, required this.refresh});
  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Spacer(
        flex: 1,
      ),
      Center(
          child: Column(children: [
        Text("fetch error"),
        SizedBox(
          height: 5,
        ),
        Text("tap button to refresh"),
        SizedBox(
          height: 5,
        ),
        Text("or check whether the link is valid")
      ])),
      Spacer(
        flex: 1,
      ),
    ]);
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Text("fetching data"),
        Spacer(
          flex: 1,
        )
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 191, 253),
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
                          Timer(const Duration(seconds: 5), () {
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
                          for (AtomItem item in snapshot.data.items) {
                            String authors = "";
                            String url = "";
                            String title = "";
                            String a = item.updated.toString();
                            String article = "";
                            article = item.content.toString();
                            if (article == "null") {
                              article = item.summary.toString();
                            }
                            title = item.title.toString();
                            url = item.links.first.href.toString();
                            if (item.authors.isNotEmpty) {
                              for (var author in item.authors) {
                                authors = "${author.name} ";
                              }
                            } else {
                              authors = "no author";
                            }
                            tiles.add(
                              Card(
                                  color: Colors.blueGrey,
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FeedDetail(
                                                      text: article,
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
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 12),
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                              )),
                                              const SizedBox(width: 20),
                                              Flexible(
                                                  child: Text(
                                                a,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 12),
                                                overflow: TextOverflow.visible,
                                                maxLines: 1,
                                                softWrap: false,
                                              ))
                                            ],
                                          )
                                        ],
                                      ))),
                            );
                          }
                          return ListView(children: tiles);
                        }
                      });
                }
              })),
    );
  }
}
