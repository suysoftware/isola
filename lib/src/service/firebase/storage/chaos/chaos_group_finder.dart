// ignore_for_file: unused_local_variable
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:isola_app/src/model/chaos/chaos_group_display.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_chaos.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:uuid/uuid.dart';

findChaosGroup(GroupChaos groupChaos, GroupSettingModel myGroupSetting) async {
  var refChaosGroupDisplay = refGetter(
      enum2: RefEnum.Chaosgroupdisplay, targetUid: "", userUid: "", crypto: "");
  var chaosGroupDisplayList = <ChaosGroupDisplay>[];
  Stream<DatabaseEvent> stream = refChaosGroupDisplay.onValue;

  ///buradan devam edilecek otomatikman yeni grup açıyor yani veriyi doğru çekmiyor
  ///çözümü şu stream şekli değiştirilecek once olarak çekilebilir
  final subscription = stream.listen((DatabaseEvent event) {
    var gettingChaosGroupDisplay = event.snapshot.value as Map;
    gettingChaosGroupDisplay.forEach((key, value) async {
      var comingGroup = ChaosGroupDisplay.fromJson(value);
      if (comingGroup.group1IsHere == true &&
          comingGroup.group2IsHere == false &&
          comingGroup.groupIsActive == false) {
        //bu if üstüne cinsiyet seçeneğini alıp sorgulanacak
        //group validliği sorgulanacak

        var displayItem = ChaosGroupDisplay(
            comingGroup.group1IsHere,
            comingGroup.group2IsHere,
            comingGroup.groupIsActive,
            comingGroup.groupIsNonBinary,
            comingGroup.groupIsValid,
            comingGroup.groupSex,
            comingGroup.groupNo);

        chaosGroupDisplayList.add(displayItem);
      }
    });
  });
  if (chaosGroupDisplayList.isEmpty) {
//choas grubu kur
    String fileID = const Uuid().v4();

    var refChaosGroupDisplay = refGetter(
        enum2: RefEnum.Chaosgroupdisplay,
        targetUid: "",
        userUid: "",
        crypto: "");
    //continue to .child(fileID)
    //group_1_is_here=>true
    //group_2_is_here=>false
    //group_is_active=>true
    //group_is_nonbinary=>groupChaos.chaosIsNonBinary
    //group_is_valid=> groupChaos.chaosIsValid
    //group_sex=>groupChaos.chaosSexOption

    var createGroupChaosDisplay = HashMap<String, dynamic>();
    createGroupChaosDisplay["group_1_is_here"] = true;
    createGroupChaosDisplay["group_2_is_here"] = false;
    createGroupChaosDisplay["group_is_active"] = false;
    createGroupChaosDisplay["group_is_nonbinary"] = groupChaos.chaosIsNonBinary;
    createGroupChaosDisplay["group_is_valid"] = groupChaos.chaosIsValid;
    createGroupChaosDisplay["group_sex"] = groupChaos.chaosSexOption;
    createGroupChaosDisplay["group_no"] = fileID;

    refChaosGroupDisplay.child(fileID).set(createGroupChaosDisplay);

    //group

    //

    var refChaosFirstGroupChatMembers = refGetter(
        enum2: RefEnum.Chaosfirstgroupmembers,
        targetUid: "",
        userUid: "",
        crypto: fileID);
    //direk first e çıkıyor mdoel yüklenecek
    //chaos_group_member_1_uid
    //chaos_group_member_2_uid
    //chaos_group_member_3_uid

    var createGroupChaosFirstChatMembers = HashMap<String, dynamic>();
    createGroupChaosFirstChatMembers["chaos_group_member_1_uid"] =
        myGroupSetting.userUid;
    createGroupChaosFirstChatMembers["chaos_group_member_2_uid"] =
        myGroupSetting.groupMemberUid2;
    createGroupChaosFirstChatMembers["chaos_group_member_3_uid"] =
        myGroupSetting.groupMemberUid3;

    refChaosFirstGroupChatMembers.set(createGroupChaosFirstChatMembers);

    //metayı son gelen grup ekleyecek

    var refGroupChaosNo = refGetter(
        enum2: RefEnum.Groupschaos,
        targetUid: "",
        userUid: "",
        crypto: myGroupSetting.groupNo);
    //. konup chaos_no ya fileId eklenecek ve is_chaos_alive true yapılacak
    //böylelikle is_chaos_alive ise zaten o chatte farklı görünecek

    refGroupChaosNo.child("chaos_no").set(fileID);
    // refGroupChaosNo.child("chaos_is_alive").set(true);
    refGroupChaosNo.child("chaos_is_searching").set(true);
    subscription.cancel();
  } else {
    //chaos grubuna gir
    var targetChaosGroup = chaosGroupDisplayList.first;

    var refChaosGroupMeta = refGetter(
        enum2: RefEnum.Chaosgroupmeta, targetUid: "", userUid: "", crypto: "");

    var refChaosGroupDisplay = refGetter(
        enum2: RefEnum.Chaosgroupdisplay,
        targetUid: "",
        userUid: "",
        crypto: "");

    refChaosGroupDisplay
        .child(targetChaosGroup.groupNo)
        .child("group_2_is_here")
        .set(true);

    var chaosGroupMetaCreator = HashMap<String, dynamic>();
    chaosGroupMetaCreator["created_time"] = ServerValue.timestamp;
    chaosGroupMetaCreator["finish_time"] = DateTime.now()
        .add(Duration(minutes: 20))
        .toUtc()
        .millisecondsSinceEpoch;

    chaosGroupMetaCreator["finish_with_bonus_time"] = DateTime.now()
        .add(Duration(minutes: 40))
        .toUtc()
        .millisecondsSinceEpoch;
    chaosGroupMetaCreator["time_bonus"] = false;
    chaosGroupMetaCreator["chaos_is_complete"] = false;

    refChaosGroupMeta
        .child(targetChaosGroup.groupNo)
        .set(chaosGroupMetaCreator);

    var refChaosSecondGroupChatMembers = refGetter(
        enum2: RefEnum.Chaossecondgroupmembers,
        targetUid: "",
        userUid: "",
        crypto: targetChaosGroup.groupNo);
    //direk first e çıkıyor mdoel yüklenecek
    //chaos_group_member_1_uid
    //chaos_group_member_2_uid
    //chaos_group_member_3_uid

    var createGroupChaosSecondChatMembers = HashMap<String, dynamic>();
    createGroupChaosSecondChatMembers["chaos_group_member_1_uid"] =
        myGroupSetting.userUid;
    createGroupChaosSecondChatMembers["chaos_group_member_2_uid"] =
        myGroupSetting.groupMemberUid2;
    createGroupChaosSecondChatMembers["chaos_group_member_3_uid"] =
        myGroupSetting.groupMemberUid3;

    refChaosSecondGroupChatMembers.set(createGroupChaosSecondChatMembers);

    var refGroupChaosNo = refGetter(
        enum2: RefEnum.Groupschaos,
        targetUid: "",
        userUid: "",
        crypto: myGroupSetting.groupNo);
    //. konup chaos_no ya fileId eklenecek ve is_chaos_alive true yapılacak
    //böylelikle is_chaos_alive ise zaten o chatte farklı görünecek
    refChaosGroupDisplay
        .child(targetChaosGroup.groupNo)
        .child("group_is_active")
        .set(true);
    refGroupChaosNo.child("chaos_no").set(targetChaosGroup.groupNo);
    refGroupChaosNo.child("chaos_is_alive").set(true);
    subscription.cancel();
  }
}
