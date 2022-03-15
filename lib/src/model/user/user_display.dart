import 'package:cloud_firestore/cloud_firestore.dart';

class UserDisplay {
  late String userUid;
  late String userName;
  late String userBiography;
  late String avatarUrl;
  late String userUniversity;
  late bool userSex;
  late bool userIsOnline;
  late bool userIsValid;
  late List<dynamic> userActivities;
  late List<dynamic> userInterest;
  late List<dynamic> userFriends;
  late List<dynamic> userBlocked;
  late bool userIsNonBinary;

  UserDisplay(
      this.userUid,
      this.userName,
      this.userBiography,
      this.avatarUrl,
      this.userUniversity,
      this.userSex,
      this.userIsOnline,
      this.userIsValid,
      this.userActivities,
      this.userInterest,
      this.userFriends,
      this.userBlocked,
      this.userIsNonBinary);

  factory UserDisplay.fromJson(Map<dynamic, dynamic> json) {
    return UserDisplay(
      json["user_uid"] as String,
      json["user_name"] as String,
      json["user_biography"] as String,
      json["user_avatar_url"] as String,
      json["user_university"] as String,
      json["user_sex"] as bool,
      json["user_is_online"] as bool,
      json["user_is_valid"] as bool,
      json["user_activities"] as List<dynamic>,
      json["user_interest"] as List<dynamic>,
      json["user_friends"] as List<dynamic>,
      json["user_blocked"] as List<dynamic>,
      json["user_is_non_binary"] as bool,
    );
  }
}

class IsolaUserDisplay {
  late String userName;
  late String userBiography;
  late String avatarUrl;
  late bool userSex;
  late bool userIsOnline;
  late List<dynamic> userInterest;
  late bool userIsNonBinary;
  late String userUniversity;
  late List<dynamic> userActivities;
  late List<dynamic> userLikeHistory;
   late String userDatabaseToken;

  IsolaUserDisplay(
      this.userName,
      this.userBiography,
      this.avatarUrl,
      this.userSex,
      this.userIsOnline,
      this.userInterest,
      this.userIsNonBinary,
      this.userUniversity,
      this.userActivities,
      this.userLikeHistory,this.userDatabaseToken);

  factory IsolaUserDisplay.fromJson(Map<dynamic, dynamic> json) {
    return IsolaUserDisplay(
        json["uName"] as String,
        json["uBio"] as String,
        json["uPic"] as String,
        json["uSex"] as bool,
        json["uOnline"] as bool,
        json["uInterest"] as List<dynamic>,
        json["uNonBinary"] as bool,
        json["uUniversity"] as String,
        json["uAct"] as List<dynamic>,
        json["uLike"] as List<dynamic>, json["uDbToken"] as String);
  }
}
