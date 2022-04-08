// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/popular_timeline.dart';
import 'package:isola_app/src/model/group/group_alives.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';

import '../../../../model/group/groups_model.dart';
import '../../../../model/hive_models/user_hive.dart';

/*
Future<UserAll> getDisplayData(String uid) async {
  var _ref = refGetter(
      enum2: RefEnum.Userdisplay, userUid: uid, targetUid: uid, crypto: "");
  var _refMeta = refGetter(
      enum2: RefEnum.Usermeta, targetUid: uid, userUid: uid, crypto: "");
  dynamic comingValue;
  await _ref.once().then((snapshot) => comingValue = snapshot.snapshot.value);
  var userDisplay = UserDisplay(
      comingValue["user_uid"],
      comingValue["user_name"],
      comingValue["user_biography"],
      comingValue["user_avatar_url"],
      comingValue["user_university"],
      comingValue["user_sex"],
      comingValue["user_is_online"],
      comingValue["user_is_valid"],
      comingValue["user_activities"],
      comingValue["user_interest"],
      comingValue["user_friends"],
      comingValue["user_blocked"],
      comingValue["user_is_non_binary"]);

  dynamic comingMeta;
  await _refMeta.once().then((value) => comingMeta = value.snapshot.value);
  var userMeta = UserMeta(
      comingMeta["user_email"],
      comingMeta["user_token"],
      comingMeta["user_loc_longitude"],
      comingMeta["user_loc_latitude"],
      comingMeta["joined_group_list"]);

  var refSearchingStatus = refGetter(
      enum2: RefEnum.Groupdisplay, targetUid: "", userUid: "", crypto: "");

  var userGroupJoinedList = userMeta.joinedGroupList;
  late bool _searchStatus;

  switch (userGroupJoinedList.length) {
    case 1:
      if (userGroupJoinedList[0] == "nothing") {
        print("nothing");
        _searchStatus = false;
        break;
      } else {
        print("1 tane varmış");
        var memberValue;
        await refSearchingStatus
            .child(userGroupJoinedList[0])
            .child("group_member_value")
            .once()
            .then((value) => memberValue = value.snapshot.value);

        if (memberValue == 3) {
          print("1 tane var ve false döndü");

          // groupChatMessageList.add(value)
          _searchStatus = false;

          break;
        } else {
          print("1 tane var ve true döndü");
          _searchStatus = true;
          break;
        }
      }

    case 2:
      print("2 tane");
      var memberValue1;
      var memberValue2;
      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      if (memberValue1 == 3 && memberValue2 == 3) {
        print("2 tane false döndü");
        _searchStatus = false;

        break;
      } else {
        print("2 tane true döndü");
        _searchStatus = true;
        break;
      }
    case 3:
      print("3 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);

      if (memberValue1 == 3 && memberValue2 == 3 && memberValue3 == 3) {
        print("3 tane false");
        _searchStatus = false;

        break;
      } else {
        print("3 tane true");
        _searchStatus = true;
        break;
      }
    case 4:
      print("4 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;
      var memberValue4;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[3])
          .child("group_member_value")
          .once()
          .then((value) => memberValue4 = value.snapshot.value);

      if (memberValue1 == 3 &&
          memberValue2 == 3 &&
          memberValue3 == 3 &&
          memberValue4 == 3) {
        print("4 tane false");
        _searchStatus = false;

        break;
      } else {
        print("4 tane true");
        _searchStatus = true;
        break;
      }
    case 5:
      print("5 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;
      var memberValue4;
      var memberValue5;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[3])
          .child("group_member_value")
          .once()
          .then((value) => memberValue4 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[4])
          .child("group_member_value")
          .once()
          .then((value) => memberValue5 = value.snapshot.value);

      if (memberValue1 == 3 &&
          memberValue2 == 3 &&
          memberValue3 == 3 &&
          memberValue4 == 3 &&
          memberValue5 == 3) {
        print("5 tane false");
        _searchStatus = false;

        break;
      } else {
        print("5 tane true");
        _searchStatus = true;
        break;
      }

    default:
      print("direk false");
      _searchStatus = false;
      break;
  }
  var userAll = UserAll(userDisplay, userMeta, _searchStatus);
  return userAll;
}
*/
/*
Future<GroupPreviewData> getAllDataForChatPage(String uid) async {
  var _ref = refGetter(
      enum2: RefEnum.Userdisplay, userUid: uid, targetUid: uid, crypto: "");
  var _refMeta = refGetter(
      enum2: RefEnum.Usermeta, targetUid: uid, userUid: uid, crypto: "");
  dynamic comingValue;
  await _ref.once().then((snapshot) => comingValue = snapshot.snapshot.value);
  var userDisplay = UserDisplay(
      comingValue["user_uid"],
      comingValue["user_name"],
      comingValue["user_biography"],
      comingValue["user_avatar_url"],
      comingValue["user_university"],
      comingValue["user_sex"],
      comingValue["user_is_online"],
      comingValue["user_is_valid"],
      comingValue["user_activities"],
      comingValue["user_interest"],
      comingValue["user_friends"],
      comingValue["user_blocked"],
      comingValue["user_is_non_binary"]);

  dynamic comingMeta;
  await _refMeta.once().then((value) => comingMeta = value.snapshot.value);
  var userMeta = UserMeta(
      comingMeta["user_email"],
      comingMeta["user_token"],
      comingMeta["user_loc_longitude"],
      comingMeta["user_loc_latitude"],
      comingMeta["joined_group_list"]);

  var refSearchingStatus = refGetter(
      enum2: RefEnum.Groupdisplay, targetUid: "", userUid: "", crypto: "");

  var refGroupChaosPreview = refGetter(
      enum2: RefEnum.Groupschaospreview,
      targetUid: "",
      userUid: "",
      crypto: "");
  var userGroupJoinedList = userMeta.joinedGroupList;

  //ilk var ile groupchatpreview itemi oluşturucal ama o bir list
  //sonra o listi bu liste eklicez

  late bool _searchStatus;
  late bool _chatGroupIsAlive1;
  late bool _searchStatus1;
  late bool _chatGroupIsAlive2;
  late bool _searchStatus2;
  late bool _chatGroupIsAlive3;
  late bool _searchStatus3;
  late bool _chatGroupIsAlive4;
  late bool _searchStatus4;
  late bool _chatGroupIsAlive5;
  late bool _searchStatus5;

  late bool is1ChaosAlive;
  late bool is2ChaosAlive;
  late bool is3ChaosAlive;
  late bool is4ChaosAlive;
  late bool is5ChaosAlive;

  late String chaos1GroupNo;
  late String chaos2GroupNo;
  late String chaos3GroupNo;
  late String chaos4GroupNo;
  late String chaos5GroupNo;

  switch (userGroupJoinedList.length) {
    case 1:
      _chatGroupIsAlive2 = false;
      _chatGroupIsAlive3 = false;
      _chatGroupIsAlive4 = false;
      _chatGroupIsAlive5 = false;
      _searchStatus2 = true;
      _searchStatus3 = true;
      _searchStatus4 = true;
      _searchStatus5 = true;
      is2ChaosAlive = false;
      is3ChaosAlive = false;
      is4ChaosAlive = false;
      is5ChaosAlive = false;
      chaos2GroupNo = "nothing";
      chaos3GroupNo = "nothing";
      chaos4GroupNo = "nothing";
      chaos5GroupNo = "nothing";

      if (userGroupJoinedList[0] == "nothing") {
        print("nothing");
        _chatGroupIsAlive1 = false;
        _searchStatus1 = false;
        chaos1GroupNo = "nothing";
        break;
      } else {
        _chatGroupIsAlive1 = true;
        print("1 tane varmış");
        var memberValue;
        await refSearchingStatus
            .child(userGroupJoinedList[0])
            .child("group_member_value")
            .once()
            .then((value) => memberValue = value.snapshot.value);

        if (memberValue == 3) {
          print("1 tane var ve false döndü");

          _searchStatus1 = false;

          _searchStatus = false;

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_is_alive")
              .once()
              .then((value) => is1ChaosAlive = value.snapshot.value as bool);

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_no")
              .once()
              .then((value) => chaos1GroupNo = value.snapshot.value as String);

          break;
        } else {
          print("1 tane var ve true döndü");
          _searchStatus1 = true;
          _searchStatus = true;
          chaos1GroupNo = "nothing";
          is1ChaosAlive = false;
          break;
        }
      }

    case 2:
      _chatGroupIsAlive3 = false;
      _chatGroupIsAlive4 = false;
      _chatGroupIsAlive5 = false;

      is3ChaosAlive = false;
      is4ChaosAlive = false;
      is5ChaosAlive = false;

      chaos3GroupNo = "nothing";
      chaos4GroupNo = "nothing";
      chaos5GroupNo = "nothing";

      _searchStatus3 = true;
      _searchStatus4 = true;
      _searchStatus5 = true;
      print("2 tane");
      _chatGroupIsAlive1 = true;
      _chatGroupIsAlive2 = true;
      var memberValue1;
      var memberValue2;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      memberValue1 == 3 ? _searchStatus1 = false : _searchStatus1 = true;

      memberValue2 == 3 ? _searchStatus2 = false : _searchStatus2 = true;

      if (memberValue1 == 3 && memberValue2 == 3) {
        ///buraya

        print("2 tane false döndü");

        _searchStatus = false;

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_is_alive")
            .once()
            .then((value) => is1ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_is_alive")
            .once()
            .then((value) => is2ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_no")
            .once()
            .then((value) => chaos1GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_no")
            .once()
            .then((value) => chaos2GroupNo = value.snapshot.value as String);

        break;
      } else {
        print("2 tane true döndü");

        _searchStatus = true;

        if (memberValue1 != 3) {
          chaos1GroupNo = "nothing";
          is1ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_no")
              .once()
              .then((value) => chaos1GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_is_alive")
              .once()
              .then((value) => is1ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue2 != 3) {
          chaos2GroupNo = "nothing";
          is2ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_no")
              .once()
              .then((value) => chaos2GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_is_alive")
              .once()
              .then((value) => is2ChaosAlive = value.snapshot.value as bool);
        }

        break;
      }
    case 3:
      _chatGroupIsAlive4 = false;
      _chatGroupIsAlive5 = false;

      is4ChaosAlive = false;
      is5ChaosAlive = false;

      chaos4GroupNo = "nothing";
      chaos5GroupNo = "nothing";

      _searchStatus4 = true;
      _searchStatus5 = true;

      _chatGroupIsAlive1 = true;
      _chatGroupIsAlive2 = true;
      _chatGroupIsAlive3 = true;
      print("3 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);
      print(memberValue1);
      print(memberValue2);
      print(memberValue3);

      await memberValue1 == 3 ? _searchStatus1 = false : _searchStatus1 = true;
      await memberValue2 == 3 ? _searchStatus2 = false : _searchStatus2 = true;
      await memberValue3 == 3 ? _searchStatus3 = false : _searchStatus3 = true;

      if (memberValue1 == 3 && memberValue2 == 3 && memberValue3 == 3) {
        //buraya

        print("3 tane false");

        _searchStatus = false;

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_is_alive")
            .once()
            .then((value) => is1ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_is_alive")
            .once()
            .then((value) => is2ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_is_alive")
            .once()
            .then((value) => is3ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_no")
            .once()
            .then((value) => chaos1GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_no")
            .once()
            .then((value) => chaos2GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_no")
            .once()
            .then((value) => chaos3GroupNo = value.snapshot.value as String);

        break;
      } else {
        print("3 tane true");

        _searchStatus = true;
//silinebilir

        if (memberValue1 != 3) {
          chaos1GroupNo = "nothing";
          is1ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_no")
              .once()
              .then((value) => chaos1GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_is_alive")
              .once()
              .then((value) => is1ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue2 != 3) {
          chaos2GroupNo = "nothing";
          is2ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_no")
              .once()
              .then((value) => chaos2GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_is_alive")
              .once()
              .then((value) => is2ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue3 != 3) {
          chaos3GroupNo = "nothing";
          is3ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_no")
              .once()
              .then((value) => chaos3GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_is_alive")
              .once()
              .then((value) => is3ChaosAlive = value.snapshot.value as bool);
        }

        //

        break;
      }

    case 4:
      _chatGroupIsAlive5 = false;

      is5ChaosAlive = false;

      chaos5GroupNo = "nothing";
      _searchStatus5 = true;

      _chatGroupIsAlive1 = true;
      _chatGroupIsAlive2 = true;
      _chatGroupIsAlive3 = true;
      _chatGroupIsAlive4 = true;
      print("4 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;
      var memberValue4;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[3])
          .child("group_member_value")
          .once()
          .then((value) => memberValue4 = value.snapshot.value);

      memberValue1 == 3 ? _searchStatus1 = false : _searchStatus1 = true;
      memberValue2 == 3 ? _searchStatus2 = false : _searchStatus2 = true;
      memberValue3 == 3 ? _searchStatus3 = false : _searchStatus3 = true;
      memberValue4 == 3 ? _searchStatus4 = false : _searchStatus4 = true;
      if (memberValue1 == 3 &&
          memberValue2 == 3 &&
          memberValue3 == 3 &&
          memberValue4 == 3) {
        //buraya

        print("4 tane false");
        _searchStatus = false;

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_is_alive")
            .once()
            .then((value) => is1ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_is_alive")
            .once()
            .then((value) => is2ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_is_alive")
            .once()
            .then((value) => is3ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[3])
            .child("chaos_is_alive")
            .once()
            .then((value) => is4ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_no")
            .once()
            .then((value) => chaos1GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_no")
            .once()
            .then((value) => chaos2GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_no")
            .once()
            .then((value) => chaos3GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[3])
            .child("chaos_no")
            .once()
            .then((value) => chaos4GroupNo = value.snapshot.value as String);

        break;
      } else {
        print("4 tane true");
        _searchStatus = true;

        if (memberValue1 != 3) {
          chaos1GroupNo = "nothing";
          is1ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_no")
              .once()
              .then((value) => chaos1GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_is_alive")
              .once()
              .then((value) => is1ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue2 != 3) {
          chaos2GroupNo = "nothing";
          is2ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_no")
              .once()
              .then((value) => chaos2GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_is_alive")
              .once()
              .then((value) => is2ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue3 != 3) {
          chaos3GroupNo = "nothing";
          is3ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_no")
              .once()
              .then((value) => chaos3GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_is_alive")
              .once()
              .then((value) => is3ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue4 != 3) {
          chaos4GroupNo = "nothing";
          is4ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[3])
              .child("chaos_no")
              .once()
              .then((value) => chaos4GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[3])
              .child("chaos_is_alive")
              .once()
              .then((value) => is4ChaosAlive = value.snapshot.value as bool);
        }

        break;
      }
    case 5:
      _chatGroupIsAlive1 = true;
      _chatGroupIsAlive2 = true;
      _chatGroupIsAlive3 = true;
      _chatGroupIsAlive4 = true;
      _chatGroupIsAlive5 = true;
      print("5 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;
      var memberValue4;
      var memberValue5;

      await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[3])
          .child("group_member_value")
          .once()
          .then((value) => memberValue4 = value.snapshot.value);
      await refSearchingStatus
          .child(userGroupJoinedList[4])
          .child("group_member_value")
          .once()
          .then((value) => memberValue5 = value.snapshot.value);

      memberValue1 == 3 ? _searchStatus1 = false : _searchStatus1 = true;
      memberValue2 == 3 ? _searchStatus2 = false : _searchStatus2 = true;
      memberValue3 == 3 ? _searchStatus3 = false : _searchStatus3 = true;
      memberValue4 == 3 ? _searchStatus4 = false : _searchStatus4 = true;
      memberValue5 == 3 ? _searchStatus5 = false : _searchStatus5 = true;

      if (memberValue1 == 3 &&
          memberValue2 == 3 &&
          memberValue3 == 3 &&
          memberValue4 == 3 &&
          memberValue5 == 3) {
        //buraya

        print("5 tane false");

        _searchStatus = false;
        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_is_alive")
            .once()
            .then((value) => is1ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_is_alive")
            .once()
            .then((value) => is2ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_is_alive")
            .once()
            .then((value) => is3ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[3])
            .child("chaos_is_alive")
            .once()
            .then((value) => is4ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[4])
            .child("chaos_is_alive")
            .once()
            .then((value) => is5ChaosAlive = value.snapshot.value as bool);

        await refGroupChaosPreview
            .child(userGroupJoinedList[0])
            .child("chaos_no")
            .once()
            .then((value) => chaos1GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[1])
            .child("chaos_no")
            .once()
            .then((value) => chaos2GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[2])
            .child("chaos_no")
            .once()
            .then((value) => chaos3GroupNo = value.snapshot.value as String);

        await refGroupChaosPreview
            .child(userGroupJoinedList[3])
            .child("chaos_no")
            .once()
            .then((value) => chaos4GroupNo = value.snapshot.value as String);
        await refGroupChaosPreview
            .child(userGroupJoinedList[4])
            .child("chaos_no")
            .once()
            .then((value) => chaos5GroupNo = value.snapshot.value as String);
        break;
      } else {
        print("5 tane true");

        _searchStatus = true;

        if (memberValue1 != 3) {
          chaos1GroupNo = "nothing";
          is1ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_no")
              .once()
              .then((value) => chaos1GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[0])
              .child("chaos_is_alive")
              .once()
              .then((value) => is1ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue2 != 3) {
          chaos2GroupNo = "nothing";
          is2ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_no")
              .once()
              .then((value) => chaos2GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[1])
              .child("chaos_is_alive")
              .once()
              .then((value) => is2ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue3 != 3) {
          chaos3GroupNo = "nothing";
          is3ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_no")
              .once()
              .then((value) => chaos3GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[2])
              .child("chaos_is_alive")
              .once()
              .then((value) => is3ChaosAlive = value.snapshot.value as bool);
        }
        if (memberValue4 != 3) {
          chaos4GroupNo = "nothing";
          is4ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[3])
              .child("chaos_no")
              .once()
              .then((value) => chaos4GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[3])
              .child("chaos_is_alive")
              .once()
              .then((value) => is4ChaosAlive = value.snapshot.value as bool);
        }

        if (memberValue5 != 3) {
          chaos5GroupNo = "nothing";
          is5ChaosAlive = false;
        } else {
          await refGroupChaosPreview
              .child(userGroupJoinedList[4])
              .child("chaos_no")
              .once()
              .then((value) => chaos5GroupNo = value.snapshot.value as String);

          await refGroupChaosPreview
              .child(userGroupJoinedList[4])
              .child("chaos_is_alive")
              .once()
              .then((value) => is5ChaosAlive = value.snapshot.value as bool);
        }

        print("11");
        break;
      }

    default:
      print("direk false");
      _searchStatus1 = true;
      _searchStatus2 = true;
      _searchStatus3 = true;
      _searchStatus4 = true;
      _searchStatus5 = true;
      _chatGroupIsAlive1 = false;
      _chatGroupIsAlive2 = false;
      _chatGroupIsAlive3 = false;
      _chatGroupIsAlive4 = false;
      _chatGroupIsAlive5 = false;
      chaos1GroupNo = "nothing";
      chaos2GroupNo = "nothing";
      chaos3GroupNo = "nothing";
      chaos4GroupNo = "nothing";
      chaos5GroupNo = "nothing";
      _searchStatus = true;
      print("12");
      break;
  }
  print("13");
  var groupAlives = GroupAlives(
      _chatGroupIsAlive1,
      _searchStatus1,
      _chatGroupIsAlive2,
      _searchStatus2,
      _chatGroupIsAlive3,
      _searchStatus3,
      _chatGroupIsAlive4,
      _searchStatus4,
      _chatGroupIsAlive5,
      _searchStatus5,
      is1ChaosAlive,
      is2ChaosAlive,
      is3ChaosAlive,
      is4ChaosAlive,
      is5ChaosAlive,
      chaos1GroupNo,
      chaos2GroupNo,
      chaos3GroupNo,
      chaos4GroupNo,
      chaos5GroupNo);

  var isolaUserDisplay = IsolaUserDisplay(
      userDisplay.userName,
      userDisplay.userBiography,
      userDisplay.avatarUrl,
      userDisplay.userSex,
      userDisplay.userIsOnline,
      userDisplay.userInterest,
      userDisplay.userIsNonBinary,
      userDisplay.userUniversity,
      userDisplay.userActivities,
      ["null"]);

  var isolaUserMeta = IsolaUserMeta(
      userMeta.userEmail,
      userMeta.userToken,
      userGroupJoinedList,
      userDisplay.userUid,
      userDisplay.userIsValid,
      userDisplay.userFriends,
      userDisplay.userBlocked,
      ["null"],
      false,);
  var userAll = IsolaUserAll(isolaUserDisplay, isolaUserMeta);
  print("14");
  var groupPreview = GroupPreviewData(userAll, groupAlives);

  print("15");
  return groupPreview;
}

Future<List<dynamic>> getPopularFeeds() async {
  var _refTimeline = refGetter(
      enum2: RefEnum.Timelinereadfeeds, userUid: "", crypto: '', targetUid: '');
  var popularFeedList = <FeedMeta>[];
  Stream<DatabaseEvent> stream = _refTimeline.onValue;
  final subscription = stream.listen((DatabaseEvent event) {
    print("dinliyor");

    var gettingFeedMeta = event.snapshot.value as Map;

    gettingFeedMeta.forEach((key, value) async {
      var comingFeed = FeedMeta.fromJson(value);

      popularFeedList.add(comingFeed);
    });

    print("sıraladı");
    print(popularFeedList.first.feedText);
    /*
    var item = FeedMeta(
        popularFeedList.first.feedTime,
        popularFeedList.first.feedDate,
        popularFeedList.first.feedNo,
        popularFeedList.first.feedImageUrl,
        popularFeedList.first.feedText,
        popularFeedList.first.feedIsImage,
        popularFeedList.first.likeList,
        popularFeedList.first.likeValue,
        popularFeedList.first.userUid,
        popularFeedList.first.userName,
        popularFeedList.first.userBiography,
        popularFeedList.first.avatarUrl,
        popularFeedList.first.userUniversity,
        popularFeedList.first.userSex,
        popularFeedList.first.userIsOnline,
        popularFeedList.first.userIsValid,
        popularFeedList.first.userActivities,
        popularFeedList.first.userInterest,
        popularFeedList.first.userFriends,
        popularFeedList.first.userBlocked,
        popularFeedList.first.userIsNonBinary);

    var item2 = FeedMeta(
        popularFeedList[1].feedTime,
        popularFeedList[1].feedDate,
        popularFeedList[1].feedNo,
        popularFeedList[1].feedImageUrl,
        popularFeedList[1].feedText,
        popularFeedList[1].feedIsImage,
        popularFeedList[1].likeList,
        popularFeedList[1].likeValue,
        popularFeedList[1].userUid,
        popularFeedList[1].userName,
        popularFeedList[1].userBiography,
        popularFeedList[1].avatarUrl,
        popularFeedList[1].userUniversity,
        popularFeedList[1].userSex,
        popularFeedList[1].userIsOnline,
        popularFeedList[1].userIsValid,
        popularFeedList[1].userActivities,
        popularFeedList[1].userInterest,
        popularFeedList[1].userFriends,
        popularFeedList[1].userBlocked,
        popularFeedList[1].userIsNonBinary);
    popularFeedList.add(item);
    popularFeedList.add(item2);
    print("hepsini ekledi");
    */
  });
  popularFeedList.sort((b, a) => a.likeValue.compareTo(b.likeValue));

  return popularFeedList;
}
*/
Future<IsolaUserDisplay> getUserDisplay(String uid) async {
  // dynamic comingValue;
  var userDisplay;
/*  var _ref = refGetter(
      enum2: RefEnum.Userdisplay, userUid: uid, targetUid: uid, crypto: "");
  await _ref.once().then((snapshot) => comingValue = snapshot.snapshot.value);

  */
  DocumentReference users_display =
      FirebaseFirestore.instance.collection('users_display').doc(uid);

  await users_display.get().then((docValue) => userDisplay = IsolaUserDisplay(
      docValue['uName'],
      docValue['uBio'],
      docValue['uPic'],
      docValue['uSex'],
      docValue['uOnline'],
      docValue['uInterest'],
      docValue['uNonBinary'],
      docValue['uUniversity'],
      docValue['uAct'],
      docValue['uLike'],
      docValue['uDbToken']));

  return userDisplay;
}

/*
Future<List<dynamic>> getTimelineDatas(
    IsolaUserAll userAll, int amountData) async {
  var timelineDatas = <TimelineItem>[];
  var sponsoredRoad;
  var refTimeline = refGetter(
      enum2: RefEnum.Feedcomesfromfeedtext,
      targetUid: "",
      userUid: "",
      crypto: "");
  var sponsoredRef = refGetter(
      enum2: RefEnum.Sponsoredroad,
      targetUid: "",
      userUid: "",
      crypto: userAll.isolaUserDisplay.userUniversity);

  var sponsorQuery = sponsoredRef;
  DataSnapshot snap = await sponsorQuery.get();

  print(sponsoredRoad);
  var userFriendList = <dynamic>[];
  userFriendList.addAll(userAll.isolaUserMeta.userFriends);
  userFriendList.add(userAll.isolaUserMeta.userUid as dynamic);
  if (snap.exists) {
    print("EXİST EXİST EXİST EXİST");
    if (sponsoredRoad != "empty") {
      print("EMPTY DEĞĞĞĞİLL");
      sponsoredRoad = snap.value;
      print(sponsoredRoad);
      userFriendList.add(sponsoredRoad as dynamic);
    }
  }

  for (var item in userFriendList) {
    await refTimeline
        .child(item)
        .limitToLast(amountData)
        //.orderByKey().startAt("0").endAt("b\uf8ff")

        .once()
        .then((value) {
      if (value.snapshot.exists) {
        var gettingTimeline = value.snapshot.value as Map;
        gettingTimeline.forEach((key, value) {
          var comingItem = FeedMeta.fromJson(value);
          //  print(comingItem.feedText);
          var timeItem = TimelineItem(
              feedMeta: comingItem,
              userUid: userAll.isolaUserMeta.userUid,
              isTimeline: true);

          timelineDatas.add(timeItem);

          // print(timelineDatas.length);
          //print(timeItem.feedMeta.feedText);
        });
      } else {
        print("HAFHASHFHASHFHAS");
      }
    });
  }
  print("GONDER GELSIIIIIN");
  return timelineDatas;
}
*/
Future<bool> groupChaosSearchingInfoGetter(String groupNo) async {
/*  var refGroupChaos = refGetter(
      enum2: RefEnum.Groupschaos, targetUid: "", userUid: "", crypto: groupNo);

  var groupSearchingQuery = refGroupChaos.child("chaos_is_searching");

  print("coin var aga");
  DataSnapshot snapMember1 = await groupSearchingQuery.get();
  print(snapMember1.value as bool);
  return snapMember1.value as bool;
  */

  var searchInfo;

  DocumentReference groupSearchInfo =
      FirebaseFirestore.instance.collection('groups').doc(groupNo);

  await groupSearchInfo
      .get()
      .then((docValue) => searchInfo = docValue['gChaosSearching']);

  return searchInfo;
}

Future<IsolaUserAll> getUserAllFromDataBase(String userUid) async {
  var userDisplay;
  var userMeta;
  //we search user
  if (userUid != null) {
    DocumentReference users_display =
        FirebaseFirestore.instance.collection('users_display').doc(userUid);

    DocumentReference users_meta =
        FirebaseFirestore.instance.collection('users_meta').doc(userUid);

    await users_display.get().then((docValue) => userDisplay = IsolaUserDisplay(
        docValue['uName'],
        docValue['uBio'],
        docValue['uPic'],
        docValue['uSex'],
        docValue['uOnline'],
        docValue['uInterest'],
        docValue['uNonBinary'],
        docValue['uUniversity'],
        docValue['uAct'],
        docValue['uLike'],
        docValue['uDbToken']));

    await users_meta.get().then((docValue) => userMeta = IsolaUserMeta(
        docValue['uEmail'],
        docValue['uToken'],
        docValue['uGroupList'],
        docValue['uUid'],
        docValue['uValid'],
        docValue['uFriends'],
        docValue['uBlocked'],
        docValue['uClubs'],
        docValue['uSearching'],
        docValue['uFriendOrders']));
  } else {
    //Hata göster belki restart atar

  }

  var userAll = IsolaUserAll(userDisplay, userMeta);
  return userAll;
}

Future<GroupMergeData> mergeForChatPage(String userUid) async {
  var userAll;
  var groupDatas;
  //we search user

  try {
   
    await getUserAllFromDataBase(userUid).then((value) => userAll = value);
  } catch (e) {
    print('$e PROBLEMİ VAR');
  }
  try {

    await getGroupDataFromDatabase(userAll).then((value) => groupDatas = value);
  } catch (e) {
    print('$e PROBLEMİ VAR');
  }

  var isThereGroup = userAll as IsolaUserAll;


  if (isThereGroup.isolaUserMeta.joinedGroupList.first != "nothing") {
  
    var expList;
    var box = await Hive.openBox('userHive');
    if (box.isNotEmpty) {
      UserHive userHive = box.get('datetoday');

      expList = userHive.exloreData;
      
    } else {
      expList = ['s'];


    }


    var groupMergeDatas = GroupMergeData(userAll, groupDatas, expList);
  
    return groupMergeDatas;
    /*
    try {
     
    } catch (e) {
      var groupMergeDatas = GroupMergeData(userAll, groupDatas, ['y']);
      print('grdi6');
      return groupMergeDatas;
    }*/
  } else {
    var groupMergeDatas = GroupMergeData(userAll, groupDatas, ['df']);

    return groupMergeDatas;
  }
}

Future<List<dynamic>> getGroupDataFromDatabase(IsolaUserAll userAll) async {
  var groupsModelList = <GroupsModel>[];
  if (userAll.isolaUserMeta.joinedGroupList[0] == "nothing") {
    return groupsModelList;
  } else {
    for (var item in userAll.isolaUserMeta.joinedGroupList) {
      try {
        var groupData;

        DocumentReference groupsData =
            FirebaseFirestore.instance.collection('groups').doc(item);

        await groupsData.get().then((docValue) => groupData = GroupsModel(
            docValue['gActive'],
            docValue['gValue'],
            docValue['gNeed'],
            docValue['gSex'],
            docValue['gNonBinary'],
            docValue['gValid'],
            docValue['gToken'],
            docValue['gList'],
            docValue['gNo'],
            docValue['gChaos'],
            docValue['gChaosNo'],
            docValue['gChaosSearching']));

        groupsModelList.add(groupData);
      } catch (e) {
        break;
      }
    }

    return groupsModelList;
  }
}

Future<List<dynamic>> getTimelineFeeds(
    IsolaUserAll isolaUserAll, int amountData) async {

  var timelineDatas = <TimelineItem>[];

  var timelineUserList = <dynamic>[];
  timelineUserList.addAll(isolaUserAll.isolaUserMeta.userFriends);
  timelineUserList.add(isolaUserAll.isolaUserMeta.userUid);

  //var isolaFeedDatas = <IsolaFeedModel>[];

  final Timestamp now = Timestamp.fromDate(DateTime.now());
  final Timestamp yesterday = Timestamp.fromDate(
    DateTime.now().subtract(const Duration(days: 1)),
  );

  for (var friend in timelineUserList) {
    await FirebaseFirestore.instance
        .collection('feeds')
        .doc(friend)
        .collection('text_feeds')
        .where('feed_date', isLessThan: now, isGreaterThan: yesterday)
        .orderBy('feed_date', descending: true)
        .limit(20)
        /*.withConverter<IsolaFeedModel>(
          fromFirestore: (snapshot, _) =>
              IsolaFeedModel.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        )*/
        .get()
        .then((value) {
      for (var item in value.docs) {
        var isolaItem = IsolaFeedModel(
            item['feed_date'],
            item['feed_no'],
            item['feed_text'],
            item['like_list'],
            item['like_value'],
            item['user_avatar_url'],
            item['user_name'],
            item['user_uid']);
        var timelineItem = TimelineItem(
          feedMeta: isolaItem,
          userUid: isolaUserAll.isolaUserMeta.userUid,
          isTimeline: true,
          isolaUserAll: isolaUserAll,
        );



        timelineDatas.add(timelineItem);
      }
    });
  }

  return timelineDatas;
}

Future<void> getProfileTimeline(String userUid, int amountData) async {

  var timelineDatas = <TimelineItem>[];

  var isolaFeedDatas = <IsolaFeedModel>[];

  final Timestamp now = Timestamp.fromDate(DateTime.now());
  final Timestamp yesterday = Timestamp.fromDate(
    DateTime.now().subtract(const Duration(days: 1)),
  );

  await FirebaseFirestore.instance
      .collection('feeds')
      .doc(userUid)
      .collection('text_feeds')
      .orderBy('feed_date', descending: true)
      .limit(20)
      /*.withConverter<IsolaFeedModel>(
          fromFirestore: (snapshot, _) =>
              IsolaFeedModel.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        )*/
      .get()
      .then((value) {
    for (var item in value.docs) {
      var isolaItem = IsolaFeedModel(
          item['feed_date'],
          item['feed_no'],
          item['feed_text'],
          item['like_list'],
          item['like_value'],
          item['user_avatar_url'],
          item['user_name'],
          item['user_uid']);



      isolaFeedDatas.add(isolaItem);
    }
  });


}

Future<PopularTimeline> getPopularItems() async {
  var itemList = <PopularItem>[];

  CollectionReference refPopular =
      FirebaseFirestore.instance.collection('news_and_popular');

  await refPopular.get().then((value) {
    for (var item in value.docs) {
      var popularItem = PopularItem(item['pAvatarUrl'], item['pDate'],
          item['pLink'], item['pName'], item['pText'], item['pLikeValue']);
      itemList.add(popularItem);
    }
  });

  return PopularTimeline(itemList[0], itemList[1]);
}
