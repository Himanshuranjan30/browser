import 'dart:async';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final Set<String> _favorites = Set<String>();
  TextEditingController _textcontroller = TextEditingController();
  WebViewController _webViewController;
  String test;
  String url;
  Widget searchbar() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 230,
            child: AutoSizeTextField(
              controller: _textcontroller,
              onEditingComplete: () {
                setState(() {
                  url = _textcontroller.text;
                });
              },
            ),
          ),
          GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                _webViewController.loadUrl(url);
              }),
          SizedBox(
            width: 40,
          ),
          GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => _webViewController.goBack(),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(Icons.arrow_forward),
            onTap: () => _webViewController.goForward(),
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
      body: WebView(
        initialUrl: 'https://www.google.com',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          test = await _webViewController.currentUrl();
          print(test);
        },
      ),
    );
  }
}
