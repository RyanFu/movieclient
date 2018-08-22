import 'package:flutter/material.dart';
import 'liveitem.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerScreen extends StatelessWidget {
  final MoveItem liveinfo;
  PlayerScreen({Key key, @required this.liveinfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new ControllerContiner(liveinfo: liveinfo);
  }
}

class ControllerContiner extends StatefulWidget {
  final LiveItem liveinfo;
  ControllerContiner({Key key, @required this.liveinfo}) : super(key: key);
  @override
  ControllerContinerState createState() {
    return new ControllerContinerState();
  }
}

class ControllerContinerState extends State<ControllerContiner> {
  VideoPlayerController _controller;
  final key = new GlobalKey<ScaffoldState>();
  _getVideoPlayerWidget() {
    _controller = new VideoPlayerController.network(widget.liveinfo.playpath);
    var playerWidget = new Chewie(
      _controller,
      aspectRatio: 9 / 16,
      autoPlay: true,
      looping: true,
    );
    return playerWidget;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return new Scaffold(
      key: key,
      body: new Center(child: _getVideoPlayerWidget()),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'tip-off', // used by assistive technologies
        child: new Text('举报'),
        onPressed: _showTipoffDialog,
      ),
    );
  }

  void _showTipoffDialog() {
    String anchorname = widget.liveinfo.getLivename();
    showDialog<Null>(
      context: context,
      // AlertDialog：质感设计中的告警对话框
      child: new AlertDialog(
          // content：对话框的可选内容，以浅色字体显示在对话框的中心
          content: new Text("举报主播:$anchorname"),
          // actions：显示在对话框底部的可选操作
          actions: <Widget>[
            // FlatButton：质感设计中的平面按钮
            new FlatButton(onPressed: _tipOff, child: new Text('确定'))
          ]),
    );
  }

  _tipOff() async {
    key.currentState.showSnackBar(new SnackBar(
      content: new Text("已经将该主播加入黑名单,会在下次启动时自动生效"),
    ));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> black = prefs.getStringList('black');
    if (black == null) {
      black = new List<String>();
      black.add(widget.liveinfo.getUid());
    } else {
      black.add(widget.liveinfo.getUid());
    }
    await prefs.setStringList('black', black);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
    _controller.pause();
  }
}
