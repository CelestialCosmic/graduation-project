import 'package:flutter/material.dart';

_addFeedDialog(BuildContext context) {
  AlertDialog noto = AlertDialog(
      title: const Text("添加订阅源"),
      content:
      Row(children: [
          TextField(
              decoration: InputDecoration(
              hintText: "输入订阅源 url",
              border: OutlineInputBorder(),
            )),
          ElevatedButton(
            child: const Text("添加"),
            onPressed: () => print("Pressed"),
          )
      ]
          )
          );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return noto;
      });
}

class Star extends StatefulWidget {
  @override
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: MediaQuery.of(context).size.width / 2 + 100,
        top: MediaQuery.of(context).size.height / 2,
        child:
          FloatingActionButton(
            onPressed: () {
          _addFeedDialog(context);
          }));
  }
}
