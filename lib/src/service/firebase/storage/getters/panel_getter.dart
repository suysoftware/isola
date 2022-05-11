import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../model/app_settings/statistics_model.dart';

Future<StatisticsModel> panelCurrentStatisticsGetter() async {
  var panelCurrentData;

  var panelCurrentRef = FirebaseFirestore.instance
      .collection('panel_statistics')
      .doc('isola_stats')
      .collection('current_stats')
      .doc('stats_now');

  await panelCurrentRef.get().then((value) => panelCurrentData =
      StatisticsModel(
          value["ads_watcher_total"],
          value["chaos_online"],
          value["chaos_searching"],
          value["chaos_total"],
          value["country_total"],
          value["group_active"],
          value["group_female"],
          value["group_male"],
          value["group_other"],
          value["group_total"],
          value["group_waiting"],
          value["group_female_active"],
          value["group_male_active"],
          value["group_other_active"],
          value["image_total"],
          value["like_total"],
          value["messages_total"],
          value["rater_total"],
          value["report_101_value"],
          value["report_102_value"],
          value["report_103_value"],
          value["report_104_value"],
          value["report_105_value"],
          value["stats_date"],
          value["text_total"],
          value["token_total"],
          value["university_top5"],
          value["university_total"],
          value["university_used"],
          value["users_female"],
          value["users_male"],
          value["users_online"],
          value["users_other"],
          value["users_searching"],
          value["users_total"],
          value["users_unvalid"],
          value["users_valid"]));

  return panelCurrentData;
}
