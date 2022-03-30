import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({
    Key? key,
    required this.url,
    required this.text,
  }) : super(key: key);
  final String url;
  final String text;

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebView(
        onWebViewCreated: _controller.complete,
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          if (kDebugMode) print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          if (kDebugMode) print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          if (kDebugMode) print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
        initialUrl: widget.url,
      ),
    );
  }
}
