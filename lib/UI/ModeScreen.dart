import 'package:flutter/material.dart';

class ModeScreen extends StatelessWidget{
  int _idPage;
  String titleStr;

  ModeScreen(_id){
    this._idPage = _id;
    if(_idPage == 2){
      titleStr = 'Lower Body Workout';
    }else if(_idPage == 1){
      titleStr = 'Full Body Workout';
    }else{
      titleStr = 'Upper Body Workout';
    }
  }
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
            child: Text('$titleStr',
            style: TextStyle(
              color: Colors.white,

            ),),
          ),
          backgroundColor: Colors.transparent,
        ),
      

        body: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 90),
              ),
              InkWell(
                  onTap: (){
                    
                  },
                  child: SizedBox(
                  height: 100.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Card(
                    color: Color(0xFF121e2f) ,
                    
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                          ),
                          Image.asset('resource/easy.png', width: 42, height: 42,),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                          ),
                          Text('EASY', style:TextStyle(
                            color: Colors.white,
                            fontSize: 42
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 70),
                            child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                          ),
                          
                        ],
                      )
                    )
                ),
                  ),
                ),
              ),
              InkWell(
                  onTap: (){

                  },
                  child: SizedBox(
                  height: 100.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Card(
                    color: Color(0xFF121e2f) ,
                    
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                          ),
                          Image.asset('resource/medium.png', width: 42, height: 42,),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                          ),
                          Text('MEDIUM', style:TextStyle(
                            color: Colors.white,
                            fontSize: 42
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                          ),

                        ],
                      )
                    )
                ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  
                },
                child: SizedBox(
                              height: 100.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Card(
                      
                    color: Color(0xFF121e2f) ,
      
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                            ),
                            Image.asset('resource/hard.png', width: 42, height: 42,),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                            ),
                            Text('HARD', style:TextStyle(
                              color: Colors.white,
                              fontSize: 42
                            )),
                            Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                          ),
                          

                          ],
                        )
                      ),
                    
                ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}