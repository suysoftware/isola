// ignore_for_file: non_constant_identifier_names

class GroupMeta {
  late String group_member_1_uid;
  late String group_member_2_uid;
  late String group_member_3_uid;
  late int group_token;

  GroupMeta(this.group_member_1_uid, this.group_member_2_uid,
      this.group_member_3_uid, this.group_token);

factory GroupMeta.fromJson(Map<dynamic, dynamic> json) {
    return GroupMeta(
      json["group_members_1_uid"] as String,
      json["group_members_2_uid"] as String,
      json["group_members_3_uid"]as String,
      json["group_token"]as int,
    );
  }

}
