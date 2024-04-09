// ignore_for_file: prefer_const_constructors_in_immutables
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedDetail extends StatelessWidget {
  final String text;
  final String title;
  final String url;
  Future<void> _launchUrl(context, url) async {
    Uri u = Uri.parse(url);
    launchUrl(u);
  }
// <asynchronous suspension> is not an indication of a problem, it just indicates that code execution is not synchronous code executed line-by-line, but instead a callback from a completed Future started at some position in the callstack

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
            Card(
                child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("外部链接提示"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("即将使用浏览器访问如下链接："),
                                    Text(url),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton(
                                            child: const Text("取消"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                _launchUrl(context, url);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const AlertDialog(
                                                          content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                            Text(
                                                                "正在处理链接，如果没有出现，检查网络"),
                                                            Text("三秒后自动关闭")
                                                          ]));
                                                    });
                                                Timer(
                                                    const Duration(seconds: 3),
                                                    () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text("确认")),
                                        ])
                                  ]),
                            );
                          });
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(10), child: Text(url)))),
            const SizedBox(width: 10),
          ]),
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
