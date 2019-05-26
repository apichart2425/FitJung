import 'package:fitjung/UI/HomeScreen.dart';
// import 'package:fitjung/UI/ImageScreen.dart';
import 'package:fitjung/UI/SignInfoScreen.dart';
import 'package:fitjung/UI/SigninScreen.dart';
import 'package:fitjung/UI/SignupScreen.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: "/signin",
      routes: {
        "/" : (context) => HomeScreen(),
        "/signin": (context) => SigninScreen(),
        "/signup": (context) => SignUpScreen(),
        "/signinfo": (context) => SignInfoScreen(),
        // "/image": (context) => ImageScreen(),

      },
    );
  }
}