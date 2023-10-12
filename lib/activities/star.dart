import 'package:flutter/material.dart';
class Star extends StatefulWidget{
  @override
  const Star({super.key});
  State<Star> createState()=> _StarState();
}
class _StarState extends State<Star>{
  @override
  Widget build(BuildContext context){
    return const Center(child: Text("345"),
    );
  }
}