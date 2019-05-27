import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  int _idPage;
  String mode;

  ExerciseScreen(this._idPage, this.mode);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseScreenState(_idPage, mode);
  }
}

class ExerciseScreenState extends State<ExerciseScreen> {
  int _id;
  String mode;

  ExerciseScreenState(this._id, this.mode);
  @override
  Widget build(BuildContext context) {
    double screen_w = MediaQuery.of(context).size.width,
        screen_h = MediaQuery.of(context).size.height;
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
              child: Text(
                '$mode',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Container(
              // padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('workout')
                .document(_id.toString())
                .collection(mode)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                print(
                    "--------------------------${snapshot.data.documents[0]['name']}");
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20.0, right: 20.0, top: 0),
                          child: new Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print("TEST");
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("${snapshot.data.documents[index]['name']}"),
                                        content: Image.asset(
                                          'resource/$_id/${snapshot.data.documents[index]['name']}.gif',),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: SizedBox(
                                height: screen_h * .15,
                                child: Card(
                                  color: Color(0xFF1b1e44),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, top: 0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'resource/$_id/${snapshot.data.documents[index]['name']}.gif',
                                          width: screen_w * 0.25,
                                          height: screen_h * 0.25,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: screen_h * .035,
                                              left: screen_w * .03),
                                          child: Column(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      snapshot.data
                                                              .documents[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0)),
                                                  Text(
                                                      snapshot.data
                                                              .documents[index]
                                                          ['set'],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
        ));
  }
}
