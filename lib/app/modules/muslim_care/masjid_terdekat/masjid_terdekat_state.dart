// import 'package:flutter/material.dart';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:go_masjid/app/data/api/api_exception.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class MasjidTerdekatState extends ChangeNotifier {
//   List<Masjid> _masjidList = [];
//   List<Masjid> get masjidList => _masjidList;
//
//   String _masjidError = '';
//   String get masjidError => _masjidError;
//
//   String _radius = '';
//   String get radius => _radius;
//   set radius(String value) {
//     _radius = value;
//     getMasjidList();
//   }
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   final masjidRepository = MasjidTerdekatRepository();
//
//   getLocation() async {
//     try {
//       final location = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//
//       _prefs.setString('lat', location.latitude.toString());
//       _prefs.setString('long', location.longitude.toString());
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   getMasjidList() async {
//     try {
//       _isLoading = true;
//       _masjidError = '';
//       final response = await masjidRepository.getMasjidList(_radius);
//
//       if (response != null) {
//         _masjidList = response;
//       }
//     } catch (error) {
//       if (error is APIException) {
//         _masjidError = error.errorMessage();
//       }
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
