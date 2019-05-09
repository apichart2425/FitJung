import 'package:fitjung/UI/SignInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value)){
                      return 'Enter Valid Email';
                    }
                    if (value.isEmpty) {
                      return "Email is required";
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Password is required";
                    }
                    // if (value != rePasswordController){
                    //   return 'Passwrod is not matching';
                    // }
                    if (value.length < 8){
                      return "Password length must more than equal 8";
                    }
                  },
                ),
                TextFormField(
                  controller: rePasswordController,
                  decoration: InputDecoration(labelText: "Re-Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Re-Password is required";
                    }
                    if (value.length < 8){
                      return "Password length must more than equal 8";
                    }
                    if (value != passwordController.text){
                      return 'Re-Passwrod is not matching';
                    }
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("Next"),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            Map map = {
                              'email': emailController.text,
                              'password': passwordController.text
                            };
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInfoScreen(map: map)));
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
        ),
      ),
    );
  }
}
