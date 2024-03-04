import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_menu_widget.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_update_screen.dart';
import 'package:go_masjid/app/modules/masjid_care/semak_kariah_ketua.dart';
import 'package:go_masjid/app/modules/wasiat_pusaka/wasiat_pusaka_pakej.dart';
import 'package:go_masjid/app/utils/styles/button_daftar_kariah_home.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_size.dart';
import '../../utils/styles/app_textstyles.dart';
import '../daftar_app/components/my_textfield.dart';
import '../daftar_kariah/daftar_kariah.dart';


class WasiatPusakaPelanggan extends StatefulWidget {
  const WasiatPusakaPelanggan({super.key});

  @override
  State<WasiatPusakaPelanggan> createState() => _WasiatPusakaPelangganState();
}

class _WasiatPusakaPelangganState extends State<WasiatPusakaPelanggan> {

  final box = GetStorage();
  late TextEditingController namaPenuhController;
  late TextEditingController noIcController;
  late TextEditingController noPhoneController;
  late TextEditingController emailController;
  String? _myJantina;
  var _textNama = '';
  var _textNoIc = '';
  var _textNoTel = '';
  var _textEmail = '';

  String? get _errorTextNama {
    // at any time, we can get the text from _controller.value.text
    final text = namaPenuhController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // if (text.length < 4) {
    //   return 'Too short';
    // }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextNoIc {
    // at any time, we can get the text from _controller.value.text
    final text = noIcController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // if (text.isAlphabetOnly) {
    //   return 'Nombor Kad Pengenalan haruslah dalam bentuk digit';
    // }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextNoTel {
    // at any time, we can get the text from _controller.value.text
    final text = noPhoneController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // if (text.isAlphabetOnly) {
    //   return 'Nombor Kad Pengenalan haruslah dalam bentuk digit';
    // }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextEmail {
    // at any time, we can get the text from _controller.value.text
    final text = emailController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (!text.isEmail) {
      return 'Format email salah';
    }
    // return null if the text is valid
    return null;
  }

  void _submit() {
    // if there is no error text
    if (_errorTextNama == null
    && _errorTextNoIc == null
    && _errorTextNoTel == null
    && _errorTextEmail == null) {

      box.write('pusaka_nama', namaPenuhController.text);
      box.write('pusaka_no_ic', noIcController.text);
      box.write('pusaka_jantina', _myJantina);
      box.write('pusaka_no_tel', noPhoneController.text);
      box.write('pusaka_email', emailController.text);

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WasiatPusakaPakej()));
      // notify the parent widget via the onSubmit callback
      // widget.onSubmit(_controller.value.text);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    namaPenuhController = TextEditingController(text: '${box.read('user_nama')}');
    noIcController = TextEditingController();
    noPhoneController = TextEditingController();
    emailController = TextEditingController(text: '${box.read('user_email')}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasiat & Pusaka')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Maklumat Pelanggan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const Divider(),
              // Align(alignment: Alignment.centerLeft,
              // child: Container(
              //   padding: const EdgeInsets.all(8.0),
              //   child: const Text("Nama Penuh", textAlign: TextAlign.left,),
              //   ),
              // ),
              // MyTextField(
              //   controller: namaPenuhController,
              //   hintText: 'Nama Penuh',
              //   obscureText: false,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                child: TextField(
                  controller: namaPenuhController,
                  decoration: InputDecoration(
                    labelText: 'Nama Penuh',
                    // TODO: add errorHint
                    errorText: _errorTextNama,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) => setState(() => _textNama),
                ),
              ),
              // Align(alignment: Alignment.centerLeft,
              //   child: Container(
              //     padding: const EdgeInsets.all(8.0),
              //     child: const Text("No Kad Pengenalan", textAlign: TextAlign.left,),
              //   ),
              // ),
              // MyTextField(
              //   controller: noIcController,
              //   hintText: 'No Kad Pengenalan',
              //   obscureText: false,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                child: TextField(
                  controller: noIcController,
                  decoration: InputDecoration(
                    labelText: 'No Kad Pengenalan',
                    // TODO: add errorHint
                    errorText: _errorTextNoIc,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) => setState(() => _textNoIc),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Align(alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0,8,30.0,0),
                  child: const Text("Jantina", textAlign: TextAlign.left,),
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
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        isExpanded: true,
                        value: _myJantina,
                        iconSize: 30,
                        icon: (null),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: const Text('Pilih Jantina'),
                        onChanged: (newValue) {
                          setState(() {
                            _myJantina = newValue!;
                            // _myDaerah = null;
                            // _myZip = null;
                            // _myMasjid = null;
                            // _getDaerahList(_myNegeri);
                            // print(_myNegeri);
                          });
                        },
                        items: const [
                              DropdownMenuItem(
                                value: "lelaki",
                                child: Text("Lelaki"),
                              ),
                              DropdownMenuItem(
                                value: "perempuan",
                                child: Text("Perempuan"),
                              ),
                            ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                child: TextField(
                  controller: noPhoneController,
                  decoration: InputDecoration(
                    labelText: 'No Telefon',
                    // TODO: add errorHint
                    errorText: _errorTextNoTel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) => setState(() => _textNoTel),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,8,30.0,8),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    // TODO: add errorHint
                    errorText: _errorTextEmail,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) => setState(() => _textEmail),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,25,30.0,8),
                child: ElevatedButton(
                  style: buttonMuslim,
                  // TODO: implement callback
                  onPressed: namaPenuhController.value.text.isNotEmpty
                      ? _submit
                      : null,
                  child: Text(
                    'Seterusnya',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              )
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
