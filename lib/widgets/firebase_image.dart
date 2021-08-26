import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.imageProvider,
    @required this.boxFit,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Styles.margin7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Styles.circularRadius22),
        image: DecorationImage(
          image: imageProvider,
          fit: boxFit,
        ),
      ),
    );
  }
}
