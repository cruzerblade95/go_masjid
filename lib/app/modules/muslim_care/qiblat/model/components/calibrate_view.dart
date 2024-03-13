import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/controller/logic_controller.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/model/constants.dart';

class CalibrateView extends StatelessWidget {
  late final Lang lang;
  late String line1;
  late String line2;
  CalibrateView({super.key, required this.lang}) {
    if (lang == Lang.ar) {
      line1 = kArCalib1;
      line2 = kArCalib2;
    } else {
      line1 = kEnCalib1;
      line2 = kEnCalib2;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/Calibration.gif'),
          Padding(
            padding: EdgeInsets.only(top: 70, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(text: line1, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Tajawal', height: 1.3 /* , letterSpacing: 1 */), children: [
                      TextSpan(text: line2, style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ])),
                Padding(padding: EdgeInsets.symmetric(horizontal: 70), child: SizedBox(height: 3, child: LinearProgressIndicator()))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
