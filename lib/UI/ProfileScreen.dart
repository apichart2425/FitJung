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
  void initState() {
    SharedPreferencesUtil.loadLastLogin().then((value) {
      emailController.text = value;
      FirestoreUtils.getData(value).then((result) {
        nameController.text = result.data['name'];
        surnameController.text = result.data['surname'];
        sexController.text = result.data['sex'];
        weightController.text = result.data['weight'];
        heightController.text = result.data['height'];
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
                Container(
                  child: Image.asset('resource/cat_eating.jpg'),
                ),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) return "Email is required";
                    }),
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
                TextFormField(
                    controller: sexController,
                    decoration: InputDecoration(labelText: "Gender"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Gender is required";
                    }),
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
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("SAVE"),
                        onPressed: (){},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("BACK"),
                        onPressed: () {},
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
