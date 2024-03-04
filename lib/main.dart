import 'package:flutter/material.dart';
import 'activities/pagemain.dart';
import 'widgets/addFeed.dart';
import 'widgets/createSite.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  int _currentIndex = 0;
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
                title: const Row(children: [
              FeedButton(),
              Text("网安2001 欧鑫奕"),
            ])),
            OutlinedButton(onPressed: null, child: Text("全部内容")),
            ShowSite()
          ]),
        )));
    // MaterialApp(
    //     theme: ThemeData(fontFamily: 'notosans'),
    //     title: '网安2001 26203011 欧鑫奕',
    //     home: Scaffold(
    //       body: PageView(
    //         controller: contorller,
    //         children: const [
    //           // Pagemain(),
    //           // Pagestar(),
    //         ],
    //       ),
    //       bottomNavigationBar: BottomNavigationBar(
    //         currentIndex: _currentIndex,
    //         type: BottomNavigationBarType.fixed,
    //         onTap: (index) {
    //           setState(() {
    //             _currentIndex = index;
    //             contorller.jumpToPage(index);
    //             contorller.animateToPage(index,
    //                 duration: Duration(seconds: 1), curve: Curves.bounceIn);
    //           });
    //         },
    //         items: const [
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.home),
    //             label: "文章",
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.home),
    //             label: "订阅源",
    //           ),
    //         ],
    //       ),
    //       appBar: AppBar(
    //         title: Text('网安2001 26203011 欧鑫奕'),
    //       ),
    //     ));
  }
}
