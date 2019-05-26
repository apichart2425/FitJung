import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitjung/UI/ImageScreen.dart';
import 'package:fitjung/UI/SignupScreen.dart';
import 'package:flutter/material.dart';
import './HomeScreen.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SigninScreenState();
  }
}

class SigninScreenState extends State<SigninScreen> {
  var url;
  @override
  void initState() {
    super.initState();
    getUrlImage();
    print(this.url);
  }

  getUrlImage() async {
    final ref = FirebaseStorage.instance.ref().child('myimage.jpg');
    var url = await ref.getDownloadURL();
    setState(() {
     this.url = url; 
    });
  }

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    getUrlImage();
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Icon()crossAxisAlignment: CrossAxisAlignment.center,
              // Image.asset(
              //   "resource/cat_eating.jpg",
              //   height: 200,
              // ),
              this.url == null
                  ? Image.asset(
                      "resource/cat_eating.jpg",
                      height: 200,
                    )
                  : Image.network(this.url,
                      height: 200,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 0, bottom: 0, right: 40),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter Valid Email';
                    }
                    if (value.isEmpty) {
                      return "Email is required";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 0, bottom: 0, right: 40),
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password is required";
                    }
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 300,
                child: RaisedButton(
                    color: Colors.grey.shade300,
                    child: Text("LOGIN"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        auth
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text)
                            .then((user) {
                          if (user.isEmailVerified) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        }).catchError((error) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("ERROR"),
                                  content: Text(error.toString()),
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
                        });
                      }
                    }),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, bottom: 0, right: 30),
                      child: Text(
                        "Register New Account",
                      ),
                    ),
                    textColor: Colors.teal.shade500,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, bottom: 0, right: 30),
                      child: Text(
                        "IMAGE",
                      ),
                    ),
                    textColor: Colors.teal.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
