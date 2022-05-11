import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsModel {
  late int ads_watcher_total;
  late int chaos_online;
  late int chaos_searching;
  late int chaos_total;
  late int country_total;
  late int group_active;
  late int group_female;
  late int group_male;
  late int group_other;
  late int group_total;
  late int group_waiting;
  late int group_female_active;
  late int group_male_active;
  late int group_other_active;
  late int image_total;
  late int like_total;
  late int messages_total;
  late int rater_total;
  late int report_101_value;
  late int report_102_value;
  late int report_103_value;
  late int report_104_value;
  late int report_105_value;
  late int stats_date;
  late int text_total;
  late int token_total;
  late List<dynamic> university_top5;
  late int university_total;
  late int university_used;
  late int users_female;
  late int users_male;
  late int users_online;
  late int users_other;
  late int users_searching;
  late int users_total;
  late int users_unvalid;
  late int users_valid;

  StatisticsModel(this.ads_watcher_total,this.chaos_online,this.chaos_searching,this.chaos_total,this.country_total,this.group_active,this.group_female,this.group_male,this.group_other,this.group_total,this.group_waiting,this.group_female_active,this.group_male_active,this.group_other_active,this.image_total,this.like_total,this.messages_total,this.rater_total,this.report_101_value,this.report_102_value,this.report_103_value,this.report_104_value,this.report_105_value,this.stats_date,this.text_total,this.token_total,this.university_top5,this.university_total,this.university_used,this.users_female,this.users_male,this.users_online,this.users_other,this.users_searching,this.users_total,this.users_unvalid,this.users_valid);

  StatisticsModel.fromJson(Map<String, dynamic>json)
      : this(
          json["ads_watcher_total"] as int,
          json["chaos_online"] as int,
          json["chaos_searching"] as int,
          json["chaos_total"] as int,
          json["country_total"] as int,
          json["group_active"] as int,
          json["group_female"] as int,
          json["group_male"] as int,
          json["group_other"] as int,
          json["group_total"] as int,
          json["group_waiting"] as int,
          json["group_female_active"] as int,
          json["group_male_active"] as int,
          json["group_other_active"] as int,
          json["image_total"] as int,
          json["like_total"] as int,
          json["messages_total"] as int,
          json["rater_total"] as int,
          json["report_101_value"] as int,
          json["report_102_value"] as int,
          json["report_103_value"] as int,
          json["report_104_value"] as int,
          json["report_105_value"] as int,
          json["stats_date"] as int,
          json["text_total"] as int,
          json["token_total"] as int,
          json["university_top5"] as List<dynamic>,
          json["university_total"] as int,
          json["university_used"] as int,
          json["users_female"] as int,
          json["users_male"] as int,
          json["users_online"] as int,
          json["users_other"] as int,
          json["users_searching"] as int,
          json["users_total"] as int,
          json["users_unvalid"] as int,
          json["users_valid"] as int,

        );

  Map<String, dynamic> toJson() {
    return {
"ads_watcher_total":ads_watcher_total,
"chaos_online":chaos_online,
"chaos_searching":chaos_searching,
"chaos_total":chaos_total,
"country_total":country_total,
"group_active":group_active,
"group_female":group_female,
"group_male":group_male,
"group_other":group_other,
"group_total":group_total,
"group_waiting":group_waiting,
"group_female_active":group_female_active,
"group_male_active":group_male_active,
"group_other_active":group_other_active,
"image_total":image_total,
"like_total":like_total,
"messages_total":messages_total,
"rater_total":rater_total,
"report_101_value":report_101_value,
"report_102_value":report_102_value,
"report_103_value":report_103_value,
"report_104_value":report_104_value,
"report_105_value":report_105_value,
"stats_date":stats_date,
"text_total":text_total,
"token_total":token_total,
"university_top5":university_top5,
"university_total":university_total,
"university_used":university_used,
"users_female":users_female,
"users_male":users_male,
"users_online":users_online,
"users_other":users_other,
"users_searching":users_searching,
"users_total":users_total,
"users_unvalid":users_unvalid,
"users_valid":users_valid
    };
  }
}
