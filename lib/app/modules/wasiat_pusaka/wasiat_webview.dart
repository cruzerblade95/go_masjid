import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_pusaka.dart';
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
        ..loadRequest(Uri.parse(widget.s))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // loading = true;
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');

              setState(() {});
            },
            onPageFinished: (String url) {
              print("url $url");
              // loading=false;
              setState(() {});

            },
            onWebResourceError: (WebResourceError error) {
              // loading=false;
              setState(() {});
            },
            onNavigationRequest: (NavigationRequest request) {
              // var url = "https://www.laplata.com.py/";
              var urlResult;
              if (request.url.contains("status_id=1")) {
                // urlResult = Uri.parse(url);
                const AlertDialog(
                    title: Text('Status Pembayaran'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Pembayaran Berjaya.'),
                          Text('Resit telah dihantar ke email anda'),
                        ],
                      ),
                    )
                );
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.of(context).pushReplacementNamed('pay', arguments: urlResult.queryParameters);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WasiatPusakaHome()));
              }else if (request.url.contains("status_id=3")) {
                // await AppRoute.pushReplacement(context, MartsjidCartPage());
                const AlertDialog(
                    title: Text('Status Pembayaran'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Pembayaran Tidak Berjaya.'),
                          Text('Sila cuba lagi'),
                        ],
                      ),
                    )
                );
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pop(context);
                // flutterWebviewPlugin.hide();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WasiatPusakaHome()));
              }
              return NavigationDecision.navigate;
            }
          )
        );
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
