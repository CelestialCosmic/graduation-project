import 'package:flutter/material.dart';
import './home.dart';
import '../widgets/show_booked.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PageController _controller = PageController();
  int _currentIndex = 0;
  _navbar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _controller.jumpToPage(index);
        });
        
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "文章",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "订阅源",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _activities = [Home(), ShowFeedUrls()];
    return Scaffold(
        appBar: AppBar(title: const Text("自托管rssApp")),
        body: PageView(
          controller: _controller,
          children: _activities,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              _controller.jumpToPage(index);
            });
          },
        ),
        bottomNavigationBar: _navbar());
  }
}
