import 'package:cloud_firestore/cloud_firestore.dart';

class IsolaImageFeedModel {
  late Timestamp feedDate;
  late String feedNo;
  late String feedImageUrl;
  late List<dynamic> likeList;
  late int likeValue;
  late String userAvatarUrl;
  late String userName;
  late String userUid;
  late GeoPoint userLoc;
  late bool feedVisibility;
  late int feedReportValue;
  late String userUniversity;
  late int feedToken;
  late List<dynamic> feedTokenList;

  IsolaImageFeedModel(
      this.feedDate,
      this.feedNo,
      this.feedImageUrl,
      this.likeList,
      this.likeValue,
      this.userAvatarUrl,
      this.userName,
      this.userUid,
      this.userLoc,
      this.feedVisibility,
      this.feedReportValue,
      this.userUniversity,this.feedToken,this.feedTokenList);

  IsolaImageFeedModel.fromJson(Map<String, dynamic> json)
      : this(
            json["feed_date"] as Timestamp,
            json["feed_no"] as String,
            json["feed_image"] as String,
            json["like_list"] as List<dynamic>,
            json["like_value"] as int,
            json["user_avatar_url"] as String,
            json["user_name"] as String,
            json["user_uid"] as String,
            json["user_loc"] as GeoPoint,
            json["feed_visibility"] as bool,
            json["feed_report_value"] as int,
            json["user_university"] as String,
            json["feed_token"]as int,
            json["feed_token_list"] as List<dynamic>,
            );

  Map<String, dynamic> toJson() {
    return {
      "feed_date": feedDate,
      "feed_no": feedNo,
      "feed_image": feedImageUrl,
      "like_list": likeList,
      "like_value": likeValue,
      "user_avatar_url": userAvatarUrl,
      "user_name": userName,
      "user_uid": userUid,
      "user_loc": userLoc,
      "feed_visibility": feedVisibility,
      "feed_report_value": feedReportValue,
      "user_university": userUniversity,
      "feed_token":feedToken,
      "feed_token_list":feedTokenList
    };
  }
}
