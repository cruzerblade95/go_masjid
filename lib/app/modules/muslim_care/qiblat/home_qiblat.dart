import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/controller/location_controller.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/view/loading_view.dart';
import 'package:provider/provider.dart';

class HomeQiblat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));

    return ChangeNotifierProvider(
      create: (_) => LocationController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingView(),
      ),
    );
  }
}