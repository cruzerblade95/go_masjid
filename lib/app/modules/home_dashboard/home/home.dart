import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_kariah/daftar_kariah.dart';
import 'package:go_masjid/app/modules/home_dashboard/notification/notification.dart';
import 'package:go_masjid/app/modules/home_dashboard/profile/profile.dart';
import 'package:go_masjid/app/modules/muslim_care/muslim_care_home.dart';
import 'package:go_masjid/app/modules/share_app_widget/widget.dart';
import 'package:go_masjid/app/utils/app_route.dart';
import 'package:go_masjid/app/utils/styles/app_colors.dart';
import 'package:go_masjid/app/utils/styles/button_daftar_kariah_home.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../masjid_care/masjid_care_home.dart';
import '../../wasiat_pusaka/wasiat_pusaka.dart';
import '../go_feed/go_feed.dart';
import '../media_news/media_news.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatelessWidget {
  _Content({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
          children: [
            const SizedBox(height: 10),
            SalamUser(box),
            WaktuSolat(),
            const _FastApps(),
            const InfoFeed(),
            MediaNews(),
            // InfoFeed()
          ],
      );
  }
}

class SalamUser extends StatelessWidget {

  SalamUser(this.box, {Key? key}) : super(key: key);

  var box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Assalamualaikum",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  box.read('user_nama'),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/icons/gomasjid_logo.png',
                  height: 30,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationPage()));
                  },
                  icon: const Icon(Icons.notifications_outlined),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaktuSolat extends StatefulWidget {
  WaktuSolat({Key? key}) : super(key: key);

  @override
  State<WaktuSolat> createState() => _WaktuSolatState();
}

class _WaktuSolatState extends State<WaktuSolat> {

  String? _currentAddress;
  Position? _currentPosition;

  var now = DateTime.now();
  var formatterDate = DateFormat('dd MMMM yyyy');
  var formatterTime = DateFormat('kk:mm');
  var dateString;
  var timeString;
  var openHr;
  var openMin;
  var openAmPm;
  var waktuSolat;
  DateFormat dateFormat = DateFormat("jm");

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // print(place);
      setState(() {
        _currentAddress =
        '${place.locality}, ${place.administrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Stream _getClockUpdate() async*{

    _getCurrentPosition();

    yield* Stream.periodic(const Duration(seconds: 1), (_) {

      String stringss = dateFormat.format(DateTime.now());
      openHr = stringss.substring(0, 2);
      openMin = stringss.substring(3, 5);
      openAmPm = stringss.substring(6);

      var subuh = DateTime(now.year, now.month, now.day, 6,23); // 10 PM today
      var zohor = DateTime(now.year, now.month, now.day, 13,31);
      var asar = DateTime(now.year, now.month, now.day, 16,48);
      var maghrib = DateTime(now.year, now.month, now.day, 19,32);
      var isyak = DateTime(now.year, now.month, now.day, 20,41);
      var lepasTime = DateTime(now.year, now.month, now.day, 00,00);

      setState(() {
        now = DateTime.now();
        dateString = formatterDate.format(now);
        timeString = stringss;
        openHr = openHr;
        openMin = openMin;
        openAmPm = openAmPm;

        if(now.isAfter(subuh) && now.isBefore(zohor)){
          waktuSolat = "Subuh";
        }else if(now.isAfter(zohor) && now.isBefore(asar)){
          waktuSolat = "Zohor";
        }else if(now.isAfter(asar) && now.isBefore(maghrib)){
          waktuSolat = "Asar";
        }else if(now.isAfter(maghrib) && now.isBefore(isyak)){
          waktuSolat = "Maghrib";
        }else if(now.isAfter(isyak) && now.isBefore(lepasTime)){
          waktuSolat = "Isyak";
        }else if(now.isAfter(lepasTime) && now.isBefore(subuh)){
          waktuSolat = "Isyak";
        }

      });
      // print(openAmPm);

    }).asyncMap((event) async => await event);

  }


  @override
    Widget build(BuildContext context) {
      return StreamBuilder(
        stream: _getClockUpdate(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    'assets/icons/sun.png',
                  ),
                ),
                Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(dateString ?? ""),
                          ],
                        ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text("WAKTU SOLAT",
                                style: TextStyle(
                                  fontFamily: 'Muli',
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text("$waktuSolat",
                                style: const TextStyle(
                                  fontFamily: 'Muli',
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // margin: const EdgeInsets.all(.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                            child: Text(timeString,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Muli',
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$_currentAddress"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      );
    }
  }

// class _muslimApps extends StatelessWidget {
//   const _muslimApps({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 400,
//       padding: const EdgeInsets.all(5),
//       child: Column(
//         children: [
//           ElevatedButton(
//             style: buttonMuslim,
//             onPressed: (){
//               AppRoute.push(context, const DaftarKariah());
//             },
//             child: const Text('PENDAFTARAN KARIAH',),
//           )
//         ],
//       ),
//     );
//   }
// }

class _FastApps extends StatelessWidget {
  const _FastApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FastAppIcons(
                  label: 'MasjidCare',
                  image: 'assets/icons/go_masjid_new_icon/MASJIDCARE.png',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MasjidCareHome()));
                  },
                ),
                FastAppIcons(
                  label: 'MuslimCare (Coming Soon)',
                  image: 'assets/icons/go_masjid_new_icon/MUSLIMCARE.png',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MuslimCareHome()));
                  },
                ),
                FastAppIcons(
                  label: 'InfaqCare (Coming Soon)',
                  image: 'assets/icons/go_masjid_new_icon/INFAQ-DAN-WAKAF.png',
                  onPressed: () {},
                ),
                FastAppIcons(
                  label: 'Wasiat & Pusaka',
                  image: 'assets/icons/go_masjid_new_icon/WASIAT-&-PUSAKA.png',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WasiatPusakaHome()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoFeed  extends StatefulWidget {
  const InfoFeed({Key? key}) : super(key: key);

  @override
  State<InfoFeed> createState() => _InfoFeedState();
}

class _InfoFeedState extends State<InfoFeed> {

  final box = GetStorage();

  List? infoFeedList;
  late List? imageList;
  late String lols;
  int load1 = 0;

  @override
  void initState(){
    _getInfoFeedList();
    super.initState();
  }

  Stream _getInfoFeedList() async*{

    String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getInfoFeedHome&kod_masjid=${box.read('user_kod_masjid')}';

    yield* Stream.periodic(const Duration(seconds: 10), (_) {
      return http.get(Uri.parse(stateInfoUrl), headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }).then((response) {
        var data = json.decode(response.body);

        setState(() {
          infoFeedList = data['infofeed'];
          imageList = infoFeedList?.map((item) => {"id": "${item['id']}", "image_path": "${item['gambar_utama']}"},).cast<dynamic>().toList() ?? [];
          load1 = 1;
        });
      });
    }).asyncMap((event) async => await event);
  }



  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(
                title: "Info & Feed",
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoFeed()));
                },
                child: const Text(
                  "See All",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),

          InkWell(
            onTap: () {
              print(currentIndex);
            },
            child: StreamBuilder(
              stream: _getInfoFeedList(),
              builder: (context, snapshot) {
                  // print(snapshot);
                  if(load1 == 1){
                    return CarouselSlider(
                      items: imageList
                          ?.map(
                            (item) => Image.memory(
                          base64Decode(item['image_path']),
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          height: 435,
                          width: double.infinity,
                        ),
                      )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        // scrollDirection: BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    );
                    }else{
                      return CircularProgressIndicator();
                    }
              },
            )

            ,
          ),
        ],
      ),
    );
  }
}

class MediaNews  extends StatefulWidget {
  MediaNews({Key? key}) : super(key: key);

  @override
  State<MediaNews> createState() => _MediaNewsState();
}

class _MediaNewsState extends State<MediaNews> {

  final box = GetStorage();

  List? mediaNewsList;
  late List? newsList;
  late String lolss;
  int load11 = 0;

  @override
  void initState(){
    _getInfoFeedList();
    super.initState();
  }

  Stream _getInfoFeedList() async*{

    String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getMediaNewsHome';

    yield* Stream.periodic(const Duration(seconds: 10), (_) {
      return http.get(Uri.parse(stateInfoUrl), headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }).then((response) {
        var data = json.decode(response.body);

        setState(() {
          mediaNewsList = data['infofeed'];
          newsList = mediaNewsList?.map((item) => {"id": "${item['id']}", "image_path": "${item['gambar_utama']}"},).cast<dynamic>().toList() ?? [];
          load11 = 1;
        });
      });
    }).asyncMap((event) async => await event);
  }

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(
                title: "Media & News",
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MediaNewsPage()));
                },
                child: const Text(
                  "See All",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),

          InkWell(
            onTap: () {
              print(currentIndex);
            },
            child: StreamBuilder(
              stream: _getInfoFeedList(),
              builder: (context, snapshot) {
                // print(snapshot);
                if(load11 == 1){
                  return CarouselSlider(
                    items: newsList
                        ?.map(
                          (item) => Image.memory(
                        base64Decode(item['image_path']),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        height: 435,
                        width: double.infinity,
                      ),
                    )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      // scrollDirection: BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              },
            )

            ,
          ),
        ],
      ),
    );
  }
}
