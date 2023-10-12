import 'package:flutter/material.dart';
import './home.dart';
import './star.dart';
class BottomNav extends StatefulWidget{
  const BottomNav({super.key});
  @override
  State <BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>{
  int _currentIndex = 0;
  final List<Widget> _activities= const[
    Home(),
    Star()
    ];
  @override
  Widget build(BuildContext context){
      return Scaffold(
            appBar: AppBar(title: const Text("自托管rssApp")),
            body: _activities[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
              BottomNavigationBarItem(
              icon:  Icon(Icons.home),
              label:  "首页",
              ),
              BottomNavigationBarItem(
              icon:  Icon(Icons.home),
              label:  "星标",
              ),
            ],
            ),
          );
  }
}
