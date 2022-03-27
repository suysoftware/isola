import 'package:isola_app/src/model/group/group_alives.dart';
import 'package:isola_app/src/model/group/groups_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';

class GroupPreviewData {
  late IsolaUserAll userAll;
  late GroupAlives groupAlives;

  GroupPreviewData(this.userAll, this.groupAlives);
}

class GroupMergeData {
  late IsolaUserAll userAll;
  late List<dynamic> groupsModel;
  late List<dynamic> exploreData;

  GroupMergeData(this.userAll, this.groupsModel,this.exploreData);
}
