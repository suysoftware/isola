// ignore_for_file: avoid_print
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_display.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:uuid/uuid.dart';
/*
Future<List<dynamic>> findGroup(IsolaUserAll userAll) async {
  var userNewGroupListReturn = <dynamic>[];

  var groupNeedListNothing = <dynamic>[];
  groupNeedListNothing.add("nothing");
  var refGroupDisplay = refGetter(
      enum2: RefEnum.Groupdisplay, targetUid: "", userUid: "", crypto: "");

  Stream<DatabaseEvent> stream = refGroupDisplay.onValue;
  final subscription = stream.listen((DatabaseEvent event) {
    var groupDisplayList = <GroupDisplay>[];

    var gettingGroupDisplay = event.snapshot.value as Map;
    gettingGroupDisplay.forEach((key, value) async {
      var comingGroup = GroupDisplay.fromJson(value);
      if (comingGroup.group_need_member == true &&
          comingGroup.group_member_value < 3 &&
          userAll.isolaUserMeta.joinedGroupList
                  .contains(comingGroup.group_no) ==
              false) {
        //bu if üstüne cinsiyet seçeneğini alıp sorgulanacak
        //group validliği sorgulanacak

        var displayItem = GroupDisplay(
            comingGroup.group_member_value,
            comingGroup.group_need_member,
            comingGroup.group_no,
            comingGroup.group_sex_type,
            comingGroup.group_target_isvalid,
            comingGroup.group_need_list);

        groupDisplayList.add(displayItem);
      }
    });
    if (groupDisplayList.isEmpty) {
      String fileID = const Uuid().v4();
      var refGroupMeta = refGetter(
          enum2: RefEnum.Groupmeta, targetUid: "", userUid: "", crypto: "");
      var refGroupChatMembers = refGetter(
          enum2: RefEnum.Groupchatmembers,
          targetUid: "",
          userUid: "",
          crypto: fileID);
      var refUserMetaJoined = refGetter(
          enum2: RefEnum.Usermetagrouplist,
          targetUid: userAll.isolaUserMeta.userUid,
          userUid: userAll.isolaUserMeta.userUid,
          crypto: "");

      print("grup kurmak gerek");

      //create group

      var groupNeedList = <dynamic>[];
      groupNeedList.add("group_member_2_uid");
      groupNeedList.add("group_member_3_uid");

      var addGroupDisplay = HashMap<String, dynamic>();

      addGroupDisplay["group_member_value"] = 1;
      addGroupDisplay["group_need_member"] = true;
      addGroupDisplay["group_no"] = fileID;
      addGroupDisplay["group_sex_type"] =
          userAll.isolaUserDisplay.userSex.toString();
      addGroupDisplay["group_target_isvalid"] =
          userAll.isolaUserMeta.userIsValid;
      addGroupDisplay["group_need_list"] = groupNeedList;

      //var addGroupMeta = HashMap<String, dynamic>();
      // addGroupMeta["group_member_1_uid"] = userDisplay.userUid;
      Future.delayed(const Duration(seconds: 6), () {
        refGroupDisplay.child(fileID).set(addGroupDisplay);
        refGroupMeta
            .child(fileID)
            .child("group_member_1_uid")
            .set(userAll.isolaUserMeta.userUid);
        refGroupMeta.child(fileID).child("group_token").set(0);
        refGroupChatMembers
            .child("group_member_1_uid")
            .set(userAll.isolaUserMeta.userUid);
        //   var userNewGroupList = <dynamic>[];
        if (userAll.isolaUserMeta.joinedGroupList.length == 1 &&
            userAll.isolaUserMeta.joinedGroupList[0] == "nothing") {
          userNewGroupListReturn.add(fileID);
          refUserMetaJoined.set(userNewGroupListReturn);
        } else {
          userNewGroupListReturn.addAll(userAll.isolaUserMeta.joinedGroupList);
          userNewGroupListReturn.add(fileID);
          refUserMetaJoined.set(userNewGroupListReturn);
        }
        var refGroupChatListCreated = refGetter(
            enum2: RefEnum.Groupchatlist,
            targetUid: "",
            userUid: "",
            crypto: fileID);
        var firstMessage = HashMap<String, dynamic>();
        firstMessage["member_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
        firstMessage["member_message"] = "Hello Everyone";
        firstMessage["member_message_time"] = ServerValue.timestamp;
        firstMessage["member_name"] = userAll.isolaUserDisplay.userName;
        firstMessage["member_uid"] = userAll.isolaUserMeta.userUid;
        firstMessage["member_message_isvoice"] = false;
        firstMessage["member_message_voice_url"] = "nothing";
        firstMessage["member_message_isattachment"] = false;
        firstMessage["member_message_attachment_url"] = "";
        firstMessage["member_message_isimage"] = false;
        firstMessage["member_message_isvideo"] = false;
        firstMessage["member_message_isdocument"] = false;
        firstMessage["member_message_target_1_uid"] = "firstmessage";
        firstMessage["member_message_target_2_uid"] = "firstmessage";

        refGroupChatListCreated.push().set(firstMessage);

//groups_chaos
        var refGroupChaosCreated = refGetter(
            enum2: RefEnum.Groupschaos,
            targetUid: "",
            userUid: "",
            crypto: fileID);

        var addGroupChaos = HashMap<String, dynamic>();
        addGroupChaos["chaos_no"] = "";
        addGroupChaos["chaos_is_alive"] = false;
        addGroupChaos["last_chaos_time"] = 0;
        addGroupChaos["member_1_apply"] = false;
        addGroupChaos["member_2_apply"] = false;
        addGroupChaos["member_3_apply"] = false;
        addGroupChaos["chaos_sex_option"] = userAll.isolaUserMeta.userIsValid;
        addGroupChaos["chaos_is_non_binary"] =
            userAll.isolaUserDisplay.userIsNonBinary;
        addGroupChaos["chaos_is_valid"] = userAll.isolaUserMeta.userIsValid;
        addGroupChaos["chaos_is_canceled"] = false;
        addGroupChaos["chaos_is_searching"] = false;

        refGroupChaosCreated.set(addGroupChaos);
      });
    } else {
      var targetGroup = groupDisplayList.first;

      var refGroupMeta = refGetter(
          enum2: RefEnum.Groupmeta, targetUid: "", userUid: "", crypto: "");
      var refGroupChatMembers = refGetter(
          enum2: RefEnum.Groupchatmembers,
          targetUid: "",
          userUid: "",
          crypto: targetGroup.group_no);
      var refUserMetaJoined = refGetter(
          enum2: RefEnum.Usermetagrouplist,
          targetUid: userAll.isolaUserMeta.userUid,
          userUid: userAll.isolaUserMeta.userUid,
          crypto: "");

      Future.delayed(const Duration(seconds: 6), () {
        //buna şart koncak bir yada 1 artır gibi

        //buraya if koy eğer grup dolarsa false yapsın
        if (targetGroup.group_member_value == 2) {
          refGroupDisplay
              .child(targetGroup.group_no)
              .child("group_need_member")
              .set(false);

          refGroupDisplay
              .child(targetGroup.group_no)
              .child("group_need_list")
              .set(groupNeedListNothing);

          refGroupDisplay
              .child(targetGroup.group_no)
              .child("group_member_value")
              .set((targetGroup.group_member_value) + 1);
        } else {
          var groupNeedListDeleteMyLine = <dynamic>[];

          groupNeedListDeleteMyLine.addAll(targetGroup.group_need_list);

          groupNeedListDeleteMyLine.remove(targetGroup.group_need_list.first);

          refGroupDisplay
              .child(targetGroup.group_no)
              .child("group_need_list")
              .set(groupNeedListDeleteMyLine);

          refGroupDisplay
              .child(targetGroup.group_no)
              .child("group_member_value")
              .set((targetGroup.group_member_value) + 1);
        }

//grup member sayısına göre uid yerini belirle

        refGroupMeta //burayabak
            .child(targetGroup.group_no)
            .child(
                "${targetGroup.group_need_list.first}") //burada hangisi onu bul
            .set(userAll.isolaUserMeta.userUid);

//bundada sıraya göre ekleme yap
        refGroupChatMembers
            .child("${targetGroup.group_need_list.first}")
            .set(userAll.isolaUserMeta.userUid);

        //  var userNewGroupList = <dynamic>[];
        if (userAll.isolaUserMeta.joinedGroupList.length == 1 &&
            userAll.isolaUserMeta.joinedGroupList[0] == "nothing") {
          userNewGroupListReturn.add(targetGroup.group_no);
          refUserMetaJoined.set(userNewGroupListReturn);
        } else {
          userNewGroupListReturn.addAll(userAll.isolaUserMeta.joinedGroupList);
          userNewGroupListReturn.add(targetGroup.group_no);
          refUserMetaJoined.set(userNewGroupListReturn);
        }

        var refGroupChatListCreated = refGetter(
            enum2: RefEnum.Groupchatlist,
            targetUid: "",
            userUid: "",
            crypto: targetGroup.group_no);
        var firstMessage = HashMap<String, dynamic>();
        firstMessage["member_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
        firstMessage["member_message"] = "Hello Everyone";
        firstMessage["member_message_time"] = ServerValue.timestamp;
        firstMessage["member_name"] = userAll.isolaUserDisplay.userName;
        firstMessage["member_uid"] = userAll.isolaUserMeta.userUid;
        firstMessage["member_message_isvoice"] = false;
        firstMessage["member_message_voice_url"] = "nothing";
        firstMessage["member_message_isattachment"] = false;
        firstMessage["member_message_attachment_url"] = "";
        firstMessage["member_message_isimage"] = false;
        firstMessage["member_message_isvideo"] = false;
        firstMessage["member_message_isdocument"] = false;
        firstMessage["member_message_target_1_uid"] = "firstmessage";
        firstMessage["member_message_target_2_uid"] = "firstmessage";

        refGroupChatListCreated.push().set(firstMessage);
      });
      // Navigator.pushNamed(context, chatPage);

      print(targetGroup.group_no);
    }
  });
  Future.delayed(const Duration(seconds: 5), () {
    subscription.cancel();
  });
  print(userNewGroupListReturn);
  return userNewGroupListReturn;
}
*/
Future<void> joinToMatchingPool(
    String userUid, bool userSexType, bool userIsNonBinary, bool userIsValid) {
  CollectionReference matchingPool =
      FirebaseFirestore.instance.collection('matching_pool');
  print(DateTime.now().toUtc().millisecondsSinceEpoch);
  // Call the user's CollectionReference to add a new user
  return matchingPool.doc(userUid).set({
    'uUid': userUid,
    'uSex': userSexType,
    'uNonBinary': userIsNonBinary,
    'uValid': userIsValid,
    'register_time': Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().toUtc().millisecondsSinceEpoch)

    /*Timestamp.fromDate(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,
                                    isUtc: false)),*/
  });
}
