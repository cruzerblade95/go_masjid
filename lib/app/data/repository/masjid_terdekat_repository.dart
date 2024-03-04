// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:masjid_pro/app/goMasjidPro/gomasjidpro.dart';
// import 'package:masjid_pro/app/data/models/masjid_terdekat/masjid.dart';
// import 'package:masjid_pro/app/data/repository/base_repository.dart';
// import 'package:masjid_pro/app/utils/app_url.dart';
//
// class MasjidTerdekatRepository extends BaseRepository {
//   Future<List<Masjid>> getMasjidList(String radius) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//
//     final response = await apiHelper.getRequest(
//       hostUrl: BASE_API_URL,
//       path: 'masjid?',
//       queryParameters: {
//         'lokasi': '1',
//         'lat': _prefs.getString('lat'),
//         'long': _prefs.getString('long'),
//         'jarak': radius,
//       },
//     );
//
//     if (response == null) return null;
//
//     List list = response['masjid'];
//     List<Masjid> listMasjid = list.map((e) => Masjid.fromJson(e)).toList();
//
//     return listMasjid;
//   }
//
//   Future<List<MasjidBaru>> getMasjid(String radius) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//
//     final response = await apiHelper.getRequest(
//       hostUrl: BASE_API_URL,
//       path: 'masjid?',
//       queryParameters: {
//         'lokasi': '1',
//         'lat': _prefs.getString('lat'),
//         'long': _prefs.getString('long'),
//         // 'lat': '5.5177999',
//         // 'long': '100.4512028',
//         'jarak': radius,
//       },
//     );
//
//     if (response == null) return null;
//
//     // print('jarak ${_prefs.getString('lat')} ${_prefs.getString('long')}');
//
//     List list = response['masjid'];
//     List<MasjidBaru> listGetMasjid =
//     list.map((e) => MasjidBaru.fromJson(e)).toList();
//
//     return listGetMasjid;
//   }
// }
