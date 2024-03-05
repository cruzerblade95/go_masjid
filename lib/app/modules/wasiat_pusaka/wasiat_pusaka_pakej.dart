import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_menu_widget.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_update_screen.dart';
import 'package:go_masjid/app/modules/masjid_care/semak_kariah_ketua.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_pusaka_bayar.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_pusaka_pelanggan.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_size.dart';
import '../../utils/styles/app_textstyles.dart';
import '../../utils/styles/button_daftar_kariah_home.dart';
import '../daftar_kariah/daftar_kariah.dart';


class WasiatPusakaPakej extends StatefulWidget {
  const WasiatPusakaPakej({super.key});

  @override
  State<WasiatPusakaPakej> createState() => _WasiatPusakaPakejState();
}

class _WasiatPusakaPakejState extends State<WasiatPusakaPakej> {
  final box = GetStorage();
  int? _myPenyakit;
  int? _myPakejAmanah;
  int? _myPakejTabungAmanah;
  List? pakejs;
  List pakej = [{"name":"AMANAH i-Pusaka","value":1}];
  List pakej1 = [{"name":"AMANAH i-Pusaka","value":1},{"name":"AMANAH i-Pusaka PREMIUM","value":2}];
  List? tabungamanah;
  List tabungamanah1 = [
    {"name":"RM 20,000","value":1},
    {"name":"RM 40,000","value":2},
    {"name":"RM 60,000","value":3}
  ];
  List tabungamanah2 = [
    {"name":"RM 20,000","value":1},
    {"name":"RM 40,000","value":2},
    {"name":"RM 60,000","value":3},
    {"name":"RM 80,000","value":4},
    {"name":"RM 100,000","value":5}
  ];
  List tabungamanahpremium = [
    {"name":"RM 120,000","value":6},
    {"name":"RM 140,000","value":7},
    {"name":"RM 160,000","value":8},
    {"name":"RM 180,000","value":9},
    {"name":"RM 200,000","value":10}
  ];
  late String stringNilaiTabung;
  late int bulanan;
  late int tahunan;
  int boxTrigger = 0;

  void _submit() {

      box.write('pusaka_nilai_tabung', stringNilaiTabung);
      box.write('pusaka_bulanan', bulanan);
      box.write('pusaka_tahunan', tahunan);
      box.write('pusaka_penyakit', _myPenyakit);
      box.write('pusaka_pakej_amanah', _myPakejAmanah);
      box.write('pusaka_tabung_amanah', _myPakejTabungAmanah);

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WasiatPusakaBayar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AMANAH i-Pusaka Pakej')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Pembelian Pakej", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const Divider(),
              Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                  child: const Text("Adakah anda mempunyai penyakit yang sedia ada?", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _myPenyakit,
                        iconSize: 30,
                        icon: (null),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: const Text('Sila buat pilihan anda'),
                        onChanged: (newValue) {
                          setState(() {
                            _myPenyakit = newValue!;
                            _myPakejAmanah = null;
                            _myPakejTabungAmanah = null;
                            boxTrigger = 0;
                            if(_myPenyakit == 1){
                              pakejs = pakej;
                            }else if(_myPenyakit == 2){
                              pakejs = pakej1;
                            }
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Ya"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Tidak"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              (_myPenyakit == 1)?Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                  child: const Text("*Pewasiat yang menghidap PENYAKIT SEDIA ADA dibenarkan untuk melanggan Pakej RM20,000 sehingga RM60,000 sahaja tanpa Pengisytiharan Kesihatan.", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.grey), textAlign: TextAlign.left,),
                ),
              ):Container(),
              (_myPenyakit != null)?Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                  child: const Text("Sila pilih pakej anda", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ):Container(),
              (_myPenyakit != null)?Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _myPakejAmanah,
                        iconSize: 30,
                        icon: (null),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: const Text('Sila buat pilihan pakej anda'),
                        onChanged: (newValue) {
                          setState(() {
                            _myPakejAmanah = newValue!;
                            _myPakejTabungAmanah = null;
                            if(_myPenyakit == 1 && _myPakejAmanah == 1){
                              tabungamanah = tabungamanah1;
                            }else if(_myPenyakit == 2 && _myPakejAmanah == 1){
                              tabungamanah = tabungamanah2;
                            }else if(_myPenyakit == 2 && _myPakejAmanah == 2){
                              tabungamanah = tabungamanahpremium;
                            }
                            boxTrigger = 0;
                          });
                        },
                        items: pakejs?.map((item) {
                          return DropdownMenuItem<int>(
                            value: item['value'],
                            child: Text(item['name']),
                          );
                        }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ):Container(),
              (_myPenyakit != null)?Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                  child: const Text("Sila pilih pakej tabung amanah anda", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ):Container(),
              (_myPenyakit != null)?Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _myPakejTabungAmanah,
                        iconSize: 30,
                        icon: (null),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: const Text('Sila buat pilihan pakej tabung amanah anda'),
                        onChanged: (newValue) {
                          setState(() {
                            _myPakejTabungAmanah = newValue!;
                            if(_myPakejTabungAmanah == 1){
                              stringNilaiTabung = "RM 20,000";
                              bulanan = 30;
                              tahunan = 360;
                            }else if(_myPakejTabungAmanah == 2){
                              stringNilaiTabung = "RM 40,000";
                              bulanan = 40;
                              tahunan = 480;
                            }else if(_myPakejTabungAmanah == 3){
                              stringNilaiTabung = "RM 60,000";
                              bulanan = 50;
                              tahunan = 600;
                            }else if(_myPakejTabungAmanah == 4){
                              stringNilaiTabung = "RM 80,000";
                              bulanan = 60;
                              tahunan = 720;
                            }else if(_myPakejTabungAmanah == 5){
                              stringNilaiTabung = "RM 100,000";
                              bulanan = 70;
                              tahunan = 840;
                            }else if(_myPakejTabungAmanah == 6){
                              stringNilaiTabung = "RM 120,000";
                              bulanan = 100;
                              tahunan = 1200;
                            }else if(_myPakejTabungAmanah == 7){
                              stringNilaiTabung = "RM 140,000";
                              bulanan = 120;
                              tahunan = 1440;
                            }else if(_myPakejTabungAmanah == 8){
                              stringNilaiTabung = "RM 160,000";
                              bulanan = 140;
                              tahunan = 1680;
                            }else if(_myPakejTabungAmanah == 9){
                              stringNilaiTabung = "RM 180,000";
                              bulanan = 160;
                              tahunan = 1920;
                            }else if(_myPakejTabungAmanah == 10){
                              stringNilaiTabung = "RM 200,000";
                              bulanan = 180;
                              tahunan = 2160;
                            }
                            boxTrigger = 1;

                          });
                        },
                        items: tabungamanah?.map((item) {
                          return DropdownMenuItem<int>(
                            value: item['value'],
                            child: Text(item['name']),
                          );
                        }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ):Container(),
              (boxTrigger == 1)?
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
                child: Column(
                  children: [
                    Text("RM ${bulanan}/Bulan @ RM ${tahunan}/Tahun", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const Divider(),
                    Align(alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                        child: Text("- ${stringNilaiTabung} akan dibayar sekiranya orang diwasiatkan meninggal dunia (Sehingga Maksima 80 Tahun).", textAlign: TextAlign.left,),
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(35.0,0,30.0,0),
                        child: Text("*Tiada manfaat jika kematian disebabkan oleh penyakit sedia ada KURANG 1 TAHUN", textAlign: TextAlign.left,style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                        child: Text("- ${stringNilaiTabung} akan dibayar sekiranya orang diwasiatkan hilang upaya kekal & menyeluruh (Sehingga 70 Tahun).", textAlign: TextAlign.left,),
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(35.0,0,30.0,10),
                        child: Text("*Tiada manfaat jika hilang upaya kekal disebabkan penyakit berlaku dalam masa KURANG 6 BULAN", textAlign: TextAlign.left,style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(35.0,10,30.0,10),
                      child: ElevatedButton(
                        style: buttonMuslim,
                        // TODO: implement callback
                        onPressed: _submit,
                        child: Text(
                          'Teruskan Pembayaran',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),

                        ),
                      ),
                    ),
                  ],
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}

class AppMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String iconImage;
  final Color backgroundColor;

  AppMenuCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconImage,
    this.backgroundColor = AppColors.whiteColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                iconImage,
                width: 100.0,
              ),
              SizedBox(width: AppSize.spaceX16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title ?? '',
                        style: textStyles.boldTextStyle.copyWith(
                          fontFamily: 'Muli',
                          fontSize: 18.0,
                          color: AppColors.secondaryColor,
                        ),
                        // textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle ?? '',
                      style: textStyles.defaultTextStyle.copyWith(
                        fontFamily: 'Muli',
                        fontSize: 13.0,
                        color:
                        backgroundColor == AppColors.primaryColor ? Colors.white : Colors.black,
                      ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.yellow : Colors.black;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: Colors.grey)) : null,
    );
  }
}
