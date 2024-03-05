import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_pusaka.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_sms/flutter_sms.dart';

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
  final box = GetStorage();

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
              print("Senarai URL Running:");
              print(request.url);
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
                sendEmail(box.read('pusaka_email'));
                _sendSMS();
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

sendEmail(String emailAddress) async {
  final Email email = Email(
    body:
    'Pembelian Berjaya AMANAH i-Pusaka',
    subject: 'Pelanggan yang dihormati,<br/><br/>Terima Kasih Kerana bersama rakyat trustee berhad.<br/><br/>Kami telah menerima pembayaran anda .Sila klik link pautan dibawah untuk mengisi butiran penting bagi membolehkan kami memproses maklumat anda secepat mungkin<br/><br/><a href="https://bit.ly/PendaftaraniPusaka">https://bit.ly/PendaftaraniPusaka</a><br/><br/>Sekiranya anda memerlukan bantuan, sila hubungi Pusat panggilan kami di talian 0194761669',
    recipients: [emailAddress],
    //cc: ['cc@example.com'],
    //bcc: ['bcc@example.com'],
    //attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: true,
  );
}
void _sendSMS() async {
  final box = GetStorage();
  SmsStatus res = await BackgroundSms.sendMessage(phoneNumber: "+6${box.read('pusaka_no_tel')}", message: "Pelanggan yang dihormati, Terima Kasih Kerana bersama rakyat trustee berhad. Kami telah menerima pembayaran anda .Sila klik link pautan dibawah untuk mengisi butiran penting bagi membolehkan kami memproses maklumat anda secepat mungkin https://bit.ly/PendaftaraniPusaka Sekiranya anda memerlukan bantuan, sila hubungi Pusat panggilan kami di talian 0194761669");
}

// void _sendSMS() async {
//   final box = GetStorage();
//   box.read('pusaka_no_tel');
//   String message = "Pelanggan yang dihormati, Terima Kasih Kerana bersama rakyat trustee berhad. Kami telah menerima pembayaran anda .Sila klik link pautan dibawah untuk mengisi butiran penting bagi membolehkan kami memproses maklumat anda secepat mungkin https://bit.ly/PendaftaraniPusaka Sekiranya anda memerlukan bantuan, sila hubungi Pusat panggilan kami di talian 0194761669";
//   List<String> recipents = ["6${box.read('pusaka_no_tel')}"];
//
//   String _result = await sendSMS(message: message, recipients: recipents)
//       .catchError((onError) {
//     print(onError);
//   });
//   print(_result);
// }