import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreen();
  }
}

class RegisterScreen extends State<SingUpScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sing-Up"),),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text("รอจุก")
          ],
        ),
      ),
    );
  }
}