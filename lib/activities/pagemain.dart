import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutterrss/widgets/xmlresolve.dart';
import '../widgets/storage.dart';

class NewsBlock extends StatelessWidget {
  loadurl() async {
    return ListTile();
  }

  Widget _initList() {
    String url;
    final x = Xml();
    Widget list;
    list = x.resolvefeed();
    // list.add(
    // ListTile(
    //   title: Text("3"),
    //   subtitle: Text("1"),
    // ));
    return list;
  }

  const NewsBlock({super.key});
  Widget build(BuildContext context) {
    return Container(child: _initList());
  }
}

class Pagemain extends StatefulWidget {
  @override
  const Pagemain({super.key});
  State<Pagemain> createState() => _PagemainState();
}

class _PagemainState extends State<Pagemain> {
  @override
  Widget build(BuildContext context) {
    return NewsBlock();
  }
}
