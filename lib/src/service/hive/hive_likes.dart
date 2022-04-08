// ignore_for_file: await_only_futures, avoid_print, unused_local_variable

import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';

class HiveOperations {
  likeDataSetter() async {
    var box = await Hive.box('userHive');
    var likesList = <String>[];
    likesList.add("likes1");
    likesList.add("likes2");
    likesList.add("likes3");
    likesList.add("likes4");
    likesList.add("likes0");
    var exploreList = <String>[];
    exploreList.add("explores0");
    exploreList.add("explores1");
    exploreList.add("explores2");
    exploreList.add("explores3");
    exploreList.add("explores4");
    exploreList.add("explores5");
    var senderData = UserHive(likesData: likesList, exloreData: exploreList);
    box.put('datetoday', senderData);
  }

  likeDataGetter() async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');
  }

  Future<UserHive> likeDataReturner() async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');

    return userHive;
  }

  singleLikeSetter(String feedNo) async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');
  }

  likeDelete(String feedNo) async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');
    bool cvp = userHive.likesData.contains('likes42');

    userHive.likesData.remove(feedNo);
    box.put('datetoday', userHive);
  }

  likeSave(String feedNo) async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');
    userHive.likesData.add(feedNo);
    box.put('datetoday', userHive);
  }
}
