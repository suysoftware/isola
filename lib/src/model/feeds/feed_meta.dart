import 'package:cloud_firestore/cloud_firestore.dart';

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
