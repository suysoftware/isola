import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';

import '../model/chaos/chaos_group_setting_model.dart';

class GroupSettingCubit extends Cubit<GroupSettingModel> {
  final GroupSettingModel groupSettingModel;
  GroupSettingCubit(this.groupSettingModel) : super(groupSettingModel);

  void groupSettingChanger(GroupSettingModel _groupSettingModel) {
    emit(_groupSettingModel);
  }
}



