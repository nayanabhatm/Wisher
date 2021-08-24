import 'package:flutter/material.dart';

class Constants {
  static const String appTitle = 'Wisher';
  static const String checkConnectivity =
      'Please check you Internet Connectivity';
  static const String someError =
      'Something went wrong. Please check your InternetConnectivity';
  static const String noImages = 'No Images';
  static const String customizeWish = 'Customize Your Wish!';
  static const String create = 'Create';
  static const String close = 'Close';
  static const String share = 'Share';
  static const String message = 'Message';
  static const String fontSizePicker = 'FontSize Picker';
  static const String colorPicker = 'Color Picker';
  static const String sharedFromApp = 'Shared from Wisher App';
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String cameraOrGalleryImagePath =
      'assets/images/camera_or_gallery.jpg';
  static const String pickImageFromTemplateImagePath =
      'assets/images/pick_from_templates.jpg';
  static const String wishesStr = 'Wishes';
  static const String templates = 'Templates';
  static const String pinImagePath = 'assets/images/pin.png';

  // Wish String constants
  static const String republicDay = 'RepublicDay';
  static const String independenceDay = 'IndependenceDay';
  static const String sankranti = 'Sankranti/Pongal';
  static const String birthday = 'Birthday';
  static const String wedding = 'Wedding';
  static const String anniversary = 'Anniversary';
  static const String mothersDay = 'Mother\'s Day';
  static const String fathersDay = 'Father\'s Day';
  static const String womenDay = 'Women\'s Day';
  static const String eidMubarak = 'Eid Mubarak';
  static const String ugadi = 'Ugadi';
  static const String easter = 'Happy Easter';
  static const String holy = 'Holy';
  static const String shivratri = 'Maha Shivratri';
  static const String friendShipDay = 'Friendship Day';
  static const String valentineDay = 'Valentine\'s Day';
  static const String newYear = 'Happy New Year';
  static const String christmas = 'Christmas';
  static const String diwali = 'Diwali';
  static const String ganeshaChaturti = 'Ganesh Chaturti';
  static const String navaratri = 'Dussehra, Navaratri, DurgaPuja';
  static const String ramNavami = 'Ram Navami';
  static const String thanksFor = 'Thanks For';
  static const String onam = 'Onam';
  static const String janmashtami = 'Krishna Janmashtami';
  static const String rakshaBandhan = 'Raksha Bandhan';

  static const Map<String, Color> wishes = {
    republicDay: Color(0xffffc93c),
    independenceDay: Color(0xff2f5d62),
    sankranti: Color(0xff00adb5),
    birthday: Color(0xfffea82f),
    wedding: Color(0xff2f5d62),
    anniversary: Color(0xff325288),
    mothersDay: Color(0xffff8474),
    fathersDay: Color(0xffcdc733),
    womenDay: Color(0xff344fa1),
    eidMubarak: Color(0xff81b214),
    // ramNavami: Color(0xffffdf6b),
    ugadi: Color(0xff00adb5),
    easter: Color(0xff325288),
    // thanksFor: Color(0xff114e60),
    holy: Color(0xff2978b5),
    shivratri: Color(0xffa35709),
    friendShipDay: Color(0xff0061a8),
    valentineDay: Color(0xff194350),
    newYear: Color(0xff7b113a),
    christmas: Color(0xffd44000),
    diwali: Color(0xfff58634),
    ganeshaChaturti: Color(0xff5aa897),
    navaratri: Color(0xff845460),
    // onam: Color(0xff2f5d62),
    // janmashtami: Color(0xff5b8a72),
    // rakshaBandhan: Color(0xff9e9d89),
  };

  static const List<Color> colorsList = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.limeAccent,
    Colors.yellowAccent,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];

  static const List<double> fontSizes = [
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30,
    32,
    34,
    36,
    38,
    40
  ];

  static const Offset initialOffset = Offset(10, 10);
  static const double initialFontSize = 26.0;
  static const double initialAngel = 0.0;
  static const int maxInputLength = 30;
}
