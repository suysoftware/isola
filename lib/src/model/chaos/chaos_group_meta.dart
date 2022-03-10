class ChaosGroupMeta {
  late int createdTime;
  late int finishTime;
  late int finishWithBonusTime;
  late bool timeBonus;
  late bool chaosIsComplete;

  ChaosGroupMeta(this.createdTime, this.finishTime, this.finishWithBonusTime,
      this.timeBonus,this.chaosIsComplete);

  factory ChaosGroupMeta.fromJson(Map<dynamic, dynamic> json) {
    return ChaosGroupMeta(
        json["created_time"] as int,
        json["finish_time"] as int,
        json["finish_with_bonus_time"] as int,
        json["time_bonus"] as bool,
        json["chaos_is_complete" as bool]);
  }
}
