// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:masjid_pro/app/masjidpro_penang.dart';
//
// FocusNode _radiusNode;
//
// class MasjidTerdekatPage extends StatelessWidget {
//   const MasjidTerdekatPage({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => MasjidTerdekatState(),
//       child: AppSecondaryBar(
//         title: 'Masjid Terdekat',
//         body: _Body(),
//       ),
//     );
//   }
// }
//
// class _Body extends StatefulWidget {
//   const _Body({Key key}) : super(key: key);
//
//   @override
//   __BodyState createState() => __BodyState();
// }
//
// class __BodyState extends State<_Body> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<MasjidTerdekatState>().getLocation();
//     context.read<MasjidTerdekatState>().getMasjidList();
//     _radiusNode = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     _radiusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // _SearchTextField(),
//         _MasjidTerdekatList(),
//       ],
//     );
//   }
// }
//
// class _SearchTextField extends StatelessWidget {
//   const _SearchTextField({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MasjidTerdekatState>(
//       builder: (_, state, __) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           margin: EdgeInsets.only(bottom: 16.0),
//           child: AppTextFieldWithLabel(
//             maxLength: 3,
//             focusNode: _radiusNode,
//             hint: 'Carian...',
//             keyboardType: TextInputType.numberWithOptions(decimal: true),
//             inputFormatter: [FilteringTextInputFormatter.digitsOnly],
//             onChange: (v) => state.radius = v,
//             onSubmitted: (v) => state.radius = v,
//             suffixIcon: InkWell(
//               onTap: () async {
//                 _radiusNode.unfocus();
//                 await state.getMasjidList();
//               },
//               child: Icon(
//                 Icons.search,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _MasjidTerdekatList extends StatelessWidget {
//   const _MasjidTerdekatList({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MasjidTerdekatState>(
//       builder: (_, state, __) {
//         return state.isLoading
//             ? Expanded(
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         )
//             : state.masjidError.isNullOrWhiteSpace &&
//             state.masjidList.isNotEmpty
//             ? Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             padding: EdgeInsets.all(8.0),
//             itemCount: state.masjidList.length,
//             itemBuilder: (_, index) {
//               var masjid = state.masjidList[index];
//               return _MasjidTerdekat(masjid: masjid);
//             },
//           ),
//         )
//             : Expanded(
//           child: Center(
//             child: Text(state.masjidError ?? ''),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _MasjidTerdekat extends StatelessWidget {
//   final Masjid masjid;
//
//   const _MasjidTerdekat({
//     this.masjid,
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppMasjidTerdekatCard(
//       title: masjid.namaMasjid,
//       subtitle: masjid.alamatMasjid,
//       onGoogleMapsTapped: () => _onGoogleMapsTapped(masjid.lat, masjid.long),
//       onWazeTapped: () => _onWazeTapped(masjid.lat, masjid.long),
//     );
//   }
// }
//
// _onGoogleMapsTapped(String lat, String long) async {
//   var url = 'google.navigation:q=$lat,$long';
//   var fallbackUrl =
//       'https://www.google.com/maps/search/?api=1&query=$lat,$long';
//
//   try {
//     bool launched =
//     await launch(url, forceSafariVC: false, forceWebView: false);
//     if (!launched) {
//       await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//     }
//   } catch (e) {
//     await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//   }
// }
//
// _onWazeTapped(String lat, String long) async {
//   var url = 'waze://?ll=$lat,$long';
//   var fallbackUrl = 'https://waze.com/ul?ll=$lat,$long&navigate=yes';
//   try {
//     bool launched =
//     await launch(url, forceSafariVC: false, forceWebView: false);
//     if (!launched) {
//       await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//     }
//   } catch (e) {
//     await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//   }
// }
