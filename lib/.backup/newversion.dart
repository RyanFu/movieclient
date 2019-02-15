import 'dart:convert';
import 'dart:io';
//import 'package:get_version/get_version.dart';
import 'package:dio/dio.dart';

class NewVersion {
  var urlhost = "xelease.github.io";
  var urlpath = "/release_path/com_youone_notwo/";
  Map<String, String> newversioninfo = new Map<String, String>();
  compareCode() async {
    String newversion = await getversionCode();
    String nowversion = await getnowversionCode();
    var newcode = int.parse(newversion);
    var nowcode = int.parse(nowversion);
    if (newcode > nowcode) {
      return newversioninfo;
    } else
      return null;
  }

  getversionCode() async {
    var jsonstr = await getJson();
    var jsonbody = json.decode(jsonstr);
    if (jsonbody['versioncode'] != null) {
      this.newversioninfo['code'] = jsonbody['versioncode'];
      this.newversioninfo['name'] = jsonbody['versionname'];
      this.newversioninfo['path'] = jsonbody['dpath'];
      this.newversioninfo['info'] = jsonbody['info'];
      return jsonbody['versioncode'];
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

  getnowversionCode() async {
    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
      return projectCode;
    } catch (exception) {
      print('Failed');
      print(exception);
    }
  }
}
