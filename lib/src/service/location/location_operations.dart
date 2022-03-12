import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';

///GetLocation
//
//

Future<void> getLocation({required String uid}) async {
  await Geolocator.requestPermission();
  var konum = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);
  double enlem = konum.latitude;
  double boylam = konum.longitude;

  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users_display =
      FirebaseFirestore.instance.collection('users_location');

  await users_display.doc(_auth.currentUser!.uid).set({
    'uLoc': GeoPoint(konum.latitude, konum.longitude),
  });


}
