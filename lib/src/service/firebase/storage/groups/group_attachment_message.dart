// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:isola_app/src/model/user/user_all.dart';

Future<void> uploadAttachment(
    IsolaUserAll userAll,
    //bu değişebilir

    String _filePath,
    CollectionReference chatMessageRef,
    bool isImage,
    bool isVideo,
    bool isDoc,
    String targetUid1,
    String targetUid2) async {
  String urlVoice = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("attachment_items")
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
      await attachmentMessageAdd(userAll, urlVoice, chatMessageRef, isImage,
          isVideo, isDoc, targetUid1, targetUid2);
    }
  }

  //return urlImage;
}

attachmentMessageAdd(
    IsolaUserAll userAll,
    String attachmentUrl,
    CollectionReference ref,
    bool isImage,
    bool isVideo,
    bool isDoc,
    String targetUid1,
    String targetUid2) {
 
   var docRef = ref.doc();
  docRef.set({
    'member_avatar_url': userAll.isolaUserDisplay.avatarUrl,
    'member_message': "",
    'member_message_time': DateTime.now().toUtc(),
    'member_name': userAll.isolaUserDisplay.userName,
    'member_uid': userAll.isolaUserMeta.userUid,
    'member_message_isvoice': false,
    'member_message_voice_url': "",
    'member_message_isattachment': true,
    'member_message_attachment_url': attachmentUrl,
    'member_message_isimage': isImage,
    'member_message_isvideo': isVideo,
    'member_message_isdocument': isDoc,
    'member_message_target_1_uid': targetUid1,
    'member_message_target_2_uid': targetUid2,
    'member_message_no': docRef.id
  });
}

Future<void> uploadAttachmentToChaos(
    IsolaUserAll userAll,
    //bu değişebilir

    String _filePath,
    CollectionReference chatMessageRef,
    bool isImage,
    bool isVideo,
    bool isDoc,
    String targetUid1,
    String targetUid2,
    String targetUid3,
    String targetUid4,
    String targetUid5) async {
  String urlVoice = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("attachment_items")
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
      await attachmentMessageAddToChaos(
          userAll,
          urlVoice,
          chatMessageRef,
          isImage,
          isVideo,
          isDoc,
          targetUid1,
          targetUid2,
          targetUid3,
          targetUid4,
          targetUid5);
    }
  }

  //return urlImage;
}

attachmentMessageAddToChaos(
    IsolaUserAll userAll,
    String attachmentUrl,
    CollectionReference ref,
    bool isImage,
    bool isVideo,
    bool isDoc,
    String targetUid1,
    String targetUid2,
    String targetUid3,
    String targetUid4,
    String targetUid5) {
  var docRef = ref.doc();
  docRef.set({
    'member_avatar_url': userAll.isolaUserDisplay.avatarUrl,
    'member_message': "",
    'member_message_time': DateTime.now().toUtc(),
    'member_name': userAll.isolaUserDisplay.userName,
    'member_uid': userAll.isolaUserMeta.userUid,
    'member_message_isvoice': false,
    'member_message_voice_url': "",
    'member_message_isattachment': true,
    'member_message_attachment_url': attachmentUrl,
    'member_message_isimage': isImage,
    'member_message_isvideo': isVideo,
    'member_message_isdocument': isDoc,
    'member_message_target_1_uid': targetUid1,
    'member_message_target_2_uid': targetUid2,
    'member_message_target_3_uid': targetUid3,
    'member_message_target_4_uid': targetUid4,
    'member_message_target_5_uid': targetUid5,
    'member_message_no': docRef.id
  });
}
