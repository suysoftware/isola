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

  var refUserMeta = refGetter(
      enum2: RefEnum.Usermeta, targetUid: uid, userUid: uid, crypto: "");

  await refUserMeta.child("user_loc_latitude").set(enlem);
  await refUserMeta.child("user_loc_longitude").set(boylam);

  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users_display =
      FirebaseFirestore.instance.collection('users_display');

  users_display.doc(_auth.currentUser!.uid).update({
    'user_loc_latitude': enlem,
    'user_loc_longitude': boylam,
  });

  //var userModal = UserModel(boylam, enlem, name, "d", uid);
  //return userModal;
}
//
//
///

///CHECK LOCATION DISTANCE
//
//

/*
bool checkLocationDis(double startLat, double startLong, double endLat,
    double endLong, String title, ServerSettings serverSettings) {
  if (title == "Admin") {
    return true;
  } else {
    double distanceInMeters =
        Geolocator.distanceBetween(startLat, startLong, endLat, endLong);

    if (title == "Master") {
      if (distanceInMeters <= serverSettings.masterDistance) {
        return true;
      } else {
        return false;
      }
    } else {
      if (distanceInMeters <= serverSettings.juniorDistance) {
        return true;
      } else {
        return false;
      }
    }
  }
}
*/
//
//
///