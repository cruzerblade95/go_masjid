import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/home_dashboard/scan_now/scan_now.dart';
import 'package:go_masjid/app/utils/styles/app_colors.dart';
import 'go_feed/go_feed.dart';
import 'home/home.dart';
import 'media_news/media_news.dart';
import 'notification/notification.dart';
import 'profile/profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentTab = 0;
  final List<Widget> screens = [
    const Home(),
    const GoFeed(),
    const NotificationPage(),
    const Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black54,
          // child: const Icon(Icons.camera),
          child: const Icon(Icons.camera_alt_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanNow()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: AppColors.primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const Home();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.yellow : Colors.white,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.yellow : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const GoFeed();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: currentTab == 1 ? Colors.yellow : Colors.white,
                        ),
                        Text(
                          'GoFeed',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.yellow : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //right tab bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const MediaNewsPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2 ? Colors.yellow : Colors.white,
                        ),
                        Text(
                          'Media',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.yellow : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.yellow : Colors.white,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.yellow : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}