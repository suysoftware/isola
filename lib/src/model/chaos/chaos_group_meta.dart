import 'package:cloud_firestore/cloud_firestore.dart';

class ChaosGroupMeta {
  late Timestamp createdTime;
  late Timestamp finishTime;
  late Timestamp finishWithBonusTime;
  late bool timeBonus;
  late bool chaosIsComplete;

  ChaosGroupMeta(this.createdTime, this.finishTime, this.finishWithBonusTime,
      this.timeBonus, this.chaosIsComplete);

  ChaosGroupMeta.fromJson(Map<String, dynamic> json)
      : this(
            json["created_time"] as Timestamp,
            json["finish_time"] as Timestamp,
            json["finish_with_bonus_time"] as Timestamp,
            json["time_bonus"] as bool,
            json["chaos_is_complete" as bool]);
  Map<String, dynamic> toJson() {
    return {
      'created_time': createdTime,
      'finish_time': finishTime,
      'finish_with_bonus_time': finishWithBonusTime,
      'time_bonus': timeBonus,
      'chaos_is_complete': chaosIsComplete
    };
  }
}
