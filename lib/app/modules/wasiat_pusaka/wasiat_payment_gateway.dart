import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'app_webview_page.dart';

class WasiatPaymentGateway extends StatefulWidget {
  final String billerCode;
  final String idOrder;

  WasiatPaymentGateway({required this.billerCode, required this.idOrder, Key? key}) : super(key: key);

  @override
  State<WasiatPaymentGateway> createState() => _WasiatPaymentGatewayState();
}

class _WasiatPaymentGatewayState extends State<WasiatPaymentGateway> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // context.read<MartsjidHomeState>().getAl
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      print("your data: $url");
      print("idOrderPaymentGateway : ${widget.idOrder}");
      if (url.contains("status_id=1")) {
        // await context
        //     .read<InfaqTabungState>()
        //     .updateStatusBayaran('1', widget.idOrder);

        // await context
        //     .read<MartsjidHomeState>()
        //     .loyaltyPoint(widget.noIc, double.parse(widget.amounDalamSen));
        // await context
        //     .read<MartsjidHomeState>()
        //     .getCartByIdOrder(widget.idOrder);
        // await AppRoute.pushReplacement(context, MartsjidCartPage());
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        flutterWebviewPlugin.hide();
      } else if (url.contains("status_id=3")) {
        // await AppRoute.pushReplacement(context, MartsjidCartPage());
        Navigator.pop(context);
        Navigator.pop(context);
        flutterWebviewPlugin.hide();
      }
    });
  }

  @override
  void dispose() {
    _WasiatPaymentGatewayState();
    // close the webview here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppWebViewPage(
          hasBackButton: true,
          appBarTitle: 'Pembayaran',
          url: _getUrl(widget.billerCode),
        );
  }
}

String _getUrl(String billerCode) {
  String url =
      'https://toyyibpay.com/$billerCode';
  print(url);
  return url;
}
