// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> joinToMatchingPool(
    String userUid, bool userSexType, bool userIsNonBinary, bool userIsValid) {
  CollectionReference matchingPool =
      FirebaseFirestore.instance.collection('matching_pool');
  // Call the user's CollectionReference to add a new user
  return matchingPool.doc(userUid).set({
    'uUid': userUid,
    'uSex': userSexType,
    'uNonBinary': userIsNonBinary,
    'uValid': userIsValid,
    'register_time': Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().toUtc().millisecondsSinceEpoch)
  });
}
