import 'package:flutter/material.dart';

class NewsBlock extends StatelessWidget {
  List<Widget> _initList() {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromARGB(255, 233, 33, 33)),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.fromLTRB(5,10,5,0),
          height: 120,
          child: Column(children: [
            const Expanded(
                child: Text(
              "title",
              maxLines: 1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            Row(children: [
              const Expanded(child: Text("data")),
              // SizedBox(
              //   height: 80,
              //   width: 80,
              //   child: Image.network(
              //       "https://cdn.sstatic.net/Img/teams/teams-illo-free-sidebar-promo.svg?v=47faa659a05e"),
              // )
            ]),
          ]),
        ),
      );
    }
    return list;
  }

  const NewsBlock({super.key});
  Widget build(BuildContext context) {
    return ListView(
      children: _initList(),
    );
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
