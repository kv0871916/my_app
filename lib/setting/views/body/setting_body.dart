import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

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
  final _controller = Completer<WebViewController>();
  final _windowscontroller = WebviewController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    if (Platform.isWindows) {
      initPlatformState();
    }
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await _windowscontroller.initialize();

      await _windowscontroller.setBackgroundColor(Colors.transparent);
      await _windowscontroller
          .setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _windowscontroller.loadUrl(widget.url);

      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isWindows
          ? Webview(
              _windowscontroller,
            )
          : WebView(
              onWebViewCreated: _controller.complete,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (int progress) {
                if (kDebugMode)
                  print('WebView is loading (progress : $progress%)');
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
