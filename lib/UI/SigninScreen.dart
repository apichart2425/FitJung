import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitjung/UI/ImageScreen.dart';
import 'package:fitjung/UI/SignupScreen.dart';
import 'package:fitjung/utility/share.dart';
import 'package:flutter/material.dart';
import './HomeScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    SharedPreferencesUtil.loadLastLogin().then((onValue){
      print(onValue);
    });
    getUrlImage();
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
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    getUrlImage();
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Image.asset('resource/6272.jpg'),
          ),
          Expanded(
            child: Container(

            ),
            
          ),
          Image.asset('resource/img_02.png'),
          ],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset('resource/logo.png',
                      width: ScreenUtil.getInstance().setWidth(110),
                      height: ScreenUtil.getInstance().setHeight(110),
                    ),
                    Text("FITJUNG", style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: ScreenUtil.getInstance().setSp(46),
                      letterSpacing: .6,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(180),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                  children: <Widget>[

                  ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 15.0
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: 
                    EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Login',
                          style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(45),
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .6
                          ),
                        ),
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
                              
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(30),

                        ),
                      ],
                    ),
                  ),
                  
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                ButtonTheme(
                minWidth: 300,

                child: RaisedButton(
                    color: Colors.lightBlue,
                    child: Text("LOGIN"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        auth
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text)
                            .then((user) {
                          if (user.isEmailVerified) {
                            SharedPreferencesUtil.saveLastLogin(email.text);
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
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
