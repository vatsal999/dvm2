import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dvm2/user_model.dart';

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
