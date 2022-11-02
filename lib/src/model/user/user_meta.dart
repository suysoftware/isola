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
      this.userFriendOrders);

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
