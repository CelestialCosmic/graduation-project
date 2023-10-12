import 'package:flutter/material.dart';
import './activities/bottomnav.dart';
// import './activities/home.dart';
// import './activities/star.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '网安2001 26203011 欧鑫奕',
      home: BottomNav(),
      );
  }
}