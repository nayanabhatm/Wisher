import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class WisherBanner extends StatelessWidget {
  const WisherBanner({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
        color: Styles.wisherBkgColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(Styles.circularRadius32),
          bottomLeft: Radius.circular(Styles.circularRadius32),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Styles.colorWhite,
            fontSize: Styles.fontSize32,
          ),
        ),
      ),
    );
  }
}
