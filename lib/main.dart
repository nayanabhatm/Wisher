import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisher/screens/all_wishes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StickyNoteApp());
}

class StickyNoteApp extends StatelessWidget {
  const StickyNoteApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xffbe0000),
            ),
          ),
        ),
        colorScheme: const ColorScheme.highContrastLight().copyWith(
          secondary: const Color(0xff72147e),
          primary: const Color(0xffbe0000),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'JosefinSans',
          ),
          bodyText2: TextStyle(
            fontSize: 20.0,
            color: Colors.blueGrey,
            fontFamily: 'JosefinSans',
          ),
        ),
      ),
      color: Colors.white,
      home: const Wishes(),
    );
  }
}
