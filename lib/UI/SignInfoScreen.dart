// กด SignUp แล้วจะเด้งมาหน้านี้ เพื่อกรอกข้อมูลเก็บลง FireStore
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitjung/UI/HomeScreen.dart';
import 'package:fitjung/UI/SigninScreen.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  int box_size = 550;
  int state_1 = 0,  state_3 = 0,  state_5 = 0;
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
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    void changedDropDownItem(String selectedSex) {
      //State
      setState(() {
        _currentSex = selectedSex;
      });
    }

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
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(box_size),
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
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0
                              ),
                            ],

                          ),
                          child: Padding(
                            padding: 
                              EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Info',
                                  style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6
                                  ),
                                ),
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
                            if (value.isEmpty){
                              if(state_1 < 1){
                                setState(() {
                                  box_size += 50; 
                                  state_1 ++;                      
                                });
                              }
                              return "Name is required";
                            }else{
                              if(state_1 == 1){
                                state_1--;
                                box_size -=50;
                              }
                            }
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
                            if (value.isEmpty) {
                              if(state_1 < 1){
                                setState(() {
                                  box_size += 50; 
                                  state_1++;                      
                                });
                              }
                              return "Surname is required";
                            }else{
                              if(state_1 == 1){
                                state_1--;
                                box_size -= 50;
                              }
                            }
                          }
                      ),
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
                            if (value.isEmpty) {
                              if(state_3 < 1){
                                setState(() {
                                  box_size += 50; 
                                  state_3++;                      
                                });
                              }
                              return "Height is required";
                            }else{
                              if(state_3 == 1){
                                state_3--;
                                box_size -= 50;
                              }
                            }
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
                            if (value.isEmpty) {
                              if(state_3 < 1){
                                setState(() {
                                  box_size += 50; 
                                  state_3++;                      
                                });
                              }
                              return "Weight is required";
                            }else{
                              if(state_3 == 1){
                                state_3--;
                                box_size -= 50;
                              }
                            }
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
                                if(state_5 < 1){
                                  setState(() {
                                  box_size += 50; 
                                  state_5++;                      
                                });
                                }
                                return "Please select gender";
                              }else{
                                if(state_5 == 1){
                                  box_size -= 50; 
                                  state_5--;   
                                }
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
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
                                          color: Colors.transparent.withOpacity(0.0),
                                        child: Text("Next", style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins-Bold',
                                          letterSpacing: 1.0,
                                          fontSize: 18.0
                                        ),),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _calBMI(double weight, double height){
  height = height/100;
  return (weight/pow(height, 2)).toStringAsFixed(2);
}
