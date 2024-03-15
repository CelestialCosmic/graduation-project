// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FeedDetail extends StatelessWidget {
  final String text;
  final String title;
  final String url;
  FeedDetail(
      {super.key, required this.text, required this.title, required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 249, 244),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 196, 208, 251),
          title: Text(title),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(width: 10),
            Flexible(
                child: Text(
              url,
            )),
            const SizedBox(width: 10),
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Flexible(
                child: Html(data: text),
              ),
              const SizedBox(width: 20)
            ],
          )
        ])));
  }
}
