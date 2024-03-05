import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/onboardingScreen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await GetStorage.init();
  // check permission is given
  // ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.SEND_SMS},1);

  var status = await Permission.sms.status;
  if (status.isDenied) {
    await Permission.sms.request();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}


