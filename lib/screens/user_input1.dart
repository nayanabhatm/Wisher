import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/read_or_write_images.dart';
import 'package:wisher/utils/state_store.dart';
import 'package:wisher/utils/widget_style.dart';
import 'package:wisher/widgets/app_bar.dart';
import 'package:wisher/widgets/error_card.dart';
import 'package:wisher/widgets/firebase_image.dart';
import 'package:wisher/widgets/message_card.dart';

class UserInputScreen1 extends StatefulWidget {
  const UserInputScreen1({
    Key key,
    this.imageUrl,
    this.imageProvider,
    this.directoryName,
    this.fileName,
    this.imageFileName,
    this.imageUInt8list,
  }) : super(key: key);

  final String imageUrl;
  final ImageProvider imageProvider;
  final String directoryName;
  final String fileName;
  final String imageFileName;
  final Uint8List imageUInt8list;

  @override
  _UserInputScreen1State createState() => _UserInputScreen1State();
}

class _UserInputScreen1State extends State<UserInputScreen1> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateStore(),
      child: Scaffold(
        appBar: const WisherAppBar(
          appBarText: 'Customize Your Wish!',
        ),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder:
              (BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
            if (result.data == ConnectivityResult.none) {
              return const ErrorCard(
                iconData: Icons.wifi,
                errorText: 'Please check you Internet Connectivity',
              );
            }
            return Consumer<StateStore>(
              builder: (context, stateStore, child) {
                return Column(
                  children: [
                    _getRepaintBoundary(context, stateStore),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._getMessageCards(stateStore, context),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Styles.margin20 * 3,
                                horizontal: Styles.margin20,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: ElevatedButton(
                                  child: Text(
                                    'Create',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onPressed: () async {
                                    stateStore.resetShowRotateIcon();
                                    Uint8List imageUInt8list =
                                        await _capturePng(context);
                                    if (imageUInt8list != null) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return WillPopScope(
                                            onWillPop: () async => false,
                                            child: AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.memory(imageUInt8list),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  child: Text(
                                                    'Close',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  onPressed: () async {
                                                    stateStore
                                                        .setShowRotateIcon();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    'Share',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  onPressed: () async {
                                                    String directoryName =
                                                        await ReadOrWriteImages
                                                            .getFilePath(widget
                                                                .fileName);
                                                    Share.shareFiles(
                                                        [directoryName],
                                                        text:
                                                            'Shared from Wisher App');
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getMessageCards(StateStore stateStore, BuildContext context) {
    List<Widget> messageCards = [];
    int stateStoreLen = stateStore.messageModelsList.length;

    for (int i = 0; i < stateStoreLen; i++) {
      messageCards.add(
        Card(
          child: Column(
            children: [
              MessageCard(
                index: i,
                onChange: (String newInput) {
                  stateStore.updateText(
                      stateStore.messageModelsList[i], newInput);
                },
                initialText:
                    stateStore.messageModelsList[i].messageText ?? 'Message',
              ),
            ],
          ),
        ),
      );
    }
    return messageCards;
  }

  RepaintBoundary _getRepaintBoundary(
      BuildContext context, StateStore stateStore) {
    return RepaintBoundary(
      key: _globalKey,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Styles.padding10,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              FirebaseImage(
                imageUrl: widget.imageUrl,
                imageProvider: widget.imageProvider,
              ),
              ...stateStore.messageModelsList
                  .map(
                    (message) => Positioned(
                      left: message.messageOffset.dx,
                      top: message.messageOffset.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          Offset newOffset = Offset(
                              message.messageOffset.dx + details.delta.dx,
                              message.messageOffset.dy + details.delta.dy);
                          stateStore.updateOffset(message, newOffset);
                        },
                        child: Column(
                          children: [
                            Transform.rotate(
                              angle: message.messageFinalAngle,
                              child: Text(
                                message.messageText,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: message.messageColor,
                                      fontSize:
                                          message.messageFont, //width * 0.087,
                                      fontFamily: Constants.fontFamily,
                                    ),
                              ),
                            ),
                            if (message.showRotateIcon)
                              Transform.rotate(
                                angle: message.messageFinalAngle,
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    color: Colors.white,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onPanStart: (details) {
                                          Offset centerOfGestureDetector =
                                              Offset(constraints.maxWidth / 2,
                                                  constraints.maxHeight / 2);
                                          final touchPositionFromCenter =
                                              details.localPosition -
                                                  centerOfGestureDetector;
                                          stateStore.updateOffsetAngle(
                                              message,
                                              touchPositionFromCenter
                                                      .direction -
                                                  message.messageFinalAngle);
                                        },
                                        onPanUpdate: (details) {
                                          Offset centerOfGestureDetector =
                                              Offset(constraints.maxWidth / 2,
                                                  constraints.maxHeight / 2);
                                          final touchPositionFromCenter =
                                              details.localPosition -
                                                  centerOfGestureDetector;
                                          setState(() {
                                            stateStore.updateFinalAngle(
                                                message,
                                                touchPositionFromCenter
                                                        .direction -
                                                    message.messageOffsetAngle);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.refresh,
                                          size: 30.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _capturePng(BuildContext context) async {
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
      print('exception:$e');
      return null;
    }
  }
}
