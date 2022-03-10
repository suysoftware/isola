// ignore_for_file: non_constant_identifier_names

class GroupChaos {
  late String chaosNo;
  late bool isChaosAlive;
  late int lastChaosTime;
  late bool member_1_apply;
  late bool member_2_apply;
  late bool member_3_apply;
  late bool chaosSexOption;
  late bool chaosIsNonBinary;
  late bool chaosIsValid;
  late bool chaos_is_canceled;
  late bool chaos_is_searching;

  GroupChaos(
      this.chaosNo,
      this.isChaosAlive,
      this.lastChaosTime,
      this.member_1_apply,
      this.member_2_apply,
      this.member_3_apply,
      this.chaosSexOption,
      this.chaosIsNonBinary,
      this.chaosIsValid,
      this.chaos_is_canceled,this.chaos_is_searching);

  factory GroupChaos.fromJson(Map<dynamic, dynamic> json) {
    return GroupChaos(
        json["chaos_no"] as String,
        json["chaos_is_alive"] as bool,
        json["last_chaos_time"] as int,
        json["member_1_apply"] as bool,
        json["member_2_apply"] as bool,
        json["member_3_apply"] as bool,
        json["chaos_sex_option"] as bool,
        json["chaos_is_non_binary"] as bool,
        json["chaos_is_valid"] as bool,
        json["chaos_is_canceled"] as bool,
        json["chaos_is_searching"]as bool );
  }
}
