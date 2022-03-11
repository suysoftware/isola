import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:uuid/uuid.dart';

Future<void> addSearchPageFeed(
    IsolaUserAll userAll, String imageFeedUrl, String feedNo) async {
  var feedLikes = <dynamic>[];

  feedLikes.add("start");

  var refAddFeedMeta = refGetter(
      enum2: RefEnum.Searchfeeds,
      userUid: userAll.isolaUserMeta.userUid,
      targetUid: userAll.isolaUserMeta.userUid,
      crypto: feedNo);
  var feedMeta = HashMap<String, dynamic>();

  feedMeta["feed_time"] = ServerValue.timestamp;
  feedMeta["feed_date"] = DateTime.now().toString();
  feedMeta["feed_no"] = feedNo;
  feedMeta["feed_image_url"] = imageFeedUrl;
  feedMeta["feed_text"] = "";
  feedMeta["feed_is_image"] = true;
  feedMeta["user_activities"] = userAll.isolaUserDisplay.userActivities;
  feedMeta["user_interest"] = userAll.isolaUserDisplay.userInterest;
  feedMeta["like_list"] = feedLikes;
  feedMeta["like_value"] = 0;
  feedMeta["user_friends"] = userAll.isolaUserMeta.userFriends;
  feedMeta["user_blocked"] = userAll.isolaUserMeta.userBlocked;
  feedMeta["user_uid"] = userAll.isolaUserMeta.userUid;
  feedMeta["user_name"] = userAll.isolaUserDisplay.userName;
  feedMeta["user_biography"] = userAll.isolaUserDisplay.userBiography;
  feedMeta["user_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
  feedMeta["user_university"] = userAll.isolaUserDisplay.userUniversity;
  feedMeta["user_sex"] = userAll.isolaUserDisplay.userSex;
  feedMeta["user_is_online"] = userAll.isolaUserDisplay.userIsOnline;
  feedMeta["user_is_valid"] = userAll.isolaUserMeta.userIsValid;
  feedMeta["user_is_non_binary"] = userAll.isolaUserDisplay.userIsNonBinary;

  refAddFeedMeta.set(feedMeta);
}

Future<String> uploadImage(
  String userUid,
  File image,
  String feedNo,
) async {
  String urlImage = "";
  var refStorage = FirebaseStorage.instance
      .ref()
      .child("search_items")
      .child(userUid)
      .child(feedNo);

  UploadTask uploadTask = refStorage.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask;
  await taskSnapshot.ref.getDownloadURL().then((value) => urlImage = value);

  return urlImage;
}

Future<void> addSearchPageFeed100(
  String uid,
) async {
  var feedLikes = <dynamic>[];
  //feed no yazabilirsin buralara

  feedLikes.add("start");

  var userFriendsUid = <dynamic>[];

  userFriendsUid.add("d");

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
  var userFriends = <String>[];
  userFriends.add("hüseyin");
  userFriends.add("emirhan");
  userFriends.add("keremhan");
  userFriends.add("recepcan");

  var userBlocked = <String>[];
  userBlocked.add("okan");
  userBlocked.add("javier");

  int dnm = 900;
  for (int i = 900; i < 950; i++) {
    String fileID = const Uuid().v4();
    var refAddFeedMeta = refGetter(
        enum2: RefEnum.Searchfeeds,
        userUid: uid,
        targetUid: uid,
        crypto: fileID);
    var feedMeta = HashMap<String, dynamic>();
    feedMeta["feed_time"] = ServerValue.timestamp;
    feedMeta["feed_date"] = "22.22.22";
    feedMeta["feed_no"] = fileID;
    feedMeta["feed_image_url"] = "https://picsum.photos/400/400?random=$dnm";
    feedMeta["feed_text"] = "";
    feedMeta["feed_is_image"] = true;
    feedMeta["user_activities"] = activites;
    feedMeta["user_interest"] = interest;
    feedMeta["like_list"] = feedLikes;
    feedMeta["like_value"] = 0;
    feedMeta["user_friends"] = userFriends;
    feedMeta["user_blocked"] = userBlocked;
    feedMeta["user_uid"] = "useruid";
    feedMeta["user_name"] = "username";
    feedMeta["user_biography"] = "userbio";
    feedMeta["user_avatar_url"] = "user avatar";
    feedMeta["user_university"] = "user university";
    feedMeta["user_sex"] = true;
    feedMeta["user_is_online"] = true;
    feedMeta["user_is_valid"] = true;
    feedMeta["user_is_non_binary"] = false;
/*
  for (var a in userFriendsUid) {
    var refAddFeedTimeline = refGetter(
        enum2: RefEnum.Timelineaddfeeds,
        userUid: uid,
        targetUid: a.toString(),
        crypto: fileID);

   await refAddFeedTimeline.set(feedMeta);
  }*/
    refAddFeedMeta.set(feedMeta);
    print(dnm);

    dnm = dnm + 1;
  }
  //refAddFeedMeta.push().set(feedMeta);

  //await refAddFeedBase.set(feedMeta);

//base
  // refAddFeedMeta.set(feedMeta);
}
