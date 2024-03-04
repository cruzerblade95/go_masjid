import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/login_or_register_page.dart';
import 'package:go_masjid/app/modules/home_dashboard/dashboard_page.dart';
// import 'package:go_masjid/app/modules/home/home_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if(snapshot.hasData) {
           return DashboardPage();
          }
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}