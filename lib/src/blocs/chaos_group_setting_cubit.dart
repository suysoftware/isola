import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';

class ChaosGroupSettingCubit extends Cubit<ChaosGroupSettingModel> {
  final ChaosGroupSettingModel chaosGroupSettingModel;
  ChaosGroupSettingCubit(this.chaosGroupSettingModel) : super(chaosGroupSettingModel);

  void chaosGroupSettingChanger(ChaosGroupSettingModel _chaosGroupSettingModel) {
    emit(_chaosGroupSettingModel);
  }
}
