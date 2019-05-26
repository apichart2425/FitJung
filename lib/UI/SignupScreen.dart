import 'package:fitjung/UI/SignInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  int size_box = 500;
  int state_1 = 0, state_2 = 0, state_3 = 0;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
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
                      Image.asset(
                        'resource/logo.png',
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text(
                        "FITJUNG",
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: ScreenUtil.getInstance().setSp(46),
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(size_box),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 10.0),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: emailController,
                                  decoration:
                                      InputDecoration(labelText: "Email"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      setState(() {
                                        if(state_1 < 1){
                                          size_box+=50;
                                          state_1++;
                                        }
                                      });
                                      return 'Enter Valid Email';
                                      
                                    }else{
                                      if(state_1 == 1){
                                        size_box -= 50;
                                        state_1--;
                                      }
                                    }
                                    if (value.isEmpty) {
                                      setState(() {
                                        if(state_1 < 1){
                                          size_box+=50;
                                          state_1++;
                                        }
                                      });
                                      return "Email is required";
                                    }else{
                                      if(state_1 == 1){
                                        size_box -= 50;
                                        state_1--;
                                      }
                                    }
                                  },
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  decoration:
                                      InputDecoration(labelText: "Password"),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        if(state_2 < 1){
                                          size_box+=50;
                                          state_2++;
                                        }
                                      });
                                      return "Password is required";
                                    }else{
                                      if(state_2 == 1){
                                        size_box -= 50;
                                        state_2--;
                                      }
                                    }
                                    // if (value != rePasswordController){
                                    //   return 'Passwrod is not matching';
                                    // }
                                    if (value.length < 8) {
                                      setState(() {
                                        if(state_2 < 1){
                                          size_box+=50;
                                          state_2++;
                                        }
                                      });
                                      return "Password length must more than equal 8";
                                    }else{
                                      if(state_2 == 1){
                                        size_box -= 50;
                                        state_2--;
                                      }
                                    }
                                  },
                                ),
                                TextFormField(
                                  controller: rePasswordController,
                                  decoration:
                                      InputDecoration(labelText: "Re-Password"),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        if(state_3 < 1){
                                          size_box+=50;
                                          state_3++;
                                        }
                                      });
                                      return "Re-Password is required";
                                    }else{
                                      if(state_3 == 1){
                                        size_box -= 50;
                                        state_3--;
                                      }
                                    }
                                    if (value.length < 8) {
                                      setState(() {
                                        if(state_3 < 1){
                                          size_box+=50;
                                          state_3++;
                                        }
                                      });
                                      return "Password length must more than equal 8";
                                    }else {
                                      if(state_3 == 1){
                                        size_box -= 50;
                                        state_3--;
                                      }
                                    }
                                    if (value != passwordController.text) {
                                      setState(() {
                                        if(state_3 < 1){
                                          size_box+=50;
                                          state_3++;
                                        }
                                      });
                                      return 'Re-Passwrod is not matching';
                                    }else{
                                      if(state_3 == 1){
                                        size_box -= 50;
                                        state_3--;
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 300,
                              child: InkWell(
                                  child: Container(
                                width: ScreenUtil.getInstance().setWidth(330),
                                height: ScreenUtil.getInstance().setHeight(100),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF85627c),
                                      Color(0xFF0949a5)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      child: Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: RaisedButton(
                                          color: Colors.transparent
                                              .withOpacity(0.0),
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins-Bold',
                                                letterSpacing: 1.0,
                                                fontSize: 18.0),
                                          ),
                                          onPressed: () {
                                            if (_formkey.currentState
                                                .validate()) {
                                              Map map = {
                                                'email': emailController.text,
                                                'password':
                                                    passwordController.text
                                              };
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignInfoScreen(
                                                              map: map)));
                                            } else {
                                              print("error");
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// SingleChildScrollView(
//               child: Padding(
//           padding: EdgeInsets.all(18),
//           child: Form(
//             key: _formkey,
//             child: Column(
//               children: <Widget>[

//               ],
//             ),
//           ),
//         ),
//       )
