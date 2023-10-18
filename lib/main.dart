import 'package:flutter/material.dart';
import './activities/bottomnav.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'notosans'),
      title: '网安2001 26203011 欧鑫奕',
      home: const BottomNav(),
      );
  }
}