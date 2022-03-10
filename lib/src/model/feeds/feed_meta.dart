import 'package:isola_app/src/model/user/user_display.dart';

class FeedMeta extends UserDisplay {
  late int feedTime;
  late String feedDate;
  late String feedNo;
  late String feedImageUrl;
  late String feedText;
  late bool feedIsImage;
  late List<dynamic> likeList;
  late int likeValue;

  FeedMeta(
      this.feedTime,
      this.feedDate,
      this.feedNo,
      this.feedImageUrl,
      this.feedText,
      this.feedIsImage,
      this.likeList,
      this.likeValue,
      String userUid,
      String userName,
      String userBiography,
      String avatarUrl,
      String userUniversity,
      bool userSex,
      bool userIsOnline,
      bool userIsValid,
      List<dynamic> userActivities,
      List<dynamic> userInterest,
      List<dynamic> userFriends,
      List<dynamic> userBlocked,bool userIsNonBinary)
      : super(
            userUid,
            userName,
            userBiography,
            avatarUrl,
            userUniversity,
            userSex,
            userIsOnline,
            userIsValid,
            userActivities,
            userInterest,
            userFriends,
            userBlocked,userIsNonBinary);

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
      json["user_is_non_binary"]as bool,
    );
  }
}
