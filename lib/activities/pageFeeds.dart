import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowFeeds extends StatelessWidget {
  urls(key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key).toString();
    return value;
  }

  final String name;
  const ShowFeeds({required this.name});
  // String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("url"),
        ),
      ),
    );
  }
}
