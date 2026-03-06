import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final Function(Map<String, dynamic>) transactionSuccessfullCallback;
  final Function(Map<String, dynamic>) transactionFailureCallback;

  const WebViewExample({
    Key? key,
    required this.url,
    required this.transactionSuccessfullCallback,
    required this.transactionFailureCallback,
  }) : super(key: key);

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _interceptNavigation,
          onPageFinished: (String url) {
            // ✅ Disable zoom on input focus
            _controller.runJavaScript('''
              var meta = document.querySelector('meta[name=viewport]');
              if (meta != null) {
                meta.setAttribute('content',
                  'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
              } else {
                var newMeta = document.createElement('meta');
                newMeta.name = 'viewport';
                newMeta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
                document.getElementsByTagName('head')[0].appendChild(newMeta);
              }
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }

  NavigationDecision _interceptNavigation(NavigationRequest request) {
    if (request.url.contains("response")) {
      try {
        var uri = Uri.dataFromString(request.url);
        var response = uri.queryParameters['response'];
        if (response != null) {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          String decoded = stringToBase64.decode(response);
          var jsonResponse = jsonDecode(decoded);

          Navigator.maybePop(context);

          final code = jsonResponse['responseCode'];
          if (code == "00" || code == "0") {
            widget.transactionSuccessfullCallback(jsonResponse);
          } else {
            widget.transactionFailureCallback(jsonResponse);
          }
        }
        return NavigationDecision.prevent; // ✅ stop blank page
      } catch (e) {
        debugPrint("Navigation intercept error: $e");
        return NavigationDecision.prevent;
      }
    }
    return NavigationDecision.navigate;
  }
}