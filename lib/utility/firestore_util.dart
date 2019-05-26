import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreUtils {
  static void addProfile(String email, String name, String surname,
      String height, String weight, String sex, String bmi) {
    Firestore.instance.collection('profile').document(email).setData({
      'name': name,
      'surname': surname,
      'height': height,
      'weight': weight,
      'sex': sex,
      'bmi': bmi
    });
  }

  static getData(String email) async {
    return Firestore.instance.collection('profile').document(email).get();
  }

  static void update(String email, String name, String surname, String weight, String height, String bmi) {
    final DocumentReference postRef = Firestore.instance.document('profile/' + email);

    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'name': name});
        await tx.update(postRef, <String, dynamic>{'surname': surname});
        await tx.update(postRef, <String, dynamic>{'weight': weight});
        await tx.update(postRef, <String, dynamic>{'height': height});
        await tx.update(postRef, <String, dynamic>{'bmi': bmi});
      }
    });
  }
}
