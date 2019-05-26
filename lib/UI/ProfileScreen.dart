import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:fitjung/utility/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  QuerySnapshot info;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  void initState() {
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
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: const Alignment(0.2, 0.7),
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('resource/cat_eating.jpg'),
                      radius: 100,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          right: 0,
                          top: 150,
                          bottom: 0,
                        ),
                        child: FloatingActionButton(
                          tooltip: 'Change image',
                          child: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  enabled: false,
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Name is required";
                    }),
                TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(labelText: "Surname"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Surname is required";
                    }),
                TextField(
                  enabled: false,
                  controller: sexController,
                  decoration: InputDecoration(labelText: "Gender"),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(labelText: "Weight"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Weight is required";
                    }),
                TextFormField(
                    controller: heightController,
                    decoration: InputDecoration(labelText: "Height"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Height  is required";
                    }),
                TextField(
                  enabled: false,
                  controller: bmiController,
                  decoration: InputDecoration(labelText: "BMI"),
                  keyboardType: TextInputType.text,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("SAVE"),
                        onPressed: () {
                          FirestoreUtils.update(emailController.text, nameController.text, surnameController.text, weightController.text, heightController.text, _calBMI(double.parse(weightController.text), double.parse(heightController.text)));
                          setState(() {
                           bmiController.text = _calBMI(double.parse(weightController.text), double.parse(heightController.text)) ;
                          });
                          Navigator.pushReplacementNamed(context, '/profile');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("BACK"),
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

String _calBMI(double weight, double height) {
  height = height / 100;
  return (weight / pow(height, 2)).toStringAsFixed(2);
}
