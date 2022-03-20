// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:isola_app/src/model/user/user_all.dart';



Future<void> uploadVoice(
  IsolaUserAll userAll,
  //bu değişebilir

  String _filePath,
  CollectionReference chatMessageRef,
  String targetUid1,
  String targetUid2,

) async {
  String urlVoice = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("voice_items")
      .child(userAll.isolaUserMeta.userUid)
      .child(DateTime.now().millisecondsSinceEpoch.toString());

  try {
    UploadTask uploadTask = refStorage.putFile(File(_filePath));
    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then((value) => urlVoice = value);
  } catch (e) {
    print("agaa $e");
  } finally {
    if (urlVoice != "") {
      await voiceMessageAdd(userAll, urlVoice, chatMessageRef,targetUid1,targetUid2);
    }
  }

  //return urlImage;
}

voiceMessageAdd(
    IsolaUserAll userAll, String voiceUrl, CollectionReference ref,String targetUid1,String targetUid2) {


  ref.doc().set({
    'member_avatar_url': userAll.isolaUserDisplay.avatarUrl,
    'member_message': "",
    'member_message_time': ServerValue.timestamp,
    'member_name': userAll.isolaUserDisplay.userName,
    'member_uid': userAll.isolaUserMeta.userUid,
    'member_message_isvoice': true,
    'member_message_voice_url': voiceUrl,
    'member_message_isattachment': false,
    'member_message_attachment_url': "",
    'member_message_isimage': false,
    'member_message_isvideo': false,
    'member_message_isdocument': false,
    'member_message_target_1_uid': targetUid1,
    'member_message_target_2_uid': targetUid2,
  });


  
}
