import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WasiatWebview extends StatefulWidget {
  WasiatWebview(this.s, {super.key});

  String s;

  @override
  State<WasiatWebview> createState() => _WasiatWebviewState();
}

class _WasiatWebviewState extends State<WasiatWebview> {
  @override
  Widget build(BuildContext context) {
    return WebView(widget.s);
  }
}

class WebView extends StatefulWidget {
  WebView(this.s, {super.key});

  String s;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initialize webview
    setState(() {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.s));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(),
          title: const Text('AMANAH i-Pusaka')),
      body: SafeArea(
          child: WebViewWidget(controller: controller)
      ),
    );
  }
}
