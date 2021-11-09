import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisher/screens/wishes.dart';
import 'package:wisher/utils/state_store.dart';
import 'package:wisher/utils/widget_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StickyNoteApp());
}

class StickyNoteApp extends StatelessWidget {
  const StickyNoteApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Styles.colorGrey;
                  }
                  return Styles.primaryColor;
                },
              ),
            ),
          ),
          colorScheme: Styles.appColorScheme(),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: Styles.fontSize22,
              color: Styles.colorWhite,
              fontFamily: Styles.fontFamily,
            ),
            bodyText2: TextStyle(
              fontSize: Styles.fontSize20,
              color: Styles.colorBlueGrey,
              fontFamily: Styles.fontFamily,
            ),
            headline3: TextStyle(
              fontSize: Styles.fontSize24,
              color: Styles.colorBlueGrey,
              fontFamily: Styles.fontFamily,
            ),
          ),
        ),
        color: Styles.colorWhite,
        home: const Wishes(),
      ),
    );
  }
}
