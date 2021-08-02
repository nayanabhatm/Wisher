import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class FirebaseImage extends StatelessWidget {
  const FirebaseImage({
    Key key,
    this.imageProvider,
    this.imageUrl,
  }) : super(key: key);

  final String imageUrl;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Styles.margin7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Styles.circularRadius22),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
