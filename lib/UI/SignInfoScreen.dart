// กด SignUp แล้วจะเด้งมาหน้านี้ เพื่อกรอกข้อมูลเก็บลง FireStore
import 'package:flutter/material.dart';

class SignInfoScreen extends StatefulWidget {
  final Map map;
  const SignInfoScreen({Key key, this.map}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignInfoScreenState();
  }
}

class SignInfoScreenState extends State<SignInfoScreen> {

  List _sex = ["SEX", "Female", "Male"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSex;

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
        body: Center(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Expanded(
                  child: TextFormField(
                      // controller: emailController,
                      decoration: InputDecoration(labelText: "Name"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email is required";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Expanded(
                  child: TextFormField(
                      // controller: emailController,
                      decoration: InputDecoration(labelText: "Surname"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email is required";
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
                      // controller: emailController,
                      decoration: InputDecoration(labelText: "Height"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email is required";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Expanded(
                  child: TextFormField(
                      // controller: emailController,
                      decoration: InputDecoration(labelText: "Weight"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email is required";
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
                  child: DropdownButton(
                    value: _currentSex,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
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
            )
          ],
        )));
  }
}
