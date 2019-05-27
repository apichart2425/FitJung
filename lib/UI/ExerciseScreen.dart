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
    double screen_w = MediaQuery.of(context).size.width, screen_h = MediaQuery.of(context).size.height;
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
            padding: EdgeInsets.only(left: 70.0),
            child: Text('$mode',
            style: TextStyle(
              color: Colors.white,

            ),),
          ),
          backgroundColor: Colors.transparent,
        ),
        
        body: Container(
          // padding: EdgeInsets.only(right: 20.0, left: 20.0),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20),),
                  Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 35.0,right: 70.0),
                      child: Column(
                        children: <Widget>[
                          Text('35', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0
                          )),
                          Text('KCAL', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0
                          )),
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 70.0),
                      child: Column(
                        children: <Widget>[
                          Text('5-6', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0
                          )),
                          Text('MIN', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0
                          )),
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text('${mode.toUpperCase()}', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0
                          )),
                          Text('LEVEL', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0
                          )),
                        ],
                      )
                    ),
                  ],
                ),
                Padding(
                  
                  padding: EdgeInsets.only(left: 20.0, right:20.0, top: 10.0),
                    child: new Container(
                    height: 1.5,
                    color:  Colors.grey,
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                          height: 100.0,
                          
                          child: Card(
                          color: Color(0xFF1b1e44),
                          child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 0.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset('resource/1/GateSwings.gif', width: screen_w*0.25, height: screen_h*0.25,),
                              Padding(
                                  padding: EdgeInsets.only(top: 20, left:30),
                                  child: Column(
                                  children: <Widget>[
                                    
                                    Text('Gate Swings', style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                    )),
                                    Text('x 18', style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 60.0),
                                child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                          ),
                            ],
                            ),
                        ),

                      ),
                    ),
                    
                    
                  ],
                )
            ],
          ),
        ),
      
      )
      
    );
  }

}