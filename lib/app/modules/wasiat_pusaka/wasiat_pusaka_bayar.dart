import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_menu_widget.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_update_screen.dart';
import 'package:go_masjid/app/modules/masjid_care/semak_kariah_ketua.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_payment_gateway.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_webview.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_size.dart';
import '../../utils/styles/app_textstyles.dart';
import '../../utils/styles/button_daftar_kariah_home.dart';
import '../daftar_kariah/daftar_kariah.dart';
import 'package:http/http.dart' as http;

class WasiatPusakaBayar extends StatefulWidget {
  const WasiatPusakaBayar({super.key});

  @override
  State<WasiatPusakaBayar> createState() => _WasiatPusakaBayarState();
}

class _WasiatPusakaBayarState extends State<WasiatPusakaBayar> {
  int? _myPembayaran;
  int? _myTempohPembayaran;
  int? jumlahBayaran;
  final box = GetStorage();
  int? bulanan;

  Future<void> _submit() async {

    box.write('pusaka_jumlah_bayaran', jumlahBayaran);
    // box.write('pusaka_bulanan', bulanan);
    // box.write('pusaka_tahunan', tahunan);
    // box.write('pusaka_penyakit', _myPenyakit);
    // box.write('pusaka_pakej_amanah', _myPakejAmanah);
    // box.write('pusaka_tabung_amanah', _myPakejTabungAmanah);


    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WasiatWebview("https://infaqpay.my/plus/rakyattrustee-ipusaka")));
  }

  Future<void> _submit2() async {
    // List _billerCode = [];

    // box.write('pusaka_nilai_tabung', stringNilaiTabung);
    // box.write('pusaka_bulanan', bulanan);
    // box.write('pusaka_tahunan', tahunan);
    // box.write('pusaka_penyakit', _myPenyakit);
    // box.write('pusaka_pakej_amanah', _myPakejAmanah);
    // box.write('pusaka_tabung_amanah', _myPakejTabungAmanah);
    box.write('pusaka_jumlah_bayaran', jumlahBayaran);

    // double amounDalamSen =
    //     double.parse(box.read('pusaka_jumlah_bayaran').toString()) * 100;
    // await _payment(
    //     // state.listMasjidInfo[0].catApi,
    //   "510xffj4",
    //     // state.listMasjidInfo[0].namaMasjid,
    //   "Rakyat Trustee Berhad",
    //     "Infaq kepada Masjid",
    //     // state.user.namaPenuh,
    //   "${box.read('pusaka_nama')}",
    //     // state.user.email,
    //   "${box.read('pusaka_email')}",
    //     // state.user.noHp,
    //   "${box.read('pusaka_no_tel')}",
    //     amounDalamSen,
    //     // state.listMasjidInfo[0].toyyibKey,
    //   "lkkd8asu-ogca-gzvt-bzds-xh5vwmlc2ia8",
    //     // state.listCart[0].idOrder,
    //   "1"
    // );

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WasiatWebview("https://infaqpay.my/go/rakyattrustee")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AMANAH i-Pusaka Pembayaran')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Pembayaran Pakej", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const Divider(),
              Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,0),
                  child: const Text("Sila pilih cara pembayaran anda", textAlign: TextAlign.left,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _myPembayaran,
                      iconSize: 30,
                      icon: (null),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      hint: const Text('Sila buat pilihan anda'),
                      onChanged: (newValue) {
                        setState(() {
                          _myPembayaran = newValue!;
                          _myTempohPembayaran = null;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("CASH"),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("DEBIT/KREDIT"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,0),
                  child: const Text("Sila pilih tempoh pembayaran anda", textAlign: TextAlign.left,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30.0,8),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _myTempohPembayaran,
                      iconSize: 30,
                      icon: (null),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      hint: const Text('Sila buat pilihan anda'),
                      onChanged: (newValue) {
                        setState(() {
                          _myTempohPembayaran = newValue!;
                          bulanan = box.read('pusaka_bulanan');
                          jumlahBayaran = (bulanan! * _myTempohPembayaran!);
                        });
                      },
                      items: [
                        (_myPembayaran == 1)?
                        DropdownMenuItem(
                          value: 3,
                          child: Text("3 Bulan"),
                        ) : DropdownMenuItem(
                          value: 1,
                          child: Text("1 Bulan"),
                        ),
                        DropdownMenuItem(
                          value: 6,
                          child: Text("6 Bulan"),
                        ),
                        DropdownMenuItem(
                          value: 12,
                          child: Text("12 Bulan"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              (_myPembayaran == 1 && _myTempohPembayaran != null)?
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Column(
                  children: [
                    Text("Jumlah yang perlu dibayar: RM ${jumlahBayaran}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(35.0,10,30.0,10),
                      child: ElevatedButton(
                        style: buttonMuslim,
                        // TODO: implement callback
                        onPressed: _submit,
                        child: Text(
                          'Bayar Sekarang',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ):(_myPembayaran == 2 && _myTempohPembayaran != null)?Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Column(
                  children: [
                    Text("Jumlah yang perlu dibayar: RM ${jumlahBayaran}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(35.0,10,30.0,10),
                      child: ElevatedButton(
                        style: buttonMuslim,
                        // TODO: implement callback
                        onPressed: _submit2,
                        child: Text(
                          'Bayar Sekarang',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ):Container()
            ],
          )
        ),
      ),
    );
  }
}


Future<List> _payment(String catCode,
    String namaMasjid,
String description,
    String namaPewakaf,
String email,
    String noPhone,
double amaounDalamSen,
    String toyyibKey,
String idInfaq,) async {

  List _billerCode = [];

  final response = await postToyyib(
  catCode,
  namaMasjid,
  description,
  namaPewakaf,
  email,
  noPhone,
  amaounDalamSen,
  toyyibKey,
  idInfaq);
  if (response != null) {
  _billerCode = response;
  }
  return _billerCode;
}

postToyyib(String catCode, String namaMasjid, String description, String namaPewakaf, String email, String noPhone, double amaounDalamSen, String toyyibKey, String idInfaq) async {
  // print(
  //     "harga $amaounDalamSen $catCode $namaMasjid $description  $email $noPhone $toyyibKey $namaPenginfaq");
  var uri = Uri.parse("https://toyyibpay.com/index.php/api/createBill");
  var request = http.MultipartRequest('POST', uri)
    ..fields['userSecretKey'] = "$toyyibKey"
    ..fields['categoryCode'] = "$catCode"
    ..fields['billName'] = "$namaMasjid"
    ..fields['billDescription'] = "$description"
    ..fields["billPriceSetting"] = "1"
    ..fields["billPayorInfo"] = "1"
    ..fields["billAmount"] = "$amaounDalamSen"
    ..fields["billReturnUrl"] =
        "https://masjidpro.com/Masjid/SPMD/detail_bantuan.php?mode=1&bayaran=infaq"
    ..fields["billCallbackUrl"] =
        "https://masjidpro.com/Masjid/SPMD/detail_bantuan.php?mode=2&bayaran=infaq"
    ..fields["billExternalReferenceNo"] = "$idInfaq"
    ..fields["billTo"] = "$namaPewakaf"
    ..fields["billEmail"] = "$email"
    ..fields["billPhone"] = "$noPhone"
    ..fields["billSplitPayment"] = "0"
    ..fields["billSplitPaymentArgs"] = ""
    ..fields["billPaymentChannel"] = "0"
    ..fields["billContentEmail"] = "Terima kasih atas bayaran anda!"
    ..fields["billChargeToCustomer"] = "1";
  var response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await http.Response.fromStream(response);
    // List list = respStr.body as List ;
    print(respStr.body);
    // print(list);
    return jsonDecode(respStr.body);
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
