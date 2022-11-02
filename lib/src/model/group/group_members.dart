// ignore_for_file: non_constant_identifier_names

class GroupMembers {
  late String group_members_1_uid;
  late String group_members_2_uid;
  late String group_members_3_uid;



   GroupMembers(this.group_members_1_uid,this.group_members_2_uid,this.group_members_3_uid);

  factory GroupMembers.fromJson(Map<dynamic, dynamic> json) {
    return GroupMembers(
      json["group_members_1_uid"] as String,
      json["group_members_2_uid"] as String,
      json["group_members_3_uid"]as String,
   
    );
  }
}
