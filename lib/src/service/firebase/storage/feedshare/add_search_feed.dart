import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(
  String userUid,
  File image,
  String feedNo,
) async {
  String urlImage = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("search_items")
      .child(userUid)
      .child(feedNo);

  UploadTask uploadTask = refStorage.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask;
  await taskSnapshot.ref.getDownloadURL().then((value) => urlImage = value);

  return urlImage;
}

Future<String> uploadImageForProfile(
  String userUid,
  File image,
) async {
  String urlImage = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("profile_items")
      .child(userUid)
      .child('profilePhoto');

  //.writeToFile(image);

  // .child(feedNo)
  // .child('profilePhoto');

  UploadTask uploadTask = refStorage.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask;

  await taskSnapshot.ref.getDownloadURL().then((value) => urlImage = value);

  return urlImage;
}
