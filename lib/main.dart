import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(home: CrashingWebViewExample()));

class CrashingWebViewExample extends StatefulWidget {
  @override
  _CrashingWebViewExampleState createState() => _CrashingWebViewExampleState();
}

class _CrashingWebViewExampleState extends State<CrashingWebViewExample> {
  WebViewController _webViewController;
  double _webViewHeight = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(height: 100, color: Colors.green),
          Container(
            height: _webViewHeight,
            child: WebView(
              initialUrl: 'https://en.wikipedia.org/wiki/Cephalopod_size',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) => _onPageFinished(context, url),
              onWebViewCreated: (controller) async {
                _webViewController = controller;
              },
            ),
          ),
          Container(height: 100, color: Colors.yellow),
        ],
      ),
    );
  }

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController.evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }
}
