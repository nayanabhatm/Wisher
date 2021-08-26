import 'package:flutter/material.dart';
import 'package:wisher/utils/constants.dart';
import 'package:wisher/utils/widget_style.dart';

class AppDialog {
  static void showProgressIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
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
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: Styles.padding10,
                      ),
                      Text(
                        Constants.pleaseWait,
                      ),
                    ],
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
