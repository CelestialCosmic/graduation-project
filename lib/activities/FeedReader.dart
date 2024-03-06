import 'package:flutter/material.dart';

class FeedDetail extends StatelessWidget {
  final String text;
  final String title;
  final String url;
  FeedDetail(
      {super.key, required this.text, required this.title, required this.url});
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(children: [
          Text(url),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Flexible(
                  child: Text(
                text,
                softWrap: true,
              )),
              const SizedBox(width: 20)
            ],
          )
        ]));
  }
}
