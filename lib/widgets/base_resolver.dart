import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class Network {
  get(url) async {
    final dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      return "";
    }
  }
}

class Resolver {
  sendrequest(url) async {
    Object feed;
    final neet = Network();
    var rawxml = await neet.get(url);
    if (rawxml.toString().contains("rss")) {
      feed = RssFeed.parse(rawxml);
    } else {
      feed = AtomFeed.parse(rawxml);
    }
    return feed;
    // print(feed2.items.isEmpty.toString() + "a1");
    // print(feed.items.isEmpty.toString() + "a2");
  }
}
