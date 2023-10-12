import 'package:flutter/material.dart';

class NewsBlock extends StatelessWidget{
  @override
  const NewsBlock({super.key});
  Widget build(BuildContext context){
    String _title = "default";
    return ListView(
      children: [
        ListTile(
          title: Text(_title),
        ),
        ListTile(
          title: Text(_title),
        )
      ]
      );
  }
}

class Home extends StatefulWidget{
  @override
  const Home({super.key});
  State<Home> createState()=> _HomeState();
}
class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return NewsBlock();
}}