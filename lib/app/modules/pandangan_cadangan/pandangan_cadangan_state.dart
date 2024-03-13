// import 'package:flutter/material.dart';
// import 'package:go_masjid/app/utils/extensions/string_extensions.dart';
//
// class PandanganCadanganState extends ChangeNotifier {
//
//   User2 _user;
//   User2 get user => _user;
//
//   String _idMasjidSaya;
//   String get idMasjidSaya => _idMasjidSaya;
//   set idMasjidSaya(String value) {
//     _idMasjidSaya = value;
//   }
//
//   String _jenisAduanCadangan;
//   String get jenisAduanCadangan => _jenisAduanCadangan;
//   set jenisAduanCadangan(String value) {
//     _jenisAduanCadangan = value;
//     validateJenisAduanCadangan();
//   }
//
//   String _pilihAduanCadangan;
//   String get pilihAduanCadangan => _pilihAduanCadangan;
//   set pilihAduanCadangan(String value) {
//     _pilihAduanCadangan = value;
//     validatePilihAduanCadangan();
//   }
//
//   String _aduanCadangan;
//   String get aduanCadangan => _aduanCadangan;
//   set aduanCadangan(String value) {
//     _aduanCadangan = value;
//     validateAduanCadangan();
//   }
//
//   List<MasjidAktif> _masjidList;
//   List<MasjidAktif> get masjidList => _masjidList;
//
//   MasjidAktif _masjid;
//   MasjidAktif get masjid => _masjid;
//   set masjid(MasjidAktif value) {
//     _masjid = value;
//     validateMasjid();
//   }
//
//   String _message = '';
//   String get message => _message;
//
//   String _masjidError;
//   String get masjidError => _masjidError;
//   bool get masjidHasError => !_masjidError.isNullOrWhiteSpace;
//
//   String _pilihAduanCadanganError = '';
//   String get pilihAduanCadanganError => _pilihAduanCadanganError;
//   bool get pilihAduanCadanganHasError =>
//       !pilihAduanCadanganError.isNullOrWhiteSpace;
//
//   String _jenisAduanCadanganError = '';
//   String get jenisAduanCadanganError => _jenisAduanCadanganError;
//   bool get jenisAduanCadanganHasError =>
//       !jenisAduanCadanganError.isNullOrWhiteSpace;
//
//   String _aduanCadanganError = '';
//   String get aduanCadanganError => _aduanCadanganError;
//   bool get aduanCadanganHasError => !aduanCadanganError.isNullOrWhiteSpace;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   final aduanCadanganRepo = AduanCadanganRepository();
//
//   validateMasjid() {
//     try {
//       _masjidError = null;
//       if (masjid == null) {
//         _masjidError = 'Sila pilih masjid';
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   validatePilihAduanCadangan() {
//     try {
//       _pilihAduanCadanganError = null;
//       if (pilihAduanCadangan.isNullOrWhiteSpace) {
//         _pilihAduanCadanganError = 'Sila pilih aduan atau cadangan';
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   validateJenisAduanCadangan() {
//     try {
//       _jenisAduanCadanganError = null;
//       if (jenisAduanCadangan.isNullOrWhiteSpace) {
//         _jenisAduanCadanganError = 'Sila pilih jenis aduan atau cadangan';
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   validateAduanCadangan() {
//     try {
//       _aduanCadanganError = null;
//       if (aduanCadangan.isNullOrWhiteSpace) {
//         _aduanCadanganError = 'Aduan/cadangan tidak boleh ditinggalkan kosong';
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   validateAll() {
//     validateMasjid();
//     validatePilihAduanCadangan();
//     validateJenisAduanCadangan();
//     validateAduanCadangan();
//   }
//
//   getAll() async{
//     await getIdMasjid();
//     getMosques();
//   }
//   final _profileRepo = EditProfileRepository();
//
//   getIdMasjid() async {
//     try {
//       _isLoading = true;
//       final response = await _profileRepo.getUserProfile();
//       if (response != null) {
//         _user = response;
//         _idMasjidSaya = user.idMasjid;
//         // getJumlahKutipan(user.idMasjid);
//       } else {
//         _idMasjidSaya = "";
//       }
//     } finally {
//       // print(user.idMasjid);
//       print("try $idMasjidSaya");
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   getMosques() async {
//     try {
//       print("get mosque: $idMasjidSaya ");
//       _isLoading = true;
//       final response = await aduanCadanganRepo.getMosques(idMasjidSaya);
//
//       if (response != null) {
//         _masjidList = response;
//       }
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   postAduanCadangan(BuildContext context) async {
//     try {
//       final response = await aduanCadanganRepo.postAduanCadangan(
//         idMasjid: masjid.idMasjid,
//         aduan: aduanCadangan,
//         cadangan: aduanCadangan,
//         jenisAduan: jenisAduanCadangan,
//       );
//
//       if (response != null) {
//         _message = response['msg'];
//         AppModal.showInformation(
//           context,
//           'Berjaya',
//           _message,
//           onTap: () => AppRoute.pushReplacement(context, MorePage()),
//         );
//       }
//     } catch (error) {
//       if (error is APIException) {
//         _message = error.errorMessage();
//         AppModal.showInformation(
//           context,
//           'Tidak Berjaya',
//           _message,
//           onTap: () => AppRoute.pushReplacement(context, MorePage()),
//         );
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
// }
