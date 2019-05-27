import 'package:flutter/material.dart';
import '../utility/firestore_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import '../utility/share.dart';

class Article extends StatefulWidget {
  int _id;
  Article(this._id, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ArticleState();
  }
}

class _ArticleState extends State<Article> {
  String titlename;
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
              "Article",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('article').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                          snapshot.data.documents[widget._id]
                                              ['title'],
                                          style: TextStyle(
                                              color: Color(0xff1f1f2b),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                    ),
                                    Image.network(
                                      snapshot.data.documents[widget._id]
                                          ['imgblog'],
                                      width: 250,
                                      height: 250,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(
                                          '${snapshot.data.documents[widget._id]['detail0']}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(snapshot.data.documents[index]
                                          ['detail1']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(snapshot.data.documents[index]
                                          ['detail2']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(snapshot.data.documents[index]
                                          ['detail3']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Text(snapshot.data.documents[index]
                                          ['detail4']),
                                    ),
                                  ],
                                ),
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
