import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreUtils {
  static void addProfile(String email, String name, String surname, String height, String weight, String sex, String bmi) {
    Firestore.instance
        .collection('profile')
        .document(email)
        .setData({'name': name, 'surname': surname, 'height': height, 'weight': weight, 'sex': sex, 'bmi': bmi});
  }
  static getData(String email) async {
    return Firestore.instance.collection('profile').document(email).get();
  }
}