import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/model/constants.dart';
import 'package:location/location.dart';
import 'dart:math' as math;
import 'dart:async';

class LocationController extends ChangeNotifier {
  late double lat;
  late double lon;
  late double angle;
  late double heading;
  late Location locationController;
  late Timer timer;
  late Color isExact = kTransparent;
  late ValueNotifier<bool> errExists = ValueNotifier(false);
  bool isLocationEnabled = false;
  bool isPermissionGranted = false;
  bool permissionRequested = false;
  late StreamSubscription<double> headingStream;

  LocationController() {
    locationController = Location();
  }

  Future<void> setUpQibla() async {
    await checkStatus();
    startListening();
  }

  void startListening() async {
    if (!errExists.value) {
      timer = Timer.periodic(const Duration(minutes: 4), (timer) {
        checkStatus();
      });
      // headingStream = FlutterCompass.events.listen((newHeading) {
      //   heading = (newHeading) * (math.pi / 180.0);
      //   if (heading != null) {
      //     getAngle();
      //   }
      // });
    }
    notifyListeners();
  }

  void stopListening() {
    if (timer != null && timer.isActive) timer.cancel();
    if (headingStream != null) headingStream.cancel();
  }

  Future<void> checkStatus() async {
    if (locationController == null) {
      locationController = Location();
    }
    await checkPermission();
    if (errExists.value) {
      stopListening();
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (timer) {
          checkPermission();
          if (!errExists.value) {
            timer.cancel();
            getLocation();
            startListening();
          }
          notifyListeners();
        },
      );
    }
  }

  Future<void> checkPermission() async {
    var tempStatus = await locationController.hasPermission();
    if (!permissionRequested && tempStatus != PermissionStatus.granted && tempStatus != PermissionStatus.deniedForever) {
      await locationController.requestPermission();
      permissionRequested = true;
    }
    if (tempStatus == PermissionStatus.granted) {
      errExists.value = false;
      isLocationEnabled = true;
      isPermissionGranted = true;
      if (!await locationController.serviceEnabled()) {
        errExists.value = true;
        isLocationEnabled = false;
      } else {
        isLocationEnabled = true;
      }
    } else {
      errExists.value = true;
      isPermissionGranted = false;
    }
    notifyListeners();
  }

  Future<void> getLocation() async {
    var location = await locationController.getLocation();
    lat = location.latitude! * math.pi / 180.0;
    lon = location.longitude! * math.pi / 180.0;
    getAngle();
    notifyListeners();
  }

  Future<void> getAngle() async {
    if (lat != null && lon != null) {
      double x = math.cos(kKabbahLat) * math.sin(kKabbahLon - lon);
      double y = math.cos(lat) * math.sin(kKabbahLat) - math.sin(lat) * math.cos(kKabbahLat) * math.cos(kKabbahLon - lon);
      double diffAngle = math.atan2(x, y);
      angle = diffAngle - heading;
      isExact = ((angle < 0.01 && angle > -0.01) ? null : kTransparent)!;
      notifyListeners();
    } else {
      await getLocation();
    }
  }
}
