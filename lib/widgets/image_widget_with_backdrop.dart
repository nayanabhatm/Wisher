import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class ImageWidgetWithBackdrop extends StatelessWidget {
  const ImageWidgetWithBackdrop({
    Key key,
    @required this.imageProvider,
    @required this.boxFit,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: Styles.margin7,
            horizontal: Styles.margin20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Styles.circularRadius22),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Styles.margin7,
              horizontal: Styles.margin20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Styles.circularRadius22),
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
