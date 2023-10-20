import 'package:flutter/material.dart';
import './storage.dart';

class Star extends StatefulWidget {
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  TextEditingController rssUrlController = TextEditingController();
  TextEditingController rssNameController = TextEditingController();
  List<Widget> tiles = [];
  _addFeedButton(context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("添加订阅源"),
                            content: Column(
                              children: [
                                SizedBox(
                                  child: TextField(
                                    controller: rssNameController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '名字',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    controller: rssUrlController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '网站的rssurl',
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5.0)),
                                ElevatedButton(
                                  child: const Text("添加"),
                                  onPressed: () {
                                    if (rssUrlController.text.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("不能为空！"),
                                            );
                                          });
                                    } else {
                                      var instance = SharedPref();
                                      instance.save(rssNameController.text,
                                          rssUrlController.text);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("添加成功！"),
                                            );
                                          });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ))
      ],
    );
  }

  Widget build(BuildContext context) {
    return _addFeedButton(context);
  }
}
