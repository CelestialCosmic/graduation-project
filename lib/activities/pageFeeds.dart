import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutterrss/activities/FeedReader.dart';
import 'package:flutterrss/widgets/feedResolver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(
        flex: 1,
      ),
      Center(
          child: Column(children: [
        const Text("fetching data"),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton(
            onPressed: () {
              // widget.refresh;
            },
            child: const Text("refresh"))
      ])),
      const Spacer(
        flex: 1,
      ),
    ]);
  }
}

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Text("error"),
        Spacer(
          flex: 1,
        )
      ],
    );
  }
}

// 第二屏
class PageFrame extends StatelessWidget {
  feedUrl(key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key).toString();
    return value;
  }

  final String name;
  const PageFrame({super.key, required this.name});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
          child: FutureBuilder(
              future: feedUrl(name),
              builder: (context, snapshot) {
                {
                  return FutureBuilder(
                      future: Resolver().sendrequest(snapshot.data.toString()),
                      builder: (context, AsyncSnapshot snapshot) {
                        List<Widget> tiles = [];
                        if (!snapshot.hasData) {
                          return Loading();
                        } else {
                          for (AtomItem item in snapshot.data.items) {
                            String authors = "";
                            String url = "";
                            String title = "";
                            String a = item.updated.toString();
                            title = item.title.toString();
                            url = item.links.first.href.toString();
                            if (item.authors.isNotEmpty) {
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
                                        Text(authors),
                                        const SizedBox(width: 20),
                                        Flexible(
                                            child: Text(
                                          a,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ))
                                      ],
                                    )
                                  ],
                                )));
                          }
                          return ListView(children: tiles);
                        }
                      });
                }
              })),
    );
  }
}
