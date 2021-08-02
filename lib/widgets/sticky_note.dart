import 'package:flutter/material.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/widget_style.dart';

class StickyNote extends StatelessWidget {
  const StickyNote({
    Key key,
    this.color,
    this.wishesText,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final String wishesText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: Styles.noteHeight,
            margin: const EdgeInsets.all(Styles.margin20),
            padding: const EdgeInsets.all(Styles.padding10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(Styles.circularRadius22),
                //bottomLeft: Radius.circular(Styles.circularRadius),
              ),
            ),
            child: Center(
              child: Wrap(alignment: WrapAlignment.center, children: [
                Text(
                  '$wishesText Wishes' ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(Styles.padding8),
            child: Image.asset(
              Constants.pinImagePath,
              width: Styles.pinWidth,
              height: Styles.pinHeight,
            ),
          ),
        )
      ],
    );
  }
}
