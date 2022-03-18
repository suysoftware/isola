// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';

Future<void> leaveGroup(GroupSettingModel groupSettingModel) async {
  CollectionReference leaveRef =
      FirebaseFirestore.instance.collection('groups_leave_pool');

  leaveRef.doc(groupSettingModel.groupNo).set({
    'groupNo': groupSettingModel.groupNo,
    'leaverUser': groupSettingModel.userUid
  });
}






/*
Future<void> groupLeave(
    String groupNo, String userUid, List<dynamic> joinedGroup) async {
  var refMyLine = refGetter(
      enum2: RefEnum.Groupchatmembers,
      targetUid: "",
      userUid: "",
      crypto: groupNo);




  var refGroupDisplay = refGetter(
      enum2: RefEnum.Groupdisplaytarget,
      targetUid: "",
      userUid: "",
      crypto: groupNo);

  refGroupDisplay.child("group_member_value").once().then((value) {
    var memberValue = value.snapshot.value as int;

    refGroupDisplay.child("group_member_value").set(memberValue - 1);
  });
  refGroupDisplay.child("group_need_member").set(true);

//burada ilkj olarak group_member_ uid sıramız bulunacak ve çıkarken
// kendimizi oradan silip need listeye o ismi eklicez
  var lines1;
  var lines2;
  var lines3;

  await refMyLine.child("group_member_1_uid").once().then((value) {
    lines1 = value.snapshot.key;

    if (value.snapshot.value == userUid) {
      print("userimizizin sırası group_member_1_uid");

      groupLeaveRemoveMyLine(
          groupNo, "group_member_1_uid", userUid, joinedGroup);
    }
  });

  await refMyLine.child("group_member_2_uid").once().then((value) {
    lines2 = value.snapshot.key;
    if (value.snapshot.value == userUid) {
      print("userimizizin sırası group_member_2_uid");

      groupLeaveRemoveMyLine(
          groupNo, "group_member_2_uid", userUid, joinedGroup);
    }
  });

  await refMyLine.child("group_member_3_uid").once().then((value) {
    lines3 = value.snapshot.key;
    if (value.snapshot.value == userUid) {
      print("userimizizin sırası group_member_3_uid");

      groupLeaveRemoveMyLine(
          groupNo, "group_member_3_uid", userUid, joinedGroup);
    }
  });

  //await refMyLine.child("group_member_1_uid").once().then((value) {
  //  line1 = value.snapshot.value;
  //print(line1);
  //  print(value);
  //print(value.snapshot);
  //print(value.previousChildKey);
  //print(value.snapshot.key);
  //});
  // print("///");
  // print(line1);
  //print("///");
}
*/
/*
void groupLeaveRemoveMyLine(
    String groupNo, String myLine, String userUid, List<dynamic> joinedList) {
  var refMyMetaList = refGetter(
      enum2: RefEnum.Usermetagrouplist,
      targetUid: "",
      userUid: userUid,
      crypto: "");

  joinedList.remove(groupNo);

  var joinedWithOutThat = joinedList;

  if (joinedWithOutThat.isEmpty) {
    joinedWithOutThat.add("nothing");
    refMyMetaList.set(joinedWithOutThat);
  } else {
    refMyMetaList.set(joinedWithOutThat);
  }

  var refRealMyLine = refGetter(
      enum2: RefEnum.Groupchatmembers,
      targetUid: "",
      userUid: "",
      crypto: groupNo);

  refRealMyLine.child(myLine).remove();

  var refGroupMetaMyLine = refGetter(
      enum2: RefEnum.Groupmetatarget,
      targetUid: "",
      userUid: "",
      crypto: groupNo);

  refGroupMetaMyLine.child(myLine).remove();

  var refGroupDisplayMyLine = refGetter(
      enum2: RefEnum.Groupdisplaytarget,
      targetUid: "",
      userUid: "",
      crypto: groupNo);

  refGroupDisplayMyLine.child("group_need_list").once().then((value) {
    var addMyLineToNeedList = <dynamic>[];
    var ss = value.snapshot.value as List;

    if (ss[0] == "nothing") {
      print("evet");
      addMyLineToNeedList.add(myLine);

      refGroupDisplayMyLine.child("group_need_list").set(addMyLineToNeedList);
    } else {
      addMyLineToNeedList.addAll(ss);

      addMyLineToNeedList.add(myLine);
      refGroupDisplayMyLine.child("group_need_list").set(addMyLineToNeedList);
    }
    //
    //print(value.snapshot.value);
    //  addMyLineToNeedList.addAll(value.snapshot.children);

    //  addMyLineToNeedList.add(myLine);
  });
}
*/