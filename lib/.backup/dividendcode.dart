import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class DividendCode {
  var urlhost = "xelease.github.io";
  var urlpath = "/rdividend/alidividendcode/";
  getAliDividendcode() async {
    var jsonstr = await getJson();
    var jsonbody = json.decode(jsonstr);
    if (jsonbody['code'] != null) {
      return jsonbody['code'];
    } else {
      return null;
    }
  }

  getJson() async {
    var uri = "https://" + urlhost + urlpath;

    try {
      Dio dio = new Dio();
      Response response = await dio.get(uri);
      return response.data;
    } catch (exception) {
      print('Failed');
      print(exception);
    }
  }
}
