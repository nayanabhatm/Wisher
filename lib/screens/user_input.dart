import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/read_or_write_images.dart';
import 'package:wisher/utils/widget_style.dart';
import 'package:wisher/widgets/app_bar.dart';
import 'package:wisher/widgets/error_card.dart';
import 'package:wisher/widgets/firebase_image.dart';

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({
    Key key,
    this.imageUrl,
    this.imageProvider,
    this.directoryName,
    this.fileName,
  }) : super(key: key);

  final String imageUrl;
  final ImageProvider imageProvider;
  final String directoryName;
  final String fileName;

  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  TextEditingController message1Controller =
      TextEditingController(text: Constants.message1);
  TextEditingController message2Controller =
      TextEditingController(text: Constants.message2);
  final GlobalKey _globalKey = GlobalKey();
  String message1 = Constants.message1;
  String message2 = Constants.message2;
  String imageFileName;
  Uint8List imageUInt8list;
  Offset message1Offset = Offset(20, 170);
  Offset message2Offset = Offset(3, 200);
  Color message1Color = Colors.black;
  Color message2Color = Colors.red;

  List<Color> message1Colors;
  List<Color> message2Colors;

  @override
  void initState() {
    super.initState();
    imageFileName = widget.fileName.split('.')[0];
    message1Colors = Constants.colorsList;
    message2Colors = Constants.colorsList;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: WisherAppBar(
        appBarText: 'Customize Your Wish!',
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                          'Hold, drag & place the \'Messages\' anywhere on the Image'),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.info),
          )
        ],
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
          if (result.data == ConnectivityResult.none) {
            return ErrorCard(
              iconData: Icons.wifi,
              errorText: 'Please check you Internet Connectivity',
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                _getRepaintBoundary(width, context),
                Card(
                  elevation: 6,
                  child: getMessage(
                    title: Constants.message1,
                    controller: message1Controller,
                    colorsList: message1Colors,
                  ),
                ),
                Card(
                  elevation: 6,
                  child: getMessage(
                    title: Constants.message2,
                    controller: message2Controller,
                    colorsList: message2Colors,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Styles.margin,
                    horizontal: Styles.margin,
                  ),
                  child: ElevatedButton(
                    style: getElevatedButtonStyle(),
                    child: Text(
                      'Create',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onPressed: () async {
                      imageUInt8list = await _capturePng();
                      if (imageUInt8list != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.memory(imageUInt8list),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  style: getElevatedButtonStyle(),
                                  child: Text(
                                    'Reset',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    setState(() {
                                      message1 = Constants.message1;
                                      message2 = Constants.message2;
                                    });
                                  },
                                ),
                                ElevatedButton(
                                  style: getElevatedButtonStyle(),
                                  child: Text(
                                    'Share',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onPressed: () async {
                                    String directoryName =
                                        await ReadOrWriteImages.getFilePath(
                                            widget.fileName);
                                    Share.shareFiles([directoryName],
                                        text: 'Shared from Wisher App');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding getMessage(
      {String title,
      TextEditingController controller,
      List<Color> colorsList}) {
    return Padding(
      padding: const EdgeInsets.all(Styles.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
              ),
              Flexible(
                child: TextFormField(
                  // key: ValueKey(title),
                  controller: controller,
                  decoration: _getInputDecoration(title),
                  onChanged: (newName) {
                    if (title == Constants.message1) {
                      setState(() {
                        message1 = newName;
                      });
                    } else if (title == Constants.message2) {
                      setState(() {
                        message2 = newName;
                      });
                    }
                  },
                  maxLength: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Styles.padding,
          ),
          SizedBox(
            width: 50.0,
            height: 40.0,
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red, Colors.purple, Colors.blue],
                ),
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40.0,
                              child: Center(
                                child: Text('Color Picker'),
                              ),
                            ),
                            Wrap(
                              children: Constants.colorsList
                                  .map(
                                    (color) => InkWell(
                                      onTap: () {
                                        if (title == Constants.message1) {
                                          setState(() {
                                            message1Color = color;
                                          });
                                        } else if (title ==
                                            Constants.message2) {
                                          setState(() {
                                            message2Color = color;
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: ColorBox(
                                        color: color,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle getElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  RepaintBoundary _getRepaintBoundary(double width, BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Styles.padding,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              FirebaseImage(
                imageUrl: widget.imageUrl,
                imageProvider: widget.imageProvider,
              ),
              Positioned(
                left: message1Offset.dx,
                top: message1Offset.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      message1Offset = Offset(
                          message1Offset.dx + details.delta.dx,
                          message1Offset.dy + details.delta.dy);
                    });
                  },
                  child: SizedBox(
                    width: width - 30,
                    child: Text(
                      message1,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: message1Color,
                            fontSize: width * 0.087,
                            fontFamily: Constants.fontFamily,
                          ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: message2Offset.dx,
                top: message2Offset.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      message2Offset = Offset(
                          message2Offset.dx + details.delta.dx,
                          message2Offset.dy + details.delta.dy);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width - 30,
                      child: Text(
                        message2,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: message2Color,
                              fontSize: width * 0.045,
                              fontFamily: Constants.fontFamily,
                            ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(String hintText) {
    return InputDecoration(
      counterText: '',
      contentPadding: EdgeInsets.only(
        top: Styles.inputContentPadding,
        bottom: Styles.inputContentPadding,
        left: Styles.inputContentPadding,
        right: Styles.inputContentPadding,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      //var bs64 = base64Encode(pngBytes);
      ReadOrWriteImages.saveFile(pngBytes, widget.fileName);
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class ColorBox extends StatelessWidget {
  const ColorBox({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );
  }
}
