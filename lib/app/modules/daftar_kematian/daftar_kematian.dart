import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DaftarKematian extends StatefulWidget {
  const DaftarKematian({super.key});

  @override
  State<DaftarKematian> createState() => _DaftarKematianState();
}

class _DaftarKematianState extends State<DaftarKematian> {
  @override
  Widget build(BuildContext context) {
    return WebViewDaftarKematian();
  }
}

class WebViewDaftarKematian extends StatefulWidget {
  const WebViewDaftarKematian({super.key});

  @override
  State<WebViewDaftarKematian> createState() => _WebViewDaftarKematianState();
}

class _WebViewDaftarKematianState extends State<WebViewDaftarKematian> {
  //initialize webview
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://gomasjid.my/external-form/pendaftaran-kematian.php'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(),
          title: const Text('Pendaftaran Kematian')),
      body: SafeArea(
          child: WebViewWidget(controller: controller)
      ),
    );
  }
}

