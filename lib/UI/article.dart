import 'package:flutter/material.dart';
import '../utility/firestore_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import '../utility/share.dart';

class Article extends StatefulWidget {
  int _id;

  Article(this._id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ArticleState(_id);
  }
}

class _ArticleState extends State<Article> {
  String titlename;
   int id;

  Article(this.id);
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
              '${titlename}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('article').document(id.toString()).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          titlename = snapshot.data.documents[index]['title'];
                          
                          Text("data");
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Text('data', style: TextStyle(color: Colors.white,)),
                                  Image.network()
                                  // Text(snapshot.data.documents[index]['detail0']),
                                  // Text(snapshot.data.documents[index]['detail1']),
                                  // Text(snapshot.data.documents[index]['detail2']),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })),
      ),
    );
  }
}
