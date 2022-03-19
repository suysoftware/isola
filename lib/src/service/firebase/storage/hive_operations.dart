// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/service/hive/hive_likes.dart';

var hiveOperations = HiveOperations();

Future<void> likeFeed(
    {required IsolaFeedModel feedMeta,
    required String targetUid,
    required String userUid,
    required String feedNo,
    }) async {
  var box = await Hive.openBox('userHive');
  if (box.isNotEmpty) {
    UserHive userHive = box.get('datetoday');
    if (userHive.likesData.contains(feedNo) == false) {
      await hiveOperations.likeSave(feedNo);
    }
  } else {
    await hiveOperations.likeDataSetter();
  }
  print("likela");

  var refLike = refGetter(
      enum2: RefEnum.LikeIt,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);

  var refLikeSave = refGetter(
      enum2: RefEnum.LikeSave,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);
  var refLikeList = refGetter(
      enum2: RefEnum.Likelist,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);
  print("xxx");
  print(feedMeta.likeList);
  if (feedMeta.likeList.contains(userUid)) {
    print("yyy");
    Query query = refLikeSave;
    DataSnapshot snap = await query.get();
    print("fff");
    if (snap.exists) {
      print("zaten likelısın aga");
    } else {
      print("fsafsa");
      if (feedMeta.likeList.length - 1 > feedMeta.likeValue) {
        print("like vakti");
        await refLike.set(feedMeta.likeValue + 1);
        await refLikeSave.set(DateTime.now().toString());
      }
    }
  } else {
    print("likenafg");
    refLikeList.child("${feedMeta.likeList.length}").set(userUid);
    print("likeladık");
    await refLike.set(feedMeta.likeValue + 1);
    await refLikeSave.set(DateTime.now().toString());
  }
}

Future<void> unLikeFeed(
    {required String targetUid,
    required String userUid,
    required String feedNo,
    required IsolaFeedModel feedMeta,
    }) async {
  var box = await Hive.openBox('userHive');

  UserHive userHive = box.get('datetoday');

  var refLikeSave = refGetter(
      enum2: RefEnum.LikeSave,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);
  var refLike = refGetter(
      enum2: RefEnum.LikeIt,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);
  var refLikeList = refGetter(
      enum2: RefEnum.Likelist,
      targetUid: targetUid,
      userUid: userUid,
      crypto: feedNo);

  if (userHive.likesData.contains(feedNo)) {
    await hiveOperations.likeDelete(feedNo);
  }

  if (feedMeta.likeList.contains(userUid)) {
    Query query = refLikeSave;
    Query queryTargetLikeList = refLikeList;
    DataSnapshot snap = await query.get();
    DataSnapshot snap2 = await queryTargetLikeList.get();

    if (snap.exists) {
      print("eksiltti");
      refLike.set(feedMeta.likeValue - 1);
      var likeList1 = <dynamic>[];

      var likeListt = snap2.value as List<dynamic>;

      likeList1.addAll(likeListt);
      print(likeListt);
      likeList1.remove(userUid);
      refLikeSave.remove();
      refLikeList.set(likeList1);
    } else {}
  } else {}
}


