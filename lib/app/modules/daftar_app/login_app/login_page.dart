import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/components/my_button.dart';
import 'package:go_masjid/app/modules/daftar_app/components/my_textfield.dart';
import 'package:go_masjid/app/modules/daftar_app/components/square_tile.dart';
import 'package:go_masjid/app/modules/daftar_app/services/auth_service.dart';
import 'package:go_masjid/app/modules/home_dashboard/dashboard_page.dart';
import 'package:go_masjid/app/modules/daftar_masjid/pilih_masjid.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  const LoginPage({
    super.key
    // required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final box = GetStorage();

  List? userList;

  @override
  void initState() {
    super.initState();
    if(box.read('user_id') != null){
      _homepage();
    }

  }

  void _homepage() {
    // Navigator.push(
    //     context,
    //     // MaterialPageRoute(builder: (context) => DaftarMasjidPage()));
    //     MaterialPageRoute(builder: (context) => const DashboardPage()));
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardPage()),
                (route) => false);
      });
    });
  }

  void _masjidSelectPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DaftarMasjidPage()));
        // MaterialPageRoute(builder: (context) => DashboardPage()));
  }

  //sign user in method
  void signUserIn() async{
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );

    //try sign in
    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text,
      // );
      String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=loginUser';

      Map data = {
        "email": "${emailController.text}",
        "password": "${passwordController.text}",
      };

      var body = json.encode(data);

      await http.post(Uri.parse(stateInfoUrl), headers: {
        'Content-Type': 'application/json'
      }, body: body).then((response) {
        var data = json.decode(response.body);

        print(data['status']);
        print(data['message']);

        if(data['status'] == 1){
          print("login berjaya");
          Navigator.pop(context);
          setState(() {
            userList = data['user'];
          });

          userList?.map((item) {

            box.write('user_id', item['id']);
            box.write('user_nama', item['nama']);
            box.write('user_email', item['email']);
            box.write('user_negeri_id', item['negeri_id']);
            box.write('user_daerah_id', item['daerah_id']);
            box.write('user_poskod', item['poskod']);
            box.write('user_kod_masjid', item['kod_masjid']);
            box.write('user_date_added', item['date_added']);
            box.write('user_date_updated', item['date_updated']);
            // return new DropdownMenuItem(
            //   child: new Text(item['name']),
            //   value: item['id_negeri'].toString(),
            // );
          }).toList();

          _homepage();

          // showResponseMessage(data['status_message']);
        }else if(data['status'] == 2){
          print("login tidak berjaya");
          Navigator.pop(context);
          box.erase();
          showResponseMessage(data['message'], data['status']);
        }else{
          print("Belum Mendaftar");
          Navigator.pop(context);
          showResponseMessage(data['message'], data['status']);
        }
      });

      //pop loading circle
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);

      //show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
    );
  }

  void showResponseMessage(String message, int statusCode) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ralat'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: (statusCode == 2) ? Text('Sila cuba lagi') : Text('Daftar Sekarang'),
              onPressed: () {
                (statusCode == 2) ? Navigator.of(context).pop():_masjidSelectPage();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),

                //logo gomasjid
                const Image(
                  width: 200,
                  image: AssetImage("assets/icons/gomasjid_logo.png"),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Bismillah..',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 46,
                  ),
                ),

                Text(
                  'Please fill your information',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //forgot password
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  text: "Sign In",
                  // onTap: signUserIn,
                  onTap: signUserIn,
                ),

                const SizedBox(height: 30),

                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: () => AuthService(),
                        imagePath: 'assets/images/google.png'
                    ),

                    SizedBox(width: 25),

                    SquareTile(
                        onTap: () => AuthService(),
                        imagePath: 'assets/images/apple.png'
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _masjidSelectPage,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}