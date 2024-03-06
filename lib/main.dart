import 'package:flutter/material.dart';
import 'widgets/addFeed.dart';
import 'widgets/ShowSite.dart';

void main() => runApp(const MyApp());

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
            body: Center(
          child: Column(children: [
            AppBar(
                title: Row(children: [
              FeedButton(
                refresh: refreshState,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text("网安2001 欧鑫奕"),
            ])),
            // OutlinedButton(onPressed: null, child: Text("全部内容")),
            // ignore: prefer_const_constructors
            ShowSite()
          ]),
        )));
  }
}
