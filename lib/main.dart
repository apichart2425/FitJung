import 'package:fitjung/UI/HomeScreen.dart';
import 'package:fitjung/UI/SingupScreen.dart';
import 'package:flutter/material.dart';
import './UI/SinginScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: "/signup",
      routes: {
        "/" : (context) => HomeScreen(),
        "/signin": (context) => SinginScreen(),
        "/signup": (context) => SingUpScreen(),
      },
    );
  }
}