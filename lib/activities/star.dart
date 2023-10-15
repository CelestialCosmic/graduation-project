import 'dart:math';

import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  @override
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return 
          FloatingActionButton(
            onPressed: () {
              showDialog(context: context, builder:(context) 
              {
                return const AlertDialog(
                  title:Text("添加订阅源"),
                  content: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: 
                      TextField(
                        maxLines: 1,
                      ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      ElevatedButton(onPressed:null,
                      child: Text("添加")), 
                    ],
                  ),

                );
              });
          });
  }
}
