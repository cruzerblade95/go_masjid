import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_menu_widget.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile_update_screen.dart';
import 'package:go_masjid/app/modules/masjid_care/semak_kariah_ketua.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_size.dart';
import '../../utils/styles/app_textstyles.dart';
import '../daftar_kariah/daftar_kariah.dart';


class MasjidCareHome extends StatefulWidget {
  const MasjidCareHome({super.key});

  @override
  State<MasjidCareHome> createState() => _MasjidCareHomeState();
}

class _MasjidCareHomeState extends State<MasjidCareHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Masjid Care')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ProfileMenuWidget(
              //     title: "Pendaftaran Kariah - Ketua Keluarga",
              //     icon: LineAwesomeIcons.cog,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "Semak Pendaftaran Kariah",
              //     icon: LineAwesomeIcons.cog,
              //     onPress: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => SemakKariahKetua()));
              //     }),
              AppMenuCard(
              title: 'Pendaftaran Kariah - Ketua Keluarga',
              subtitle: 'Daftar sebagai ahli kariah di masjid anda sekarang',
              iconImage: 'assets/icons/kariah_masjidpropenang.png',
              backgroundColor: AppColors.primaryColor,
              onTap: () => {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DaftarKariah()))
              },
              ),
              // AppMenuCard(
              //   title: 'Semak Pendaftaran Kariah',
              //   subtitle: 'Semak Permohonan Anda',
              //   iconImage: 'assets/icons/icon_status_permohonan.png',
              //   // backgroundColor: AppColors.primaryColor,
              //   onTap: () => {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => SemakKariahKetua()))
              //   },
              // ),
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
