import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreUtils {
  static void addProfile(String email, String name, String surname,
      String height, String weight, String sex, String age) {
    Firestore.instance.collection('profile').document(email).setData({
      'name': name,
      'surname': surname,
      'height': height,
      'weight': weight,
      'sex': sex,
      'age': age,
    });
  }

  static getData(String email) async {
    return Firestore.instance.collection('profile').document(email).get();
  }

  static getType(String type, String mode) async{
    return Firestore.instance.collection('workout').document(type).collection(mode).snapshots();
  } 
  static getArticle(String id,String detail) async{
    return Firestore.instance.collection('article').document(id).collection(detail).getDocuments();
  }
  static void update(String email, String name, String surname, String weight, String height, String age) {
    final DocumentReference postRef = Firestore.instance.document('profile/' + email);

    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'name': name});
        await tx.update(postRef, <String, dynamic>{'surname': surname});
        await tx.update(postRef, <String, dynamic>{'weight': weight});
        await tx.update(postRef, <String, dynamic>{'height': height});
        await tx.update(postRef, <String, dynamic>{'age': age});
      }
    });
  }
}
