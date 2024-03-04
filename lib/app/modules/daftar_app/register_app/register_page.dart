import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/components/my_button.dart';
import 'package:go_masjid/app/modules/daftar_app/components/my_textfield.dart';
import 'package:go_masjid/app/modules/daftar_app/components/square_tile.dart';
import 'package:go_masjid/app/modules/daftar_app/services/auth_service.dart';
import 'package:go_masjid/app/modules/daftar_app/login_app/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  // final Function()? onTap;
  const RegisterPage({
    super.key
    // required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final box = GetStorage();


  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // String negeri = box.read('negeri').toString();

  void _loginPage() {
    Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => DaftarMasjidPage()));
        MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //sign user up method
  void signUserUp() async{
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating the user
    try {
      //check if password is confirmed
      if(passwordController.text == confirmPasswordController.text) {
        print("password sama");
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: emailController.text,
        //   password: passwordController.text,
        // );
        String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=registerLogin';

        Map data = {
          "name": "${nameController.text}",
          "password": "${passwordController.text}",
          "email": "${emailController.text}",
          "phone": "${phoneController.text}",
          "negeri": "${box.read('negeri')}",
          "daerah": "${box.read('daerah')}",
          "poskod": "${box.read('poskod')}",
          "kodMasjid": "${box.read('kodMasjid')}",
        };

        var body = json.encode(data);

        await http.post(Uri.parse(stateInfoUrl), headers: {
          'Content-Type': 'application/json'
        }, body: body).then((response) {
          var data = json.decode(response.body);

          print(data['status']);

          if(data['status'] == 1){
            print("pendaftaran berjaya");
            Navigator.pop(context);
            box.erase();
            showResponseMessage(data['status_message']);
          }else{
            print("pendaftaran tidak berjaya");
            Navigator.pop(context);
            showErrorMessage("Internal Server Error");
          }
        });

      } else {
        print("password tak sama");
        // show error message, password do not matched
        Navigator.pop(context);
        showErrorMessage("Password tidak sama sila semak semula");
      }



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
          title: const Text('Sila Semak Semula'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Semak Semula'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //wrong email message popup
  void showResponseMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Status Pendaftaran'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Kembali ke Log In'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
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
                  // box.read('negeri'),
                  // print(box.read('quote'));
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                const Text(
                  'Register Now',
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

                const SizedBox(height: 5),

                //email textfield
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
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

                //confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //confirm password textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //confirm password textfield
                MyTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _loginPage,
                      child: const Text(
                        'Login Now',
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