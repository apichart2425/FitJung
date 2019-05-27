import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:fitjung/utility/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ImageScreen.dart';
import 'ProfileUser.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController email = TextEditingController();

  QuerySnapshot info;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController img = TextEditingController();
  var url =
      'https://cdn3.iconfinder.com/data/icons/map-and-location-fill/144/People_Location-512.png';

  @override
  void initState() {
    super.initState();

    SharedPreferencesUtil.loadLastLogin().then((value) {
      FirestoreUtils.getData(value).then((result) {
        setState(() async {
          emailController.text = value;

          nameController.text = result.data['name'];
          surnameController.text = result.data['surname'];
          sexController.text = result.data['sex'];
          weightController.text = result.data['weight'];
          heightController.text = result.data['height'];
          ageController.text = result.data['age'];
          getUrlImage();
        });
      });
    });
    print('******************************************** ${this.url}');
  }

  getUrlImage() async {
    final ref = FirebaseStorage.instance.ref().child(emailController.text);
    var url = await ref.getDownloadURL();
    setState(() {
      this.url = url;
    });
  }

  File sampleImage = null;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: <Widget>[
          IconButton(
            tooltip: "Add Photo",
            icon: Icon(
              Icons.photo_library,
              size: 30,
            ),
            onPressed: () {
              getImage();
            },
          )
        ],
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
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(50.0),
                      child: sampleImage == null
                          ? Image.network(
                              url,
                              width: 350,
                              height: 300,
                            )
                          : enableUpload(),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          right: 0,
                          top: 150,
                          bottom: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  enabled: false,
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        size: 30,
                      ),
                      labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_box,
                          size: 30,
                        ),
                        labelText: "Name"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Name is required";
                    }),
                TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_box,
                          size: 30,
                        ),
                        labelText: "Surname"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Surname is required";
                    }),
                TextField(
                  enabled: false,
                  controller: sexController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_box,
                        size: 30,
                      ),
                      labelText: "Gender"),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_box,
                          size: 30,
                        ),
                        labelText: "Weight"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Weight is required";
                    }),
                TextFormField(
                    controller: heightController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_box,
                          size: 30,
                        ),
                        labelText: "Height"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Height  is required";
                    }),
                TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_box,
                          size: 30,
                        ),
                        labelText: "Age"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) return "Age  is required";
                    }),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonTheme(
                        minWidth: 300.0,
                        height: 50.0,
                        child: RaisedButton(
                          child: Text("SAVE",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blueAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () async {
                            print(' Save --------------');
                            final StorageReference firebaseStorageRef =
                                FirebaseStorage.instance
                                    .ref()
                                    .child(this.emailController.text);
                            final StorageUploadTask task =
                                firebaseStorageRef.putFile(sampleImage);
                            print(await (await task.onComplete)
                                .ref
                                .getDownloadURL());
                            // print(emailController.text);
                            // print(' Save2 --------------');

                            // print(await task.onComplete);
                            //     .ref
                            //     .getDownloadURL());
                            // if (task.isComplete) {
                            //   Toast.show("UPLOAD complete", context);
                            //   Navigator.pushReplacementNamed(
                            //       context, '/profile');
                            // }
                            FirestoreUtils.update(
                                emailController.text,
                                nameController.text,
                                surnameController.text,
                                weightController.text,
                                heightController.text,
                                ageController.text);

                            print('Update !!!!!');

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProfileUser()),
                            // );

                            // Navigator.pop(context);

                            Navigator.pushReplacementNamed(
                                context, '/profileuser');

                            // Navigator.pushNamed(context, '/profileuser');
                          },
                        ),
                      ),
                    ),
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
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300, width: 300),

          // Toast.show("UPLOAD complete", context);
          // Navigator.pushReplacementNamed(context, '/profile');
        ],
      ),
    );
  }
}
