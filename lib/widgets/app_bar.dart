import 'package:flutter/material.dart';
import 'package:wisher/utils/widget_style.dart';

class WisherAppBar extends StatelessWidget with PreferredSizeWidget {
  const WisherAppBar({
    Key key,
    @required this.appBarText,
  }) : super(key: key);

  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.primaryColor,
      title: Text(
        appBarText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: Styles.buttonIconSize30,
        ),
        color: Styles.colorWhite,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
