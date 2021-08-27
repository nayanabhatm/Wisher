import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class AppDialog {
  static void showAppDialog(BuildContext context, List<Widget> childWidgets,
      bool barrierDismissible) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: Dialog(
          insetPadding: const EdgeInsets.all(Styles.padding45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.circularRadius4),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: Styles.dialogHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: childWidgets,
                  ),
                ),
                const SizedBox(
                  height: Styles.padding10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
