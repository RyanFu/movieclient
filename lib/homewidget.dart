import 'package:flutter/material.dart';
import 'movieitem.dart';
import 'movielist.dart';
import 'liveplayer.dart';
import 'newversion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class HomeContiner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Home();
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  final key = new GlobalKey<ScaffoldState>();
  var livelist = [];
  @override
  Widget build(BuildContext context) {
    MoveList livelist = new MoveList();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text('movie'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _showAnnounce),
          new IconButton(
              icon: new Icon(Icons.cached), onPressed: _getNewVersion),
        ],
      ),
      body: livelist,
    );
  }

  _showVersionDialog(isnew) {
    if (isnew != null) {
      showDialog<Null>(
        context: context,
        child: new SimpleDialog(
          title: const Text('新版本检测'),
          children: <Widget>[
            new SimpleDialogOption(
              child: const Text('发现新版本,你可以直接长按下面的下载地址来复制'),
            ),
            new SimpleDialogOption(
              child: Text('版本号' + isnew['name']),
            ),
            new GestureDetector(
              child: new SimpleDialogOption(
                child: Text('下载地址:' + isnew['path']),
              ),
              onLongPress: () {
                Clipboard.setData(new ClipboardData(text: isnew['path']));
                key.currentState.showSnackBar(new SnackBar(
                  content: new Text("下载地址已经复制"),
                ));
              },
            ),
            new SimpleDialogOption(
              child: Text('新版本说明:' + isnew['info']),
            ),
          ],
        ),
      );
    } else {
      showDialog<Null>(
        context: context,
        child: new SimpleDialog(
          title: const Text('新版本检测'),
          children: <Widget>[
            new SimpleDialogOption(
              child: const Text('没有检测到新的版本'),
            ),
          ],
        ),
      );
    }
  }

  _getNewVersion() {
    key.currentState.showSnackBar(new SnackBar(
      content: new Text("检测新版本需要时间，请稍后"),
    ));
    new NewVersion().compareCode().then(_showVersionDialog);
  }

  _showAnnounce() {
    showDialog<Null>(
      context: context,
      child: new SimpleDialog(
        title: const Text('声明'),
        children: <Widget>[
          new SimpleDialogOption(
            child: const Text('本应用倡导一个健康的环境，由于所提供电影系来自于互联网抓取'),
          ),
          new SimpleDialogOption(
            child: const Text('如您发现有不健康内容，可以点击举报按钮举报相应主播'),
          ),
          new SimpleDialogOption(
            child: const Text('系统会在本地第一时间对其进行移除'),
          ),
          new SimpleDialogOption(
            child: const Text(
                ' Icons made by Smashicons from  www.flaticon.com is licensed by 3CC 3.0'),
          ),
        ],
      ),
    );
  }
}

class LiveList extends StatefulWidget {
  @override
  LiveListState createState() {
    LiveListState liveliststate = new LiveListState();
    return liveliststate;
  }
}

class LiveListState extends State<LiveList> {
  final _livelist = new List<MoveItem>();

  _getMoveList(list) {
    print("geted Movelist");
    _filterLiveList(list).then((filtedlist) {
      setState(() {
        _livelist.addAll(filtedlist);
      });
    });
  }

  _filterLiveList(list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> black = prefs.getStringList('black');
    if (black == null) {
      black = new List<String>();
      await prefs.setStringList('black', black);
    } else
      list.removeWhere((item) {
        bool isbacked = black.contains(item.getUid());
        if (isbacked) {
          _livelist.removeWhere(
              (listeditem) => listeditem.getUid() == item.getUid());
        }
        return isbacked;
      });
    return list;
  }

  Widget _buildLiveList() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _livelist.length) {
            // 获取列表

            new YKOList().getMoveList().then(_getMovieList);
            
          }

          return _buildRow(_livelist[index], context);
        });
  }

  Widget _buildRow(LiveItem pair, BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new PlayerScreen(liveinfo: pair),
          ),
        );
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(pair.getMovename()),
            ),
            new Image.network(pair.thumbnail),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLiveList();
  }
}
