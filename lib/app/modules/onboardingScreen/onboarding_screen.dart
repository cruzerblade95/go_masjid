import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/login_or_register_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  late Image image1;
  late Image image2;
  late Image image3;

  @override
  void initState() {
    super.initState();
    image1 = Image.asset("assets/images/islamic_2.jpg");
    image2 = Image.asset("assets/images/islamic_3.jpg");
    image3 = Image.asset("assets/images/islamic_4.jpg");
  }

  @override
  void didChangeDependencies() {
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    super.didChangeDependencies();
  }

  // controller to keep track of which page we're on
  PageController _controller = PageController();

  // keep track of if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            allowImplicitScrolling: true,
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/islamic_4.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add other widgets here
                    SizedBox(height: 250),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        "Explore The Mosque",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Lets Start Here!",
                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/islamic_2.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add other widgets here
                    SizedBox(height: 250),
                    Text(
                      "Mosque \n And Muslim Application",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Lets Start Here!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/islamic_3.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add other widgets here
                    SizedBox(height: 250),
                    Text(
                      "Welcome To",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image(
                      width: 200,
                      image: AssetImage("assets/icons/gomasjid_logo.png")
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Bismillah",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return LoginOrRegisterPage();
                              }));
                        },
                        child: Text("Done")
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                    onTap: (){
                      _controller.jumpToPage(2);
                    },
                    child: Text('Skip')
                ),

                // dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // next or done button
                onLastPage
                    ? GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                            return LoginOrRegisterPage();
                          }));
                        },
                        child: Text('Done'),
                      )
                    : GestureDetector(
                        onTap: (){
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('Next'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
