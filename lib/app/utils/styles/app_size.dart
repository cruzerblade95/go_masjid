import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppSize {
  // tabsize
  static double tabHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top + kToolbarHeight;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // space
  static double spaceX6 = 6.0;
  static double spaceX8 = 8.0;
  static double spaceX16 = 16.0;
  static double spaceX24 = 24.0;
  static double spaceX32 = 32.0;
  static double spaceX48 = 48.0;
  static double spaceX68 = 68.0;

  // screen
  static bool keyboardShowing(BuildContext context) =>
      MediaQuery.of(context).viewInsets.vertical > 0;
  static double keyboardHight(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;
  static double heightScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double widthScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double maxWidthScreen(BuildContext context) =>
      widthScreen(context) >= 400
          ? 380
          : widthScreen(context) >= 360
          ? widthScreen(context) - 60
          : 300;

  //positioning
  static MainAxisAlignment mainCenter = MainAxisAlignment.center;
  static MainAxisAlignment mainSpaceBetween = MainAxisAlignment.spaceBetween;
  static MainAxisAlignment mainStart = MainAxisAlignment.start;
  static MainAxisAlignment mainEnd = MainAxisAlignment.end;
  static MainAxisAlignment mainSpaceAround = MainAxisAlignment.spaceAround;
  static MainAxisAlignment mainSpaceEvenly = MainAxisAlignment.spaceEvenly;

  static CrossAxisAlignment crossEnd = CrossAxisAlignment.end;
  static CrossAxisAlignment crossStart = CrossAxisAlignment.start;
  static CrossAxisAlignment crossCenter = CrossAxisAlignment.center;
  static CrossAxisAlignment crossBaseLine = CrossAxisAlignment.baseline;
  static CrossAxisAlignment crossStretch = CrossAxisAlignment.stretch;

  // font size
  static double fontXsSmall = 10.0;
  static double fontSmall = 12.0;
  static double fontMedium = 14.0;
  static double fontLarge = 16.0;
  static double fontLargeX2 = 18.0;
  static double fontLargeX3 = 20.0;
  static double fontLargeX4 = 22.0;
  static double fontLargeX5 = 24.0;
  static double fontLargeX6 = 26.0;
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    required Key key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize!);
  }
}
