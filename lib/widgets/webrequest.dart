import 'dart:io';

import 'package:dio/dio.dart';
class Network {
  get(url) async {
    final dio = Dio();
    final response =
        await dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      print("${response.statusCode}");
      return "";
    }
  }
}
