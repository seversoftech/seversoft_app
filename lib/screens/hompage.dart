import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Hompage extends StatefulWidget {
  @override
  HompageState createState() => HompageState();
}

class HompageState extends State<Hompage> {
   WebViewController? _controller;
  double progress = 0;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: RefreshIndicator(
            onRefresh: () {
              return (_controller!.reload());
            },
            child: willMethod(context)),
      ),
    );
  }

  WillPopScope willMethod(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 1,
            color: Color.fromARGB(225, 79, 70, 229),
            backgroundColor: Colors.white,
            value: progress,
          ),
          Expanded(
            child: WebView(
              initialUrl: "https://app.seversoftech.com",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future
                    .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              onProgress: (progress) =>
                  setState(() => this.progress = progress / 100),
              onWebResourceError: (WebResourceError error) {
                setState(
                  () {
                    _loadHtmlFromAssets();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//GO BACK IN WEBVIEW
  Future<bool> _goBack(BuildContext context) async {
    if (await _controller!.canGoBack()) {
      _controller!.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Are you serious?'),
                actions: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }

// LOAD ERROR HTML PAGE
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/error.html');
    _controller!.loadUrl(Uri.dataFromString(
      fileText,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }
}
