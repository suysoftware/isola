// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/popular_timeline.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import '../../../../model/group/groups_model.dart';
import '../../../../model/hive_models/user_hive.dart';
import '../../../../model/user/user_notification_settings.dart';

Future<IsolaUserDisplay> getUserDisplay(String uid) async {
  var userDisplay;

  DocumentReference usersDisplay =
      FirebaseFirestore.instance.collection('users_display').doc(uid);

  await usersDisplay.get().then((docValue) => userDisplay = IsolaUserDisplay(
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

Future<bool> groupChaosSearchingInfoGetter(String groupNo) async {
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

  // ignore: unnecessary_null_comparison
  if (userUid != null) {
    DocumentReference usersDisplay =
        FirebaseFirestore.instance.collection('users_display').doc(userUid);

    DocumentReference usersMeta =
        FirebaseFirestore.instance.collection('users_meta').doc(userUid);

    await usersDisplay.get().then((docValue) => userDisplay = IsolaUserDisplay(
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

    await usersMeta.get().then((docValue) => userMeta = IsolaUserMeta(
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
  } else {}

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

Future<UserNotificationSettings> userNotificationSettingsGetter(
    String userUid) async {
  print(userUid);

  DocumentReference userNotiSettingRef = FirebaseFirestore.instance
      .collection('users_notification_settings')
      .doc(userUid);
  print('1');
  var notiSettingData;
  await userNotiSettingRef.get().then((notiData) => notiSettingData =
      UserNotificationSettings(
          notiData['chaos_messages'],
          notiData['group_messages'],
          notiData['likes'],
          notiData['new_matches'],
          notiData['system_notifications'],
          notiData['tokens']));

  print('2');

  print('3');
  return notiSettingData;
}
