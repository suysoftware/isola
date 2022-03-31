
class ChaosGroupMembers {
  late String group_members_1_uid;
  late String group_members_2_uid;
  late String group_members_3_uid;
   late String group_members_4_uid;
    late String group_members_5_uid;
     late String group_members_6_uid;



   ChaosGroupMembers(this.group_members_1_uid,this.group_members_2_uid,this.group_members_3_uid,this.group_members_4_uid,this.group_members_5_uid,this.group_members_6_uid);

  factory ChaosGroupMembers.fromJson(Map<dynamic, dynamic> json) {
    return ChaosGroupMembers(
      json["group_members_1_uid"] as String,
      json["group_members_2_uid"] as String,
      json["group_members_3_uid"]as String,
      json["group_members_4_uid"] as String,
      json["group_members_5_uid"] as String,
      json["group_members_6_uid"]as String,
   
    );
  }
}
