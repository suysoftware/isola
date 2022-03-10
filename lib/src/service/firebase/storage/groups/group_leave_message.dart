import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';

Future<void>groupLeaveMessage(GroupSettingModel groupSettingModel,DatabaseReference ref)async{


    var firstMessage = HashMap<String, dynamic>();
    firstMessage["member_avatar_url"] = "https://firebasestorage.googleapis.com/v0/b/isoladeneme.appspot.com/o/constant_files%2Fgroup_leave_icon.png?alt=media&token=ecb802a0-8972-465c-8777-c0a9576397d6";
    firstMessage["member_message"] = "${groupSettingModel.groupMemberName1} Leave From Chat";
    firstMessage["member_message_time"] = ServerValue.timestamp;
    firstMessage["member_name"] = "System Message";
    firstMessage["member_uid"] = groupSettingModel.userUid;
    firstMessage["member_message_isvoice"] = false;
    firstMessage["member_message_voice_url"] = "";
    firstMessage["member_message_isattachment"] = false;
    firstMessage["member_message_attachment_url"] = "isola_system_message";
    firstMessage["member_message_isimage"] = false;
    firstMessage["member_message_isvideo"] = false;
    firstMessage["member_message_isdocument"] = false;
    firstMessage["member_message_target_1_uid"] = groupSettingModel.groupMemberUid2;
    firstMessage["member_message_target_2_uid"] = groupSettingModel.groupMemberUid3;

    ref.push().set(firstMessage);

    

    // setState(() {
    //    AllMessageBalloon mesajNesnesi = AllMessageBalloon(isMe: true,theMessage: gelenMesaj);
    //    userMesajListesi.insert(0, mesajNesnesi);
    //   t1.clear();
    // });
 


}