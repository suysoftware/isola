import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';

exploreHistoryItemsSave(
    List<String> targetFeedNoList, String whichGroup) async {
  //print(targetFeedNoList);
  var box = await Hive.openBox('userHive');

  UserHive userHive = box.get('datetoday');
  for (var item in targetFeedNoList) {
    if (userHive.exloreData.contains(item) == false) {
      userHive.exloreData.add(item);
    }
  }
  //print(userHive.exloreData.length);
  //userHive.exloreData.addAll(targetFeedNoList);
  // = targetFeedNoList;
  // userHive.exloreData = targetFeedNoList;

  // UserHive userHive = box.get('datetoday');
  // userHive.exloreData.addAll(targetFeedNoList);

  //userHive.exloreData.
  //box.put('datetoday', userHive);
  box.put('datetoday', userHive);
}

Future<List<dynamic>> exploreHistoryGetter(String whichGroup) async {
  var box = await Hive.openBox('userHive');
  UserHive userHive = box.get('datetoday');

  return userHive.exloreData;
  //print(userHive.exloreData);
}

exploreHistoryItemDelete(String feedNo) async {
  var box = await Hive.openBox('userHive');
  UserHive userHive = box.get('datetoday');
  userHive.exloreData.remove(feedNo);
  box.put('datetoday', userHive);
}





  /*
Future<void> updateExploreData(
    List<String> targetFeedNoList, String targetUid, String uid) async {
  var refAddUserDisplay = refGetter(
      enum2: RefEnum.Userexploredata,
      userUid: targetUid,
      targetUid: uid,
      crypto: "");

  var comingValue = <dynamic>[];
  try {
    explorerDataGetter(uid).then((value) {
      comingValue.addAll(value);
      comingValue.addAll(targetFeedNoList);
      refAddUserDisplay.set(comingValue.toSet().toList());
    });
  } catch (e) {
    print("hata");
  }
}

Future<List> explorerDataGetter(String uid) async {
  var refExplorerDataGetter = refGetter(
      enum2: RefEnum.Userexploredata, userUid: uid, targetUid: uid, crypto: "");

  dynamic comingValue;

  await refExplorerDataGetter
      .once()
      .then((snapshot) => comingValue = snapshot.snapshot.value);

  // dynamic searchHistory = eventDb.snapshot.value;
  var searchHistory = comingValue;

  // print(searchHistory);
  return searchHistory;
}
*/