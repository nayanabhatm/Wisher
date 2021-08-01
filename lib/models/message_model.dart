import 'package:flutter/material.dart';

class MessageModel {
  MessageModel({
    this.messageColor,
    this.messageText,
    this.messageOffset,
    this.messageFont,
    this.messageFinalAngle,
    this.messageOffsetAngle,
    this.textEditingController,
  });

  Color messageColor;
  String messageText;
  Offset messageOffset;
  double messageFont;
  double messageFinalAngle;
  double messageOffsetAngle;
  TextEditingController textEditingController;
}
