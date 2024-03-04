import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/login_app/login_page.dart';
import 'package:go_masjid/app/modules/daftar_app/register_app/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget{
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  @override

  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        // onTap: togglePage,
      );
    } else {
      return RegisterPage(
        // onTap: togglePage,
      );
    }
  }
}