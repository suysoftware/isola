// ignore_for_file: non_constant_identifier_names

class GroupDisplay {
  late int group_member_value;
  late bool group_need_member;
  late String group_no;
  late String group_sex_type;
  late bool group_target_isvalid;
  late List<dynamic> group_need_list;

  GroupDisplay(this.group_member_value, this.group_need_member, this.group_no,
      this.group_sex_type, this.group_target_isvalid,this.group_need_list);

  factory GroupDisplay.fromJson(Map<dynamic, dynamic> json) {
    return GroupDisplay(
      json["group_member_value"] as int,
      json["group_need_member"] as bool,
      json["group_no"] as String,
      json["group_sex_type"] as String,
      json["group_target_isvalid"] as bool,
      json["group_need_list"]as List<dynamic>,
    );
  }
}
