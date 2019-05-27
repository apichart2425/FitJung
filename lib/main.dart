import 'package:fitjung/UI/HomeScreen.dart';
import 'package:fitjung/UI/MapScreen.dart';
import 'package:fitjung/UI/ProfileScreen.dart';
import 'package:fitjung/UI/SignInfoScreen.dart';
import 'package:fitjung/UI/SigninScreen.dart';
import 'package:fitjung/UI/SignupScreen.dart';
import 'package:fitjung/UI/TestScreen.dart';
import 'package:flutter/material.dart';
import './map/mapApi.dart';
import 'UI/ModeScreen.dart';

import 'UI/ProfileUser.dart';
import 'UI/SplashScreen.dart';




void main() => runApp(MyApp());
const MaterialColor colors = const MaterialColor(
  0xff1f1f2b,
  const <int, Color>{
    50: const Color(0xff1f1f2b),
    100: const Color(0xff1f1f2b),
    200: const Color(0xff1f1f2b),
    300: const Color(0xff1f1f2b),
    400: const Color(0xff1f1f2b),
    500: const Color(0xff1f1f2b),
    600: const Color(0xff1f1f2b),
    700: const Color(0xff1f1f2b),
    800: const Color(0xff1f1f2b),
    900: const Color(0xff1f1f2b),
  },
);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colors,
        
      ),

      initialRoute: "/splash",

      routes: {
        "/" : (context) => HomeScreen(),
        "/signin": (context) => SigninScreen(),
        "/signup": (context) => SignUpScreen(),
        "/signinfo": (context) => SignInfoScreen(),
        "/map": (context) => MapApiPage(),
        '/profile': (context) => ProfileScreen(),
        '/modescreen': (context) => ModeScreen(null),
        '/profileuser': (context) => ProfileUser(),
        '/test': (context) => TestScreen(),
        '/splash': (context) => SplashScreen(),
        // "/image": (context) => ImageScreen(),

      },
    );
  }
}