class GroupsModel {
  late bool groupIsActive;
  late int groupMemberValue;
  late bool groupNeedMember;
  late bool groupSexType;
  late bool groupIsNonBinary;
  late bool groupTargetIsValid;
  late int groupToken;
  late List<dynamic> groupMemberList;

  GroupsModel(
      this.groupIsActive,
      this.groupMemberValue,
      this.groupNeedMember,
      this.groupSexType,
      this.groupIsNonBinary,
      this.groupTargetIsValid,
      this.groupToken,
      this.groupMemberList);

  factory GroupsModel.fromJson(Map<dynamic, dynamic> json) {
    return GroupsModel(
        json["group_is_active"] as bool,
        json["group_member_value"] as int,
        json["group_need_member"] as bool,
        json["group_sex_type"] as bool,
        json["group_is_non_binary"] as bool,
        json["group_target_is_valid"] as bool,
        json["group_token"] as int,
        json["group_member_list"] as List<dynamic>);
  }
}
