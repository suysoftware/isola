// ignore_for_file: avoid_print

import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:uuid/uuid.dart';

Future<void> addFeed(
    String uid, IsolaUserAll userAll, String feedText) async {
  var feedLikes = <dynamic>[];
  //feed no yazabilirsin buralara

  feedLikes.add("start");

  var feedMeta = HashMap<String, dynamic>();
  var refAddFeedTimeline = refGetter(
      enum2: RefEnum.Feedtofeedtext, userUid: uid, targetUid: uid, crypto: "");
  DatabaseReference newRef = refAddFeedTimeline.push();
  var newKey = newRef.key;

  feedMeta["feed_time"] = ServerValue.timestamp;
  feedMeta["feed_date"] = DateTime.now().toString();
  feedMeta["feed_no"] = newKey.toString();
  feedMeta["feed_image_url"] = "";
  feedMeta["feed_text"] = feedText;
  feedMeta["feed_is_image"] = false;
  feedMeta["user_activities"] = userAll.isolaUserDisplay.userActivities;
  feedMeta["user_interest"] = userAll.isolaUserDisplay.userInterest;
  feedMeta["like_list"] = feedLikes;
  feedMeta["like_value"] = 0;
  feedMeta["user_friends"] = userAll.isolaUserMeta.userFriends;
  feedMeta["user_blocked"] = userAll.isolaUserMeta.userBlocked;
  feedMeta["user_uid"] = uid;
  feedMeta["user_name"] = userAll.isolaUserDisplay.userName;
  feedMeta["user_biography"] = userAll.isolaUserDisplay.userBiography;
  feedMeta["user_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
  feedMeta["user_university"] = userAll.isolaUserDisplay.userUniversity;
  feedMeta["user_sex"] = userAll.isolaUserDisplay.userSex;
  feedMeta["user_is_online"] = userAll.isolaUserDisplay.userIsOnline;
  feedMeta["user_is_valid"] = userAll.isolaUserMeta.userIsValid;
  feedMeta["user_is_non_binary"] = userAll.isolaUserDisplay.userIsNonBinary;

/*
  for (var a in userFriendsUid) {
    var refAddFeedTimeline = refGetter(
        enum2: RefEnum.Timelineaddfeeds,
        userUid: uid,
        targetUid: a.toString(),
        crypto: fileID);

   await refAddFeedTimeline.set(feedMeta);
  }*/

  print(newKey);
  newRef.set(feedMeta);
  //refAddFeedTimeline.push().set(feedMeta);

  //await refAddFeedBase.set(feedMeta);

//base
  // refAddFeedMeta.set(feedMeta);
}

/*
oto feeds
*/

/*

Future<void> addImageFeed(String uid) async {
  var feedLikes = <String>[];
  feedLikes.add("ayse");
  feedLikes.add("fatma");

  var userFriends = <String>[];
  userFriends.add("hüseyin");
  userFriends.add("emirhan");
  userFriends.add("keremhan");
  userFriends.add("recepcan");

  var userBlocked = <String>[];
  userBlocked.add("okan");
  userBlocked.add("javier");

  var activites = <String>[];
  activites.add("activity1");
  activites.add("activity2");
  activites.add("activity3");
  activites.add("activity4");

  var interest = <String>[];
  interest.add("interest1");
  interest.add("interest2");
  interest.add("interest3");
  interest.add("interest4");
  int dnm = 160;
  for (int i = 140; i < 840; i++) {
    String fileID = const Uuid().v4();
    var refAddFeedMeta = refGetter(
        enum2: RefEnum.FeedsAdder, userUid: uid, targetUid: uid, crypto: "");
    var feedMeta = HashMap<String, dynamic>();

    feedMeta["feed_date"] = "22.22.22";
    feedMeta["feed_no"] = fileID;
    feedMeta["feed_image_url"] = "https://picsum.photos/800/800?random=$dnm";
    feedMeta["feed_text"] = "bu benim ilk tweetim";
    feedMeta["feed_is_image"] = true;
    feedMeta["user_activities"] = activites;
    feedMeta["user_interest"] = interest;
    feedMeta["like_list"] = feedLikes;
    feedMeta["user_friends"] = userFriends;
    feedMeta["user_blocked"] = userBlocked;
    feedMeta["user_uid"] = "";
    feedMeta["user_name"] = "ufuk yavuz";
    feedMeta["user_biography"] = "ben nereden geldim gittim";
    feedMeta["user_avatar_url"] = "http://imageordur.com";
    feedMeta["user_university"] = "istanbul universiteesi";
    feedMeta["user_sex"] = true;
    feedMeta["user_is_online"] = true;
    feedMeta["user_is_valid"] = true;

    refAddFeedMeta.set(feedMeta);
    dnm = dnm + 1;
  }
  //refAddFeedMeta.push().set(feedMeta);
}
*/


Future<void> addFeedToTextFeed(int lineValue) async {
  var feedLikes = <dynamic>[];
  //feed no yazabilirsin buralara

  var otoYukleList = <String>[
    "muGDzNlciBcmqNkOKJbGKBCdARl2",
    "LyVbMB8PX7WxC6DoBjYvl2DONSa2",
    "P1VAYg2bo7UDJB1HMHQrQH9sXF52",
    "LCjSaOQOYkNJWry5N50lcdkI5H62",
    "0z932xh1aAf7nrUwFahX7fa6LY13",
    "GOgTAutMRfQWHBRcoBcI35kW3Jo2",
    "0z932xh1aAf7nrUwFahX7fa6LY13",
    "NuWGD6nzsWftdLzKysTjT5NH7Rw1",
    "BXOFFDkTjsRoFtJZSi1rnNRu8GB3",
    "X5lqNUXYhuMX9FzghkTiiJCKZ0i2",
    "WGbPy3ZPwjZIDvBifZLYc57iZd42",
    "YuHFwJmvVbQtRjyCK5V4YSN3Zw93",
    "AoVBxtgJOnMQbiA8ahkDMNIlIgc2",
    "FJu8K7qSSKTwL1TlfgJfaeIjs0i1",
    "Gkh3ypmcFobQv453PhnCnlN6ek92",
    "MeTig6NaYHP3ZOXlOCNmqDiZvM52",
    "QNMBgjwvU3a3YzqZVqBfQq2aYbq2",
    "SiwUiEHFFKS2Cn8yLfut9xdkzdA2",
    "VGMGg1si32gXh3MdzinI3jTO3tJ3"
  ];
/*
   var otoYukleList = <String>[
    "AoVBxtgJOnMQbiA8ahkDMNIlIgc2",
    "FJu8K7qSSKTwL1TlfgJfaeIjs0i1",
    "Gkh3ypmcFobQv453PhnCnlN6ek92",
    "MeTig6NaYHP3ZOXlOCNmqDiZvM52",
    "QNMBgjwvU3a3YzqZVqBfQq2aYbq2",
    "SiwUiEHFFKS2Cn8yLfut9xdkzdA2",
    "VGMGg1si32gXh3MdzinI3jTO3tJ3"
  ];
    */
  otoYukleList.shuffle();
  otoYukleList.shuffle();
  feedLikes.add("start");

  var userFriendsUid = <dynamic>[];

  userFriendsUid.add("MeTig6NaYHP3ZOXlOCNmqDiZvM52");
  userFriendsUid.add("QNMBgjwvU3a3YzqZVqBfQq2aYbq2");

  var userActivities = <dynamic>[];
  userActivities.add("activity1");
  userActivities.add("activity2");
  userActivities.add("activity3");
  userActivities.add("activity4");

  var userInterest = <dynamic>[];
  userInterest.add("martial");
  userInterest.add("pet");
  userInterest.add("chess");
  userInterest.add("camping");
  userInterest.add("travelling");

  var userBlocked = <dynamic>[];
  userBlocked.add("okan");
  userBlocked.add("javier");

  String fileID = const Uuid().v4();

  var feedMeta = HashMap<String, dynamic>();

  feedMeta["feed_time"] = ServerValue.timestamp;
  feedMeta["feed_date"] = DateTime.now().toString();
  feedMeta["feed_no"] = fileID;
  feedMeta["feed_image_url"] = "";
  feedMeta["feed_text"] =
      "SIRA:$lineValue // ${DateTime.now()}: ${otoYukleList.first} ";
  feedMeta["feed_is_image"] = false;
  feedMeta["user_activities"] = userActivities;
  feedMeta["user_interest"] = userInterest;
  feedMeta["like_list"] = feedLikes;
  feedMeta["like_value"] = 0;
  feedMeta["user_friends"] = userFriendsUid;
  feedMeta["user_blocked"] = userBlocked;
  feedMeta["user_uid"] = "${otoYukleList.first}";
  feedMeta["user_name"] = "Tagru Eightplu";
  feedMeta["user_biography"] =
      "Ne kadar değersiz olursa olsun toprak devletin temelidir; hiç kimseye verilemez";
  feedMeta["user_avatar_url"] =
      "https://im.haberturk.com/2014/06/27/ver1578211859/962619_414x414.jpg";
  feedMeta["user_university"] = "Moscow State University";
  feedMeta["user_sex"] = true;
  feedMeta["user_is_online"] = false;
  feedMeta["user_is_valid"] = false;
  feedMeta["user_is_non_binary"] = true;

/*
  for (var a in userFriendsUid) {
    var refAddFeedTimeline = refGetter(
        enum2: RefEnum.Timelineaddfeeds,
        userUid: uid,
        targetUid: a.toString(),
        crypto: fileID);

   await refAddFeedTimeline.set(feedMeta);
  }*/
  var refAddFeedTimeline = refGetter(
      enum2: RefEnum.Feedtofeedtext,
      userUid: otoYukleList.first,
      targetUid: otoYukleList.first,
      crypto: "${DateTime.now().toUtc().millisecondsSinceEpoch}-$fileID");

  refAddFeedTimeline.set(feedMeta);

  //await refAddFeedBase.set(feedMeta);

//base
  // refAddFeedMeta.set(feedMeta);
}




Future<void> addFeedToDatabase()async{

  
}