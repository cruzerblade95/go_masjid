import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DaftarKariah extends StatefulWidget {
  const DaftarKariah({super.key});

  @override
  State<DaftarKariah> createState() => _DaftarKariahState();
}

class _DaftarKariahState extends State<DaftarKariah> {
  @override
  Widget build(BuildContext context) {
    return WebView();
  }
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  //initialize webview
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://gomasjid.my/external-form/ahli-kariah-add.php'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: BackButton(),
          title: const Text('Pendaftaran Kariah - Ketua Keluarga')),
      body: SafeArea(
          child: WebViewWidget(controller: controller)
      ),
    );
  }
}
