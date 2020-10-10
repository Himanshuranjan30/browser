import 'dart:async';
import 'dart:ffi';
import 'dart:convert';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  String uid;
  Browser({Key key, @required this.uid}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  TextEditingController _textcontroller = TextEditingController();
  WebViewController _webViewController;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  int i = 0;
  List<String> urls = [];
  void initState() {
    database();
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      urls.add(url);
      await coll.insert({
        "_id": widget.uid,
        "url": json.encode(urls),
      });
    });
  }

  String test;
  String urli;
  Widget searchbar() {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 120,
          ),
          SizedBox(
            width: 40,
          ),
          GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => flutterWebviewPlugin.goBack(),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(Icons.arrow_forward),
            onTap: () => flutterWebviewPlugin.goForward(),
          )
        ],
      ),
    );
  }

  var coll;

  var db;

  database() async {
    //final User user = await _auth.currentUser;
    db = await mongo.Db.create(
        "mongodb+srv://himu:himu@cluster0.qkmvt.mongodb.net/urls?retryWrites=true&w=majority");
    await db.open();
    coll = db.collection(widget.uid);

    print('DB Connected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchbar(),
        actions: [],
      ),
      body: WebviewScaffold(
        url: urli == null ? 'https://www.google.com' : urli,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
      ),
    );
  }
}
