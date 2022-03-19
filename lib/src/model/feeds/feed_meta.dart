import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isola_app/src/model/user/user_display.dart';

class FeedMeta {
  late int feedTime;
  late String feedDate;
  late String feedNo;
  late String feedImageUrl;
  late String feedText;
  late bool feedIsImage;
  late List<dynamic> likeList;
  late int likeValue;
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

  FeedMeta(
      this.feedTime,
      this.feedDate,
      this.feedNo,
      this.feedImageUrl,
      this.feedText,
      this.feedIsImage,
      this.likeList,
      this.likeValue,
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

  factory FeedMeta.fromJson(Map<dynamic, dynamic> json) {
    return FeedMeta(
      json["feed_time"] as int,
      json["feed_date"] as String,
      json["feed_no"] as String,
      json["feed_image_url"] as String,
      json["feed_text"] as String,
      json["feed_is_image"] as bool,
      json["like_list"] as List<dynamic>,
      json["like_value"] as int,
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

class IsolaFeedModel {
  late Timestamp feedDate;
  late String feedNo;
  late String feedText;
  late List<dynamic> likeList;
  late int likeValue;
  late String userAvatarUrl;
  late String userName;
  late String userUid;

  IsolaFeedModel(this.feedDate, this.feedNo, this.feedText, this.likeList,
      this.likeValue, this.userAvatarUrl, this.userName, this.userUid);

  IsolaFeedModel.fromJson(Map<String, dynamic> json)
      : this(
            json["feed_date"] as Timestamp,
            json["feed_no"] as String,
            json["feed_text"] as String,
            json["like_list"] as List<dynamic>,
            json["like_value"] as int,
            json["user_avatar_url"] as String,
            json["user_name"] as String,
            json["user_uid"] as String);

  Map<String, dynamic> toJson() {
    return {
      "feed_date": feedDate,
      "feed_no": feedNo,
      "feed_text": feedText,
      "like_list": likeList,
      "like_value": likeValue,
      "user_avatar_url": userAvatarUrl,
      "user_name": userName,
      "user_uid": userUid
    };
  }
}
