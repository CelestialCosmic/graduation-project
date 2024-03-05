import 'package:flutter/material.dart';
import 'widgets/addFeed.dart';
import 'widgets/createSite.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  PageController contorller = PageController();
  List<Widget> children = [];
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'notosans'),
        home: Scaffold(
            body: Center(
          child: Column(children: [
            AppBar(
                title: const Row(children: [
              FeedButton(),
              Text("网安2001 欧鑫奕"),
            ])),
            OutlinedButton(onPressed: null, child: Text("全部内容")),
            ShowSite()
          ]),
        )));
  }
}
