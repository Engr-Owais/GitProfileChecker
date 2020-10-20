import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  final String title;

  final String url;

  InfoScreen(this.title, this.url);
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _key = UniqueKey();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  // ignore: unused_field
  var _isLoading;
  // ignore: unused_field
  var _init = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  num position = 1;
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: doneLoading,
              onPageStarted: startLoading,
            ),
            Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        ));
  }
}
