import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';

exploreHistoryItemsSave(
    List<String> targetFeedNoList, String whichGroup) async {
  var box = await Hive.openBox('userHive');

  UserHive userHive = box.get('datetoday');
  for (var item in targetFeedNoList) {
    if (userHive.exloreData.contains(item) == false) {
      userHive.exloreData.add(item);
    }
  }

  box.put('datetoday', userHive);
}

Future<List<dynamic>> exploreHistoryGetter(String whichGroup) async {
  var box = await Hive.openBox('userHive');
  UserHive userHive = box.get('datetoday');

  return userHive.exloreData;
}

exploreHistoryItemDelete(String feedNo) async {
  var box = await Hive.openBox('userHive');
  UserHive userHive = box.get('datetoday');
  userHive.exloreData.remove(feedNo);
  box.put('datetoday', userHive);
}
