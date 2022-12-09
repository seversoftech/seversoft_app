import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  late WebViewController _controller;
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
        body: RefreshIndicator(
            onRefresh: () {
              return (_controller.reload());
            },
            child: willMethod(context)),
        floatingActionButton: FloatingActionButton.small(
          elevation: 10,
          tooltip: 'Refresh',
          onPressed: () {
            reloadWebView();
          },
          backgroundColor: Color.fromARGB(225, 79, 70, 229),
          child: const Icon(Icons.refresh_sharp),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,

        // bottomNavigationBar: ButtomNav(),
      ),
    );
  }

  WillPopScope willMethod(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 2.5,
            color: Color.fromARGB(225, 79, 70, 229),
            backgroundColor: Colors.white,
            value: progress,
          ),
          Expanded(
            child: WebView(
              initialUrl: 'https://app.seversoftech.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future
                    .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              onProgress: (progress) =>
                  setState(() => this.progress = progress / 100),
              onWebResourceError: (WebResourceError error) {
                _loadHtmlFromAssets();
                setState(() {
                  ;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

//GO BACK IN WEBVIEW
  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Exit ?'),
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

// RELOAD WEBVIEW
  reloadWebView() {
    _controller.reload();
    SnackTest.show(context, 'Reloading...');
  }

// LOAD ERROR HTML PAGE
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/error.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

// SNACKBAR TEXT CLASS
class SnackTest {
  final String message;

  const SnackTest({
    required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        //behavior: SnacBarBehavior.floating,
        content: Text(message),
        duration: new Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: Color.fromARGB(225, 79, 70, 229),
        // action: SnackBarAction(
        //   textColor: Color(0xFFFAF2FB),
        //   label: 'OK',
        //   onPressed: () {},
        // ),
      ),
    );
  }
}
