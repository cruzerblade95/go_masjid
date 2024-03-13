import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/model/constants.dart';
import 'package:go_masjid/app/modules/muslim_care/qiblat/model/components/tips.dart' as Tips;
import 'package:go_masjid/app/modules/muslim_care/qiblat/model/components/title.dart' as Title;
import 'package:shared_preferences/shared_preferences.dart';

enum Lang { en, ar }

class LogicController {
  late Lang currLang;
  late String langString;
  late Alignment tipsAlignment;
  late TextAlign tipsTextAlignment;
  late Widget tips;
  late String permissionErr;
  late String locationServicesErr;
  late String loadingMessage;
  late String ambiguousErr;
  late Widget title;
  late SharedPreferences localData;
  String needleAsset = 'assets/images/Needle.png';
  Color isExact = kTransparent;

  Future<void> setUpLang() async {
    await getCurrLang();
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tips = (currLang == Lang.ar) ? Tips.ArabicTips() : Tips.EnglishTips();
    title = (currLang == Lang.ar) ? Title.ArabicTitle() : Title.EnglishTitle();
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    loadingMessage = (currLang == Lang.ar) ? kArLoadingMessage : kEnLoadingMessage;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

  void updateLang() {
    currLang = (currLang == Lang.ar) ? Lang.en : Lang.ar;
    localData.setString('language', currLang.toString());
    langString = (currLang == Lang.ar) ? kEnLangString : kArLangString;
    tips = (currLang == Lang.ar) ? Tips.ArabicTips() : Tips.EnglishTips();
    title = (currLang == Lang.ar) ? Title.ArabicTitle() : Title.EnglishTitle();
    permissionErr = (currLang == Lang.ar) ? kArPermissionErr : kEnPermissionErr;
    locationServicesErr = (currLang == Lang.ar) ? kArLocationServicesErr : kEnLocationServicesErr;
    loadingMessage = (currLang == Lang.ar) ? kArLoadingMessage : kEnLoadingMessage;
    ambiguousErr = (currLang == Lang.ar) ? kArAmbiguousErr : kEnAmbiguousErr;
  }

  Future<void> getCurrLang() async {
    localData = await SharedPreferences.getInstance();
    if (localData.get('language') != null)
      currLang = (localData.get('language') == Lang.ar.toString()) ? Lang.ar : Lang.en;
    else {
      currLang = (ui.window.locale.languageCode == 'ar') ? Lang.ar : Lang.en;
      localData.setString('language', currLang.toString());
    }
  }
}
