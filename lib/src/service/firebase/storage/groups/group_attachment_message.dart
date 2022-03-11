// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';


Future<void> uploadAttachment(
  IsolaUserAll userAll,
  //bu değişebilir

  String _filePath,
  DatabaseReference chatMessageRef,
  bool isImage,
  bool isVideo,
  bool isDoc,String targetUid1,String targetUid2

) async {
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
      await attachmentMessageAdd(userAll, urlVoice, chatMessageRef,isImage,isVideo,isDoc,targetUid1,targetUid2);
    }
  }

  //return urlImage;
}

attachmentMessageAdd(IsolaUserAll userAll, String attachmentUrl,
    DatabaseReference ref,  bool isImage, bool isVideo,bool isDoc,String targetUid1,String targetUid2) {
  var refChatInterior = ref;

  var firstMessage = HashMap<String, dynamic>();
  firstMessage["member_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
  firstMessage["member_message"] = "";
  firstMessage["member_message_time"] = ServerValue.timestamp;
  firstMessage["member_name"] = userAll.isolaUserDisplay.userName;
  firstMessage["member_uid"] = userAll.isolaUserMeta.userUid;
  firstMessage["member_message_isvoice"] = false;
  firstMessage["member_message_voice_url"] = "";
  firstMessage["member_message_isattachment"] = true;
  firstMessage["member_message_attachment_url"] = attachmentUrl;
  firstMessage["member_message_isimage"] = isImage;
    firstMessage["member_message_isvideo"] = isVideo;
      firstMessage["member_message_isdocument"] = isDoc;
          firstMessage["member_message_target_1_uid"]=targetUid1;
     firstMessage["member_message_target_2_uid"]=targetUid2;

  refChatInterior.push().set(firstMessage);

  // setState(() {
  //    AllMessageBalloon mesajNesnesi = AllMessageBalloon(isMe: true,theMessage: gelenMesaj);
  //    userMesajListesi.insert(0, mesajNesnesi);
  //   t1.clear();
  // });
}
