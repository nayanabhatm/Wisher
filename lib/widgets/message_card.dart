import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisher/models/message_model.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/state_store.dart';
import 'package:wisher/utils/widget_style.dart';
import 'package:wisher/widgets/color_box.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key key,
    this.index,
    this.onChange,
    this.initialText,
  }) : super(key: key);

  final int index;
  final String initialText;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    var stateStore = Provider.of<StateStore>(context);
    return Padding(
      padding: const EdgeInsets.all(Styles.padding10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '${Constants.message} ',
              ),
              Flexible(
                child: TextFormField(
                  initialValue: initialText,
                  decoration: _getInputDecoration(),
                  onChanged: onChange,
                  maxLength: Constants.maxInputLength,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  stateStore.addToMessageModelList(
                    MessageModel(
                      messageColor: Constants.colorsList[
                          Random().nextInt(Constants.colorsList.length)],
                      messageOffset: const Offset(20, 10),
                      messageText: Constants.message,
                      messageFont: Constants.initialFontSize,
                      messageOffsetAngle: Constants.initialAngel,
                      messageFinalAngle: Constants.initialAngel,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_circle_rounded,
                  color: Styles.colorGreen,
                  size: Styles.container40,
                ),
              ),
              if (index != 0)
                IconButton(
                  onPressed: () {
                    stateStore.removeFromMessageModelList(
                        stateStore.messageModelsList.elementAt(index));
                  },
                  icon: const Icon(
                    Icons.remove_circle_rounded,
                    color: Styles.colorRed,
                    size: Styles.container40,
                  ),
                ),
              const SizedBox(
                width: Styles.padding20,
              ),
              SizedBox(
                width: Styles.container50,
                height: Styles.container40,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Styles.colorRed,
                        Styles.colorPurple,
                        Styles.colorBlue
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(Styles.circularRadius22),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Styles.transparentColor,
                      shadowColor: Styles.transparentColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: Styles.container40,
                                  child: Center(
                                    child: Text(Constants.colorPicker),
                                  ),
                                ),
                                Wrap(
                                  children: Constants.colorsList
                                      .map(
                                        (color) => InkWell(
                                          onTap: () {
                                            stateStore.updateColor(
                                                stateStore
                                                    .messageModelsList[index],
                                                color);
                                            Navigator.pop(context);
                                          },
                                          child: ColorBox(
                                            color: color,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: Styles.padding30,
                                ),
                                const Center(
                                  child: Text(Constants.fontSizePicker),
                                ),
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return DropdownButton<double>(
                                    value: stateStore
                                        .messageModelsList[index].messageFont,
                                    items:
                                        Constants.fontSizes.map((double value) {
                                      return DropdownMenuItem<double>(
                                        value: value,
                                        child: Text(
                                          value.toString(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (double newFont) {
                                      stateStore.updateFontSize(
                                          stateStore.messageModelsList[index],
                                          newFont);
                                      setState(() {});
                                    },
                                  );
                                })
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
              const SizedBox(
                width: Styles.padding20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return const InputDecoration(
      counterText: '',
      contentPadding: EdgeInsets.all(
        Styles.padding8,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorBlueGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorBlueGrey,
        ),
      ),
    );
  }
}
