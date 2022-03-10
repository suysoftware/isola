// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';

Future<UserHive> userHiveGet(String userUid) async {
  var history = <String>[];
  var likeList;
  history.add("");

  var likeDataRef = refGetter(
      enum2: RefEnum.LikeGet, targetUid: "", userUid: userUid, crypto: "");

  likeDataRef.once().then((value) => likeList = value.snapshot.value);

  return likeList;
}
