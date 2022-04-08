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
      this.userLikeHistory,
      this.userDatabaseToken);

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
        json["uLike"] as List<dynamic>,
        json["uDbToken"] as String);
  }
}
