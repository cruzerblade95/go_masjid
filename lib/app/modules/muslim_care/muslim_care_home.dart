import 'package:flutter/material.dart';
import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_size.dart';
import '../../utils/styles/app_textstyles.dart';

class MuslimCareHome extends StatefulWidget {
  const MuslimCareHome({super.key});

  @override
  State<MuslimCareHome> createState() => _MuslimCareHomeState();
}

class _MuslimCareHomeState extends State<MuslimCareHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Muslim Care')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppMenuCard(
                title: 'Masjid Terdekat',
                subtitle: 'Anda boleh mengetahui lokasi masjid terdekat dan arah masjid yang dituju',
                iconImage: 'assets/icons/go_masjid_new_icon/MASJID-TERDEKAT.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
              AppMenuCard(
                title: 'Waktu Solat',
                subtitle: 'Anda boleh mengetahui waktu solat 5 waktu dan notifikasi masuk waktu solat',
                iconImage: 'assets/icons/go_masjid_new_icon/WAKTU-SOLAT-&-AZAN.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
              AppMenuCard(
                title: 'Qiblat',
                subtitle: 'Menyemak kedudukan arah qiblat',
                iconImage: 'assets/icons/go_masjid_new_icon/QIBLAT.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
              AppMenuCard(
                title: 'Al-Quran',
                subtitle: 'Anda boleh membaca Al-Quran secara menyeluruh',
                iconImage: 'assets/icons/go_masjid_new_icon/QURAN.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
              AppMenuCard(
                title: 'Tasbih',
                subtitle: 'Anda boleh bertasbih dan mengetahui jumlah bacaan zikir',
                iconImage: 'assets/icons/go_masjid_new_icon/TASBIH.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
              AppMenuCard(
                title: 'Doa',
                subtitle: 'Anda boleh melihat senarai doa-doa yang disediakan',
                iconImage: 'assets/icons/go_masjid_new_icon/DOA.png',
                backgroundColor: AppColors.primaryColor,
                onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DaftarKariah())
                  // )
                },
              ),
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