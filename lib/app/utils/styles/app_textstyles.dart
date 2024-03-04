import 'package:flutter/material.dart';

const textStyles = _TextStyles();

class _TextStyles {
  const _TextStyles();

  TextStyle get defaultTextStyle {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get thinTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get lightTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get mediumTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get boldTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get extraBoldTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle get blackTextStyle {
    return defaultTextStyle.copyWith(
      fontWeight: FontWeight.w900,
    );
  }
}
