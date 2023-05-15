import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dvm2/user_model.dart';
import 'package:dvm2/screens/home.dart';
import 'dart:async';

Future createUser({required User user}) async {
  final docUser = FirebaseFirestore.instance
      .collection('FriendUsers')
      .doc(user.id.toString());
  final json = user.toJson();
  await docUser.set(json);
}

Stream<List<User>> readUsers() =>
    FirebaseFirestore.instance.collection('FriendUsers').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => User.fromJson(doc.data())).toList(),
        );

Future deleteUser({required User user}) async {
  final docUser = FirebaseFirestore.instance
      .collection('FriendUsers')
      .doc(user.id.toString());
  await docUser.delete();
}

checkWithFirebaseIfFriend(int user_id) async {
  var document = await FirebaseFirestore.instance
      .collection('FriendUsers')
      .doc(user_id.toString())
      .get();
  if (document.exists) {
    return true;
  } else
    return false;
}

getFriendUsersIds() async {
  List<int> temp = [];
  QuerySnapshot mysnapshot =
      await FirebaseFirestore.instance.collection('FriendUsers').get();
  for (int i = 0; i < mysnapshot.size; i++) {
    temp.add(int.parse(mysnapshot.docs[i].id));
  }
  return temp;
}
