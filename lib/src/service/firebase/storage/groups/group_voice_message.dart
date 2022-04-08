// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:isola_app/src/model/user/user_all.dart';

Future<void> uploadVoice(
    IsolaUserAll userAll,
    String _filePath,
    CollectionReference chatMessageRef,
    String targetUid1,
    String targetUid2,
    String targetUid3,
    String targetUid4,
    String targetUid5,
    bool isChaos) async {
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
      if (isChaos) {
        await voiceMessageAddToChaos(userAll, urlVoice, chatMessageRef,
            targetUid1, targetUid2, targetUid3, targetUid4, targetUid5);
      } else {
        await voiceMessageAdd(
            userAll, urlVoice, chatMessageRef, targetUid1, targetUid2);
      }
    }
  }
}

voiceMessageAdd(IsolaUserAll userAll, String voiceUrl, CollectionReference ref,
    String targetUid1, String targetUid2) {
  var docRef = ref.doc();
  docRef.set({
    'member_avatar_url': userAll.isolaUserDisplay.avatarUrl,
    'member_message': "",
    'member_message_time': DateTime.now().toUtc(),
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
    'member_message_no': docRef.id
  });
}

voiceMessageAddToChaos(
    IsolaUserAll userAll,
    String voiceUrl,
    CollectionReference ref,
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
    'member_message_isvoice': true,
    'member_message_voice_url': voiceUrl,
    'member_message_isattachment': false,
    'member_message_attachment_url': "",
    'member_message_isimage': false,
    'member_message_isvideo': false,
    'member_message_isdocument': false,
    'member_message_target_1_uid': targetUid1,
    'member_message_target_2_uid': targetUid2,
    'member_message_target_3_uid': targetUid3,
    'member_message_target_4_uid': targetUid4,
    'member_message_target_5_uid': targetUid5,
    'member_message_no': docRef.id
  });
}
