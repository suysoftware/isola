import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/user/user_all.dart';

import '../model/group/groups_model.dart';
import '../model/user/user_display.dart';
import '../model/user/user_meta.dart';

class GroupMergeCubit extends Cubit<GroupMergeData> {
  var userDisplay = IsolaUserDisplay(
      "null",
      "null",
      "null",
      true,
      true,
      ["interest1", "interest2"],
      true,
      "null",
      ["null1", "null2"],
      ["null1", "null2"],
      "");
  var userMeta = IsolaUserMeta(
      "null",
      0,
      ["null", "null"],
      "null",
      true,
      ["null", "null"],
      ["null", "null"],
      ["null", "null"],
      false,
      ["null", "null"]);
  var groupsModelInit = GroupsModel(
      true, 2, true, true, true, true, 1, [], "0ainitgroup", false, "", false);
  GroupMergeCubit()
      : super(GroupMergeData(
            IsolaUserAll(
                IsolaUserDisplay(
                    "null",
                    "null",
                    "null",
                    true,
                    true,
                    ["interest1", "interest2"],
                    true,
                    "null",
                    ["null1", "null2"],
                    ["null1", "null2"],
                    ""),
                IsolaUserMeta(
                    "null",
                    0,
                    ["null", "null"],
                    "null",
                    true,
                    ["null", "null"],
                    ["null", "null"],
                    ["null", "null"],
                    false,
                    ["null", "null"])),
            <GroupsModel>[
              GroupsModel(false, 2, true, true, true, true, 1, [],
                  "0ainitgroup", false, "", false),
              GroupsModel(false, 2, true, true, true, true, 1, [],
                  "0ainitgroup", false, "", false),
              GroupsModel(false, 2, true, true, true, true, 1, [],
                  "0ainitgroup", false, "", false),
              GroupsModel(
                false,
                2,
                true,
                true,
                true,
                true,
                1,
                [],
                "0ainitgroup",
                false,
                "",
                false,
              ),
              GroupsModel(false, 2, true, true, true, true, 1, [],
                  "0ainitgroup", false, "", false)
            ],
            []));

  void groupMergeChanger(GroupMergeData groupMergeData) {
    emit(groupMergeData);
  }

  void groupMergeUserAllChanger(IsolaUserAll isolaUserAll) {
    var newMergeData =
        GroupMergeData(isolaUserAll, state.groupsModel, state.exploreData);

    emit(newMergeData);
  }
}
