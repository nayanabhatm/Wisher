import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key key,
    this.errorText,
    this.iconData,
  }) : super(key: key);

  final String errorText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: Styles.padding10),
                  child: Icon(
                    iconData,
                    size: Styles.buttonIconSize30,
                    color: Styles.colorBlueGrey,
                  ),
                ),
              Text(
                errorText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
