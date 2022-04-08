import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getLocation({required String uid}) async {
  await Geolocator.requestPermission();
  var konum = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);

  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference usersDisplay =
      FirebaseFirestore.instance.collection('users_location');

  await usersDisplay.doc(_auth.currentUser!.uid).set({
    'uLoc': GeoPoint(konum.latitude, konum.longitude),
  });
}
