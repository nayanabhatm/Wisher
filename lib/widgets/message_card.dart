import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisher/models/message_model.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/state_store.dart';
import 'package:wisher/utils/widget_style.dart';
import 'package:wisher/widgets/color_box.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    Key key,
    this.index,
    this.onChange,
    this.initialText,
  }) : super(key: key);

  final int index;
  final ValueChanged<String> onChange;
  final String initialText;

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    print('dispose');
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      textEditingController.text = widget.initialText;
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
    });

    var stateStore = Provider.of<StateStore>(context);
    return Padding(
      padding: const EdgeInsets.all(Styles.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Message${widget.index + 1} ',
              ),
              Flexible(
                child: TextFormField(
                  controller: textEditingController,
                  decoration: _getInputDecoration(),
                  onChanged: widget.onChange,
                  maxLength: 30,
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
                      messageText: 'Message',
                      messageFont: 26.0,
                      messageOffsetAngle: 0.0,
                      messageFinalAngle: 0.0,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_circle_rounded,
                  color: Colors.green,
                  size: 38,
                ),
              ),
              IconButton(
                onPressed: () {
                  stateStore.removeFromMessageModelList(
                      stateStore.messageModelsList.elementAt(widget.index));
                },
                icon: const Icon(
                  Icons.remove_circle_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
                                const SizedBox(
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
                                            stateStore.updateColor(
                                                stateStore.messageModelsList[
                                                    widget.index],
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
                                  height: 30.0,
                                ),
                                const Center(
                                  child: Text('FontSize Picker'),
                                ),
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return DropdownButton<double>(
                                    value: stateStore
                                        .messageModelsList[widget.index]
                                        .messageFont,
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
                                          stateStore
                                              .messageModelsList[widget.index],
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
                width: 20.0,
              ),
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: Colors.grey,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        Offset centerOfGestureDetector = Offset(
                            constraints.maxWidth / 2,
                            constraints.maxHeight / 2);
                        final touchPositionFromCenter =
                            details.localPosition - centerOfGestureDetector;
                        stateStore.updateOffsetAngle(
                            stateStore.messageModelsList[widget.index],
                            touchPositionFromCenter.direction -
                                stateStore.messageModelsList[widget.index]
                                    .messageFinalAngle);
                      },
                      onPanUpdate: (details) {
                        Offset centerOfGestureDetector = Offset(
                            constraints.maxWidth / 2,
                            constraints.maxHeight / 2);
                        final touchPositionFromCenter =
                            details.localPosition - centerOfGestureDetector;
                        setState(() {
                          stateStore.updateFinalAngle(
                              stateStore.messageModelsList[widget.index],
                              touchPositionFromCenter.direction -
                                  stateStore.messageModelsList[widget.index]
                                      .messageOffsetAngle);
                        });
                      },
                      child: Transform.rotate(
                        angle: stateStore
                            .messageModelsList[widget.index].messageFinalAngle,
                        child: const Icon(
                          Icons.settings,
                          size: 40.0,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return const InputDecoration(
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
}
