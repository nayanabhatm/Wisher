import 'package:flutter/material.dart';
import 'package:wisher/models/message_model.dart';

class StateStore extends ChangeNotifier {
  final List<MessageModel> _messageModelsList = [
    MessageModel(
      messageText: 'Message',
      messageColor: Colors.blue,
      messageOffset: const Offset(10, 10),
      messageFont: 26.0,
      messageFinalAngle: 0.0,
      messageOffsetAngle: 0.0,
    ),
  ];

  List<MessageModel> get messageModelsList => _messageModelsList;

  void addToMessageModelList(MessageModel messageModel) {
    _messageModelsList.add(messageModel);
    notifyListeners();
  }

  void removeFromMessageModelList(MessageModel messageModel) {
    _messageModelsList.remove(messageModel);
    notifyListeners();
  }

  void updateColor(MessageModel messageModel, Color color) {
    messageModel.messageColor = color;
    notifyListeners();
  }

  void updateText(MessageModel messageModel, String message) {
    messageModel.messageText = message;
    notifyListeners();
  }

  void updateOffset(MessageModel messageModel, Offset offset) {
    messageModel.messageOffset = offset;
    notifyListeners();
  }

  void updateFontSize(MessageModel messageModel, double fontSize) {
    messageModel.messageFont = fontSize;
    notifyListeners();
  }

  void updateFinalAngle(MessageModel messageModel, double finalAngle) {
    messageModel.messageFinalAngle = finalAngle;
    notifyListeners();
  }

  void updateOffsetAngle(MessageModel messageModel, double offsetAngle) {
    messageModel.messageOffsetAngle = offsetAngle;
    notifyListeners();
  }
}
