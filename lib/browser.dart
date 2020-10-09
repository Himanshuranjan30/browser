import 'dart:async';
import 'dart:ffi';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  TextEditingController _textcontroller = TextEditingController();
  WebViewController _webViewController;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  void initState() {
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
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
