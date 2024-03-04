import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'login_app/login_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box.erase();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginPage()));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    // });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}