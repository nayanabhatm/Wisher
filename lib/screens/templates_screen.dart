import 'package:flutter/material.dart';
import 'package:wisher/screens/firebase_images.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/widgets/sticky_note.dart';
import 'package:wisher/widgets/wisher_banner.dart';

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const WisherBanner(
              title: '${Constants.appTitle} ${Constants.templates}',
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: Constants.wishes.length,
                itemBuilder: (BuildContext ctx, index) {
                  return StickyNote(
                    color: Constants.wishes.values.toList()[index],
                    wishesText: Constants.wishes.keys.toList()[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoadFirebaseImages(
                              appBarText: Constants.wishes.keys.toList()[index],
                              firebaseDirectoryName:
                                  Constants.wishes.keys.toList()[index],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
