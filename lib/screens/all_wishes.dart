import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisher/screens/existing_template_screen.dart';
import 'package:wisher/screens/user_input.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/widgets/template_card.dart';
import 'package:wisher/widgets/wisher_banner.dart';

class Wishes extends StatelessWidget {
  const Wishes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagePicker = ImagePicker();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const WisherBanner(),
            Flexible(
              child: TemplateCard(
                imagePath: Constants.cameraOrGalleryImagePath,
                imageOnTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text(Constants.camera),
                              trailing: const Icon(Icons.camera_alt),
                              onTap: () async {
                                await _getImageFromSource(
                                    imagePicker, context, ImageSource.camera);
                              },
                            ),
                            ListTile(
                              title: const Text(Constants.gallery),
                              trailing: const Icon(Icons.collections),
                              onTap: () async {
                                await _getImageFromSource(
                                    imagePicker, context, ImageSource.gallery);
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Flexible(
              child: TemplateCard(
                imagePath: Constants.pickImageFromTemplateImagePath,
                imageOnTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const TemplateScreen();
                        },
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromSource(ImagePicker imagePicker,
      BuildContext context, ImageSource imageSource) async {
    final XFile pickedFile = await imagePicker.pickImage(
      source: imageSource,
      imageQuality: 85,
      maxHeight: 720,
      maxWidth: 720,
    );
    if (pickedFile != null) {
      Uint8List uint8List = await File(pickedFile.path).readAsBytes();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UserInputScreen(
              imageUInt8list: uint8List,
            );
          },
        ),
      );
    }
  }
}
