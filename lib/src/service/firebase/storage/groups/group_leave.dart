// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';

Future<void> leaveGroup(GroupSettingModel groupSettingModel) async {
  CollectionReference leaveRef =
      FirebaseFirestore.instance.collection('groups_leave_pool');

  leaveRef.doc(groupSettingModel.groupNo).set({
    'groupNo': groupSettingModel.groupNo,
    'leaverUser': groupSettingModel.userUid
  });
}
