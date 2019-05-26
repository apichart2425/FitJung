import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:fitjung/utility/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'package:http/http.dart' as http;

class ProfileUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileUserState();
  }
}

class ProfileUserState extends State<ProfileUser> {
  QuerySnapshot info;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  var url =
      'https://cdn3.iconfinder.com/data/icons/map-and-location-fill/144/People_Location-512.png';
  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.loadLastLogin().then((value) {
      emailController.text = value;
      FirestoreUtils.getData(value).then((result) {
        setState(() {
          nameController.text = result.data['name'];
          surnameController.text = result.data['surname'];
          sexController.text = result.data['sex'];
          weightController.text = result.data['weight'];
          heightController.text = result.data['height'];
          bmiController.text = result.data['bmi'];
          getUrlImage();
        });
      });
    });
    // postRequest(weightController.text, heightController.text, ageContr);
  }

  getUrlImage() async {
    final ref = FirebaseStorage.instance.ref().child(emailController.text);
    var url = await ref.getDownloadURL();
    setState(() {
      this.url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              tooltip: "Edit",
              icon: Icon(
                Icons.edit,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            )
          ],
        ),
        body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Stack(
                    alignment: const Alignment(0.2, 0.7),
                    children: [
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(50.0),
                        child: Image.network(
                          url,
                          width: 350,
                          height: 300,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 250,
                            right: 0,
                            top: 150,
                            bottom: 0,
                          ),
                          // child: FloatingActionButton(
                          //   tooltip: 'Change image',
                          //   child: Icon(Icons.edit),
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ProfileScreen()),
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 700,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "Email : ${emailController.text}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "Name : ${nameController.text} ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "Surname : ${surnameController.text}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "Gender : ${sexController.text}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "Height : ${heightController.text}  Weight : ${weightController.text}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text("BMI : ${bmiController.text}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: ButtonTheme(
                  //         minWidth: 350.0,
                  //         height: 50.0,
                  //         child: RaisedButton(
                  //           child: Text("SAVE", style:
                  //             TextStyle(color: Colors.white)),
                  //           color: Colors.blueAccent,

                  //           shape: new RoundedRectangleBorder(
                  //               borderRadius: new BorderRadius.circular(15.0)),
                  //           onPressed: () {
                  //             FirestoreUtils.update(
                  //                 emailController.text,
                  //                 nameController.text,
                  //                 surnameController.text,
                  //                 weightController.text,
                  //                 heightController.text,
                  //                 _calBMI(double.parse(weightController.text),
                  //                     double.parse(heightController.text)));
                  //             setState(() {
                  //               bmiController.text = _calBMI(
                  //                   double.parse(weightController.text),
                  //                   double.parse(heightController.text));
                  //             });
                  //             Navigator.pushReplacementNamed(
                  //                 context, '/profile');
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(5.0),
                  //   child: ButtonTheme(
                  //     minWidth: 350.0,
                  //     height: 50.0,
                  //     child: RaisedButton(
                  //       child: Text(
                  //         "BACK",
                  //         style: TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.bold),
                  //       ),
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       color: Colors.white,
                  //       shape: new RoundedRectangleBorder(
                  //           borderRadius: new BorderRadius.circular(15.0)),
                  //     ),
                  //   ),
                  // ),
                  //   ],
                  // )
                ],
              ),
            )),
      ),
    );
  }
}

String _calBMI(double weight, double height) {
  height = height / 100;
  return (weight / pow(height, 2)).toStringAsFixed(2);
}

Future<http.Response> postRequest(String weight, String height, String age, String sex) async {
    var url =
        'https://bmi.p.rapidapi.com/';

    Map data = {
      'weight': {'value': weight, 'unit': 'kg'},
      'height': {'value': height, 'unit': 'cm'},
      'sex': 'm',
      'age': '24',
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          'X-RapidAPI-Host': 'bmi.p.rapidapi.com',
          'X-RapidAPI-Key': 'a5367c95edmsh93c43a9a99f221fp193dcejsnd9a7ccf34386',
          'Content-Type': 'application/json'
        },
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    final test = json.decode(response.body);
    print(test['weight']);
    return response;
  }