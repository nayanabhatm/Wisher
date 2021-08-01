import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class WisherProgressIndicator extends StatelessWidget {
  const WisherProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: Styles.progressIndicatorSize,
        height: Styles.progressIndicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: Styles.progressIndicatorStrokeWidth,
        ),
      ),
    );
  }
}
