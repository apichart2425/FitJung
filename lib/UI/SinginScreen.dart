import 'package:flutter/material.dart';
import './SingupScreen.dart';
import './HomeScreen.dart';

class SinginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SinginScreenState();
  }
}

class SinginScreenState extends State<SinginScreen> {
  final _formKey = GlobalKey<FormState>();

  // FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        // padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Icon()crossAxisAlignment: CrossAxisAlignment.center,

              Image.asset(
                "resource/cat_eating.jpg",
                height: 200,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email is required";
                  }
                },
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password is required";
                  }
                },
              ),
              ButtonTheme(
                minWidth: 300,
                child: RaisedButton(
                    color: Colors.grey.shade300,
                    child: Text("LOGIN"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
                              builder: (context) => SingUpScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "Register New Account",
                      ),
                    ),
                    textColor: Colors.teal.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
