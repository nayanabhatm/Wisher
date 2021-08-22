import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class ColorBox extends StatelessWidget {
  const ColorBox({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Styles.margin3),
      width: Styles.colorBoxSize,
      height: Styles.colorBoxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Styles.circularRadius10),
        color: color,
      ),
    );
  }
}
