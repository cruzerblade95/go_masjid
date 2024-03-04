import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/styles/app_colors.dart';
final _boxwebUi = GetStorage('authStorage');

class AppWebViewPage extends StatelessWidget {
  final String appBarTitle;
  final String url;
  final bool hasBackButton;

  AppWebViewPage({
    required this.appBarTitle,
    required this.url,
    required this.hasBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppSecondaryBar(
      hasBackButton: hasBackButton,
      title: appBarTitle ?? '',
      body: Container(
        child: WebviewScaffold(
          headers: {
            "Authorization":"${_boxwebUi.read("authToken")}"
          },
          url: url ?? '',
          initialChild: AppLoadingOverlay(),
          mediaPlaybackRequiresUserGesture: false,
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          withJavascript: true,
        ),
      ),
    );
  }
}

class AppSecondaryBar extends StatelessWidget {
  final Widget body;
  final String title;
  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  // final Function onPressed;
  // final Widget bottomNavigationBar;
  final bool hasBackButton;
  // final List<Widget> actions;

  AppSecondaryBar({
    required this.body,
    required this.title,
    this.centerTitle = false,
    this.elevation = 4.0,
    this.backgroundColor = AppColors.whiteColor,
    // this.onPressed,
    // required this.bottomNavigationBar,
    this.hasBackButton = true,
    // required this.actions,
    child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          this.title,
          style: TextStyle(color: Colors.white),
        ),
        elevation: this.elevation,
        centerTitle: centerTitle,
        backgroundColor: AppColors.primaryColor,
        leading: hasBackButton
            ? BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        )
            : Container(),
      ),
      body: this.body,
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
