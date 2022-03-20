// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/like_feeds.dart';
import 'package:isola_app/src/service/hive/hive_likes.dart';

var hiveOperations = HiveOperations();

Future<void> likeFeed({
  required IsolaFeedModel feedMeta,
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

  if (feedMeta.likeList.contains(userUid)) {
  } else {
    await likeAddToPool(feedNo, userUid, true, targetUid);
  }
}

Future<void> unLikeFeed({
  required String targetUid,
  required String userUid,
  required String feedNo,
  required IsolaFeedModel feedMeta,
}) async {
  var box = await Hive.openBox('userHive');

  UserHive userHive = box.get('datetoday');



  if (userHive.likesData.contains(feedNo)) {
    await hiveOperations.likeDelete(feedNo);
  }

  await likeAddToPool(feedNo, userUid, false, targetUid).whenComplete(() {
    print('komplete');
  });


}
