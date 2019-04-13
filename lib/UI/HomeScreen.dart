import './SinginScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("กดกลับ login ทำเล่นๆ"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SinginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
