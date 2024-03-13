//
// import 'package:flutter/material.dart';
// import 'package:go_masjid/app/modules/pandangan_cadangan/pandangan_cadangan_state.dart';
// import 'package:go_masjid/app/utils/constants/constants.dart';
// import 'package:go_masjid/app/utils/styles/app_colors.dart';
// import 'package:go_masjid/app/utils/styles/app_radio_button.dart';
// import 'package:go_masjid/app/utils/styles/app_select_field.dart';
// import 'package:go_masjid/app/utils/styles/app_size.dart';
// import 'package:go_masjid/app/utils/styles/app_submit_button.dart';
// import 'package:go_masjid/app/utils/styles/app_text_field_with_label.dart';
// import 'package:provider/provider.dart';
//
//
// FocusNode? _aduanCadanganNode;
//
// class PandanganCadangan extends StatelessWidget {
//   const PandanganCadangan({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => PandanganCadanganState(),
//       child: AppSecondaryBar(
//         title: 'Pandangan dan Cadangan',
//         body: _Body(),
//       ),
//     );
//   }
// }
//
// class _Body extends StatefulWidget {
//   const _Body({Key? key}) : super(key: key);
//
//   @override
//   __BodyState createState() => __BodyState();
// }
//
// class __BodyState extends State<_Body> {
//   @override
//   void initState() {
//     super.initState();
//     _aduanCadanganNode = FocusNode();
//     context.read<PandanganCadanganState>().getAll();
//   }
//
//   @override
//   void dispose() {
//     _aduanCadanganNode!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return state.isLoading
//             ? AppLoadingOverlay()
//             : SingleChildScrollView(
//           padding: EdgeInsets.all(AppSize.spaceX16),
//           child: Column(
//             children: [
//               _NamaMasjidField(),
//               SizedBox(height: AppSize.spaceX16),
//               _PilihAduanAtauCadangan(),
//               SizedBox(height: AppSize.spaceX16),
//               _PilihJenisAduanCadanganField(),
//               SizedBox(height: AppSize.spaceX16),
//               _AduanCadanganField(),
//               SizedBox(height: AppSize.spaceX16),
//               _SubmitButton(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _NamaMasjidField extends StatelessWidget {
//   const _NamaMasjidField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return AppSelectField(
//           label: 'Masjid',
//           hint: 'Sila pilih masjid...',
//           items: _mapItems(state),
//           onChange: (v) => state.masjid = v,
//           errorText: state.masjidError,
//         );
//       },
//     );
//   }
//
//   _mapItems(state) {
//     List list = state.masjidList;
//     return list
//         .map((item) => appDropDownMenuItem(item.namaMasjid, item))
//         .toList();
//   }
// }
//
// class _PilihAduanAtauCadangan extends StatelessWidget {
//   const _PilihAduanAtauCadangan({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return AppRadioButtonListTile(
//           label: 'Pandangan atau Cadangan ?',
//           onChange: (v) => state.pilihAduanCadangan = v,
//           radioList: [
//             RadioListItem1('1', 'Pandangan'),
//             RadioListItem1('2', 'Cadangan'),
//           ],
//           groupValue: state.pilihAduanCadangan,
//           errorText: state.pilihAduanCadanganHasError
//               ? state.pilihAduanCadanganError
//               : null,
//         );
//       },
//     );
//   }
// }
//
// class _PilihJenisAduanCadanganField extends StatelessWidget {
//   const _PilihJenisAduanCadanganField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return AppSelectField(
//           focusNode: _aduanCadanganNode,
//           label: 'Jenis Pandangan/Cadangan',
//           hint: 'Sila pilih jenis pandangan/cadangan...',
//           items: _mapItems(),
//           errorText: state.jenisAduanCadanganHasError
//               ? state.jenisAduanCadanganError
//               : null,
//           onChange: (v) => state.jenisAduanCadangan = v,
//           onSubmitted: (v) => state.jenisAduanCadangan = v,
//         );
//       },
//     );
//   }
//
//   _mapItems() {
//     return aduanCadangan.map((e) => appDropDownMenuItem(e, e)).toList();
//   }
// }
//
// class _AduanCadanganField extends StatelessWidget {
//   const _AduanCadanganField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return AppTextFieldWithLabel(
//           focusNode: _aduanCadanganNode,
//           label: 'Pandangan/Cadangan',
//           keyboardType: TextInputType.multiline,
//           maxLine: null,
//           minLine: 5,
//           errorText:
//           state.aduanCadanganHasError ? state.aduanCadanganError : null,
//           onChange: (v) => state.aduanCadangan = v,
//           onSubmitted: (v) => state.aduanCadangan = v,
//         );
//       },
//     );
//   }
// }
//
// class _SubmitButton extends StatelessWidget {
//   const _SubmitButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PandanganCadanganState>(
//       builder: (_, state, __) {
//         return AppSubmitButton(
//           btnTitle: 'Hantar',
//           onTap: () => _onSubmitted(context),
//         );
//       },
//     );
//   }
//
//   _onSubmitted(BuildContext context) async {
//     FocusScope.of(context).unfocus();
//
//     final state = context.read<PandanganCadanganState>();
//
//     state.validateAll();
//
//     if (state.jenisAduanCadanganHasError) {
//       return;
//     }
//     if (state.pilihAduanCadanganHasError) {
//       return;
//     }
//     if (state.aduanCadanganHasError) {
//       _aduanCadanganNode!.requestFocus();
//       return;
//     }
//
//     await state.postAduanCadangan(context);
//   }
// }
//
// class AppSecondaryBar extends StatelessWidget {
//   final Widget body;
//   final String title;
//   final bool centerTitle;
//   final double elevation;
//   final Color backgroundColor;
//   // final Function onPressed;
//   // final Widget bottomNavigationBar;
//   final bool hasBackButton;
//   // final List<Widget> actions;
//
//   AppSecondaryBar({
//     required this.body,
//     required this.title,
//     this.centerTitle = false,
//     this.elevation = 4.0,
//     this.backgroundColor = AppColors.whiteColor,
//     // this.onPressed,
//     // required this.bottomNavigationBar,
//     this.hasBackButton = true,
//     // required this.actions,
//     child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           this.title,
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: this.elevation,
//         centerTitle: centerTitle,
//         backgroundColor: AppColors.primaryColor,
//         leading: hasBackButton
//             ? BackButton(
//           onPressed: () => Navigator.pop(context),
//           color: Colors.white,
//         )
//             : Container(),
//       ),
//       body: this.body,
//     );
//   }
// }
//
// class AppLoadingOverlay extends StatelessWidget {
//   const AppLoadingOverlay({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
