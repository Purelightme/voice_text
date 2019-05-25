import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'models/speech.dart';

class Result extends StatefulWidget {
  Result({this.filePath});

  String filePath;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  Speech res = new Speech();
  bool completed = false;

  @override
  void initState() {
    _getResult();
    super.initState();
  }

  Future<Speech> _getResult() async {
    var dio = new Dio();
    FormData formData = new FormData.from(
        {"file": new UploadFileInfo(new File(widget.filePath), "upload.wav")});
    Response response =
        await dio.post("http://voice.bettertaro.com/", data: formData);
    var rs = Speech.fromJson(json.decode(response.data));
    setState(() {
      res = rs;
      completed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('转换结果'),
      ),
      body: completed ? Container(
        child: Center(
            child: res.errNo == 0
                ? ListView(
                children: res.result.map((str) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(str,softWrap: true,),
                  );
                }).toList())
                : Container(
              padding: EdgeInsets.all(10),
              child: Text(
                res.errMsg,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                ),
                softWrap: true,
              ),
            )
        ),
      ) : CircularProgressIndicator()
    );
  }
}
