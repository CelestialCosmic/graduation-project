// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'widgets/widget_subscript.dart';
import 'activities/page_site.dart';

void main() => runApp(const MyApp());

// 淡蓝 const Color.fromARGB(255, 209, 231, 254)
// 淡紫 const Color.fromARGB(255, 243, 217, 255)
// 浅蓝 const Color.fromARGB(255, 196, 208, 251)
// 淡绿 const Color.fromARGB(255, 186, 241, 227)
// 天蓝 const Color.fromARGB(255, 39, 191, 253)
// 抹茶 const Color.fromARGB(255, 231, 249, 244)

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  refreshState() {
    setState(() {});
  }

  PageController contorller = PageController();
  List<Widget> children = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'notosans'),
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 231, 249, 244),
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 196, 208, 251),
              title: Row(children: [
                const Expanded(
                    child: Text(
                  "网安2001 欧鑫奕",
                  overflow: TextOverflow.fade,
                )),
                Align(
                  alignment: const Alignment(1.0, 0.0),
                  child: FeedButton(
                    refresh: refreshState,
                  ),
                ),
              ])),
          body: ShowSite()),
    );
  }
}
