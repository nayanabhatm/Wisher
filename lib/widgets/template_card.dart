import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    Key key,
    @required this.imagePath,
    this.imageOnTap,
  }) : super(key: key);

  final String imagePath;
  final VoidCallback imageOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imageOnTap,
      child: Container(
        padding: const EdgeInsets.only(top: Styles.padding10),
        margin: const EdgeInsets.all(Styles.padding20),
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Styles.circularRadius22),
        ),
        child: Card(
          elevation: Styles.elevation,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
