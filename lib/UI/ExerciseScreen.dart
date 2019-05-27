import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget{
  int _idPage;
  String mode;

  ExerciseScreen(this._idPage, this.mode);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseScreenState(_idPage, mode);
  }

}

class ExerciseScreenState extends State<ExerciseScreen>{
  int _id;
  String mode;

  ExerciseScreenState(this._id, this.mode);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$mode',
            style: TextStyle(
              color: Colors.white,

            ),),
          ),
          backgroundColor: Colors.transparent,
        ),
        
        body: Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Text('10 KCAL', style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Text('5-6 MIN', style: TextStyle(
                      fontSize: 20,
                      color:Colors.white
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text('$mode', style: TextStyle(
                      fontSize: 20,
                      color:Colors.white
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      
      )
      
    );
  }

}