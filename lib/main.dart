import 'package:flutter/material.dart';
import 'package:recorder_wav/recorder_wav.dart';
import 'package:voice_text/result.dart';
import 'package:permission_handler/permission_handler.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String fp = 'test';
  String text = '按下录音';

  @override
  void initState(){
    PermissionHandler().requestPermissions([
      PermissionGroup.storage,
      PermissionGroup.microphone
    ]);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
            child: ListView(children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Colors.green,
                  width: 50.0,
                  height: 50.0,
                  child: Center(
                    child: Text(text),
                  ),
                ),
                onTapDown: (TapDownDetails details) {
                  RecorderWav.startRecorder();
                  setState(() {
                    text = '正在录音...';
                  });
                },
                onTapUp: (TapUpDetails details) async {
                  String filePath = await RecorderWav.StopRecorder();
                  setState(() {
                    fp = filePath;
                    text = '按住录音';
                  });
                },
              ),
              Text('文件路径：'),
              Text(fp),
              SizedBox(
                width: 340,
                height: 30,
                child: Builder(
                  builder: (context) => RaisedButton(
                    child: Text('查看文本'),
                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Result(
                          filePath: fp,
                        ))
                      );
                    },
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '''
使用方式：长按录音，松开停止，点击查看文本，限制最多60秒，普通话。
                  '''
                ),
              )
            ])),
      ),
    );
  }
}