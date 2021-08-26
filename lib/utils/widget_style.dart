import 'package:flutter/material.dart';

class Styles {
  // Margin
  static const double margin3 = 3.0;
  static const double margin7 = 7.0;
  static const double margin20 = 20.0;

  // Padding
  static const double padding8 = 8.0;
  static const double padding10 = 10.0;
  static const double padding20 = 20.0;
  static const double padding30 = 30.0;
  static const double padding45 = 45.0;

  // Others
  static const double noteHeight = 180.0;
  static const double pinWidth = 60.0;
  static const double pinHeight = 40.0;
  static const double progressIndicatorSize = 60.0;
  static const double progressIndicatorStrokeWidth = 6.0;
  static const double buttonIconSize30 = 30.0;
  static const double container40 = 40.0;
  static const double container50 = 50.0;
  static const double refreshIconSize = 30.0;
  static const double colorBoxSize = 25.0;
  static const double elevation = 10.0;
  static const double dialogHeight = 200;

  static const double circularRadius4 = 4.0;
  static const double circularRadius10 = 10.0;
  static const double circularRadius22 = 22.0;
  static const double circularRadius32 = 32.0;

  // Colors
  static const Color colorWhite = Colors.white;
  static const Color colorBlueGrey = Colors.blueGrey;
  static const Color colorRed = Colors.red;
  static const Color colorPurple = Colors.purple;
  static const Color colorBlue = Colors.blue;
  static const Color colorGreen = Colors.green;
  static Color colorGreyShade300 = Colors.grey.shade300;
  static Color colorGrey = const Color(0xffcccccc);
  static const Color transparentColor = Colors.transparent;
  static const Color colorBlack = Colors.black;

  static Color wisherBkgColor = const Color(0xffbe0000).withOpacity(0.8);
  static Color primaryColor = const Color(0xffbe0000);
  static Color secondaryColor = const Color(0xff72147e);
  static Color colorDarkBlueGrey = const Color(0xff2B3A59);

  // FontSize
  static const double fontSize32 = 32.0;
  static const double fontSize24 = 24.0;
  static const double fontSize22 = 22.0;
  static const double fontSize20 = 20.0;

  static const String fontFamily = 'JosefinSans';
  static const String messageFontFamily = 'Courgette';

  static ColorScheme appColorScheme() {
    return const ColorScheme.highContrastLight().copyWith(
      secondary: secondaryColor,
      primary: primaryColor,
    );
  }
}
