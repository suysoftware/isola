// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveTokenToDatabase(String token) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance
      .collection('users_display')
      .doc(userId)
      .get()
      .then((value) {
    if (value.data() != null) {
      var targetUserDisplayData = value.data();

      var targetToken = targetUserDisplayData!['uDbToken'];
      if (token != targetToken) {
        FirebaseFirestore.instance
            .collection('users_display')
            .doc(userId)
            .update({
          'uDbToken': token,
        });
      }
    }
  });

  await FirebaseFirestore.instance
      .collection('users_display')
      .doc(userId)
      .update({'uDbToken': token});
}
