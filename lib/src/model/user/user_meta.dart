class UserMeta {
  late String userEmail;
  late int userToken;
  late double userLocLongitude;
  late double userLocLatitude;
  late List<dynamic> joinedGroupList;

  UserMeta(this.userEmail, this.userToken, this.userLocLongitude,
      this.userLocLatitude, this.joinedGroupList);

  factory UserMeta.fromJson(Map<dynamic, dynamic> json) {
    return UserMeta(
        json["user_email"] as String,
        json["user_token"] as int,
        json["user_loc_longitude"] as double,
        json["user_loc_latitude"] as double,
        json["joined_group_list"] as List<dynamic>);
  }
}

class IsolaUserMeta {
  late String userEmail;
  late int userToken;
  late List<dynamic> joinedGroupList;
  late String userUid;
  late bool userIsValid;
  late List<dynamic> userFriends;
  late List<dynamic> userBlocked;
  late List<dynamic> userActivityClubs;
  late bool userIsSearching;
  late List<dynamic> userFriendOrders;

  IsolaUserMeta(
    this.userEmail,
    this.userToken,
    this.joinedGroupList,
    this.userUid,
    this.userIsValid,
    this.userFriends,
    this.userBlocked,
    this.userActivityClubs,
    this.userIsSearching,
    this.userFriendOrders
  );

  factory IsolaUserMeta.fromJson(Map<dynamic, dynamic> json) {
    return IsolaUserMeta(
      json["uEmail"] as String,
      json["uToken"] as int,
      json["uGroupList"] as List<dynamic>,
      json["uUid"] as String,
      json["uValid"] as bool,
      json["uFriends"] as List<dynamic>,
      json["uBlocked"] as List<dynamic>,
      json["uClubs"] as List<dynamic>,
      json["uSearching"] as bool,
      json["uFriendOrders"] as List<dynamic>,
    );
  }
}
