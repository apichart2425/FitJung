import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<TestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postRequest();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("TEST"),
    );
  }

  Future<http.Response> postRequest() async {
    var url =
        'https://bmi.p.rapidapi.com/';

    Map data = {
      'weight': {'value': '85.00', 'unit': 'kg'},
      'height': {'value': '170.00', 'unit': 'cm'},
      'sex': 'm',
      'age': '24',
      'waist': '34.00',
      'hip': '40.00'
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          'X-RapidAPI-Host': 'bmi.p.rapidapi.com',
          'X-RapidAPI-Key': 'a5367c95edmsh93c43a9a99f221fp193dcejsnd9a7ccf34386',
          'Content-Type': 'application/json'
        },
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    final test = json.decode(response.body);
    print(test['weight']);
    
    return response;
  }
}
