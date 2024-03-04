import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoute {
  static Future push<T extends Object>(
      BuildContext context,
      Widget page, {
        bool fadePage = false,
      }) {
    return Navigator.of(context).push(
      fadePage ? FadePageAnimition(page) : CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> pushModal<T extends Object>(BuildContext context, Route<T> modal) {
    return Navigator.of(context).push(modal);
  }

  @optionalTypeArgs
  static Future<T?> pushReplacement<T extends Object, TO extends Object>(
      BuildContext context,
      Widget page, {
        bool fadePage = false,
        TO? result,
      }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      fadePage ? FadePageAnimition(page) : CupertinoPageRoute(builder: (context) => page),
      result: result,
    );
  }

  @optionalTypeArgs
  static Future<T?> pushAndRemoveUntil<T extends Object>(
      BuildContext context,
      Widget page, {
        bool fadePage = false,
      }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      fadePage ? FadePageAnimition(page) : CupertinoPageRoute(builder: (context) => page),
          (route) => false,
    );
  }

  @optionalTypeArgs
  static void pop<T extends Object>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }
}

class FadePageAnimition<T> extends PageRoute<T> {
  FadePageAnimition(this.child);
  @override
  Color get barrierColor => Colors.black;

  @override
  String? get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
