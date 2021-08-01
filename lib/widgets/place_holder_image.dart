import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class PlaceHolderImageWidget extends StatelessWidget {
  const PlaceHolderImageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(Styles.circularRadius),
      ),
      margin: const EdgeInsets.all(Styles.imagesMargin),
    );
  }
}
