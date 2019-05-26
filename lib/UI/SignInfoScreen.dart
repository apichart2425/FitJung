// กด SignUp แล้วจะเด้งมาหน้านี้ เพื่อกรอกข้อมูลเก็บลง FireStore
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitjung/UI/HomeScreen.dart';
import 'package:fitjung/UI/SigninScreen.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:flutter/material.dart';

class SignInfoScreen extends StatefulWidget {
  final Map map;
  const SignInfoScreen({Key key, this.map}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignInfoScreenState();
  }
}

class SignInfoScreenState extends State<SignInfoScreen> {
  List _sex = ["GENDER", "Female", "Male"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSex;

  final _formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  // TextEditingController sexController = TextEditingController();

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentSex = _dropDownMenuItems[0].value;
    super.initState();
  }

  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sex in _sex) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: sex, child: new Text(sex)));
    }
    return items;
  }

  Widget build(BuildContext context) {
    void changedDropDownItem(String selectedSex) {
      //State
      setState(() {
        _currentSex = selectedSex;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Information"),
        ),
        body: SingleChildScrollView(
                  child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "Name"),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) return "Name is required";
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: surnameController,
                          decoration: InputDecoration(labelText: "Surname"),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) return "Surname is required";
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: heightController,
                          decoration: InputDecoration(labelText: "Height : cm."),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) return "Height is required";
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: weightController,
                          decoration: InputDecoration(labelText: "Weight : kg."),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) return "Weight is required";
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Row(
                  //for age sex
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _currentSex,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                        validator: ((value) {
                          if (value == "GENDER") {
                            return "Please select gender";
                          }
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    // Expanded(
                    //Date Picker
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("Next"),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            auth
                                .createUserWithEmailAndPassword(
                                    email: widget.map['email'],
                                    password: widget.map['password'])
                                .then((FirebaseUser user) {
                              user.sendEmailVerification().then((user) {
                                FirestoreUtils.addProfile(
                                    widget.map['email'],
                                    nameController.text,
                                    surnameController.text,
                                    heightController.text,
                                    weightController.text,
                                    _currentSex,
                                    _calBMI(double.parse(weightController.text), double.parse(heightController.text))
                                    );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninScreen()));
                              });
                              print("return from firebase  $user.email");
                            }).catchError((error) {
                              print("$error");
                            });
                          } else {
                            print("error");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

String _calBMI(double weight, double height){
  height = height/100;
  return (weight/pow(height, 2)).toStringAsFixed(2);
}