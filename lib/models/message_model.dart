import 'package:flutter/material.dart';
import 'package:wisher/utils/constants.dart';

class MessageModel {
  MessageModel({
    this.messageColor,
    this.messageText,
    this.messageOffset = Constants.initialOffset,
    this.messageFont = Constants.initialFontSize,
    this.messageFinalAngle = Constants.initialAngel,
    this.messageOffsetAngle = Constants.initialAngel,
    this.showRotateIcon = true,
  });

  Color messageColor;
  String messageText;
  Offset messageOffset;
  double messageFont;
  double messageFinalAngle;
  double messageOffsetAngle;
  bool showRotateIcon;
}
