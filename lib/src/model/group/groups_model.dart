class GroupsModel {
  late bool groupIsActive;
  late int groupMemberValue;
  late bool groupNeedMember;
  late bool groupSexType;
  late bool groupIsNonBinary;
  late bool groupTargetIsValid;
  late int groupToken;
  late List<dynamic> groupMemberList;
  late String groupNo;
  late bool groupChaosIsActive;
  late String groupChaosNo;
  late bool groupChaosSearching;

  GroupsModel(
      this.groupIsActive,
      this.groupMemberValue,
      this.groupNeedMember,
      this.groupSexType,
      this.groupIsNonBinary,
      this.groupTargetIsValid,
      this.groupToken,
      this.groupMemberList,
      this.groupNo,
      this.groupChaosIsActive,
      this.groupChaosNo,
      this.groupChaosSearching);

  GroupsModel.fromJson(Map<String, dynamic> json)
      : this(
          json["gActive"] as bool,
          json["gValue"] as int,
          json["gNeed"] as bool,
          json["gSex"] as bool,
          json["gNonBinary"] as bool,
          json["gValid"] as bool,
          json["gToken"] as int,
          json["gList"] as List<dynamic>,
          json["gNo"] as String,
          json["gChaos"] as bool,
          json["gChaosNo"] as String,
          json["gChaosSearching"] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'gActive': groupIsActive,
      'gValue': groupMemberValue,
      'gNeed': groupNeedMember,
      'gSex': groupSexType,
      'gNonBinary': groupIsNonBinary,
      'gValid': groupTargetIsValid,
      'gToken': groupToken,
      'gList': groupMemberList,
      'gNo': groupNo,
      'gChaos': groupChaosIsActive,
      'gChaosNo': groupChaosNo,
      'gChaosSearching': groupChaosSearching,
    };
  }
}
