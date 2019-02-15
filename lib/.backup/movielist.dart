import 'dart:convert';
import 'dart:io';
import 'movieitem.dart';
import 'package:dio/dio.dart';
import 'dart:async';

abstract class MoveList {
  getMoveList();
}


class YKOList implements MoveList {
  var urlhost = "okzy.me";
  var urlpath_list = "/?m=vod-type-id-1.html";
  var urlpath_item="";
  var livelist = new List<LiveItem>();

  Future<List<LiveItem>> getLiveList() async {
    var jsonstr = await getJson();
    Map<String, dynamic> jsonlist = json.decode(jsonstr);

    var list = jsonlist['data']['info'][0]['list'];

    if (list.length > 3) {
      for (var i = 1; i < list.length; i++) {
        PaPaLiveItem liveitem =
            new PaPaLiveItem(list[i]['avatar'], list[i]['pull']);
        liveitem.setUsernicename(list[i]['user_nicename']);
        liveitem.setUid(list[i]['uid']);
        this.livelist.add(liveitem);
      }
      return livelist;
    } else {
      return null;
    }
  }

  getListHtml() async {
    var uri = "https://" + urlhost + urlpath_list;

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
