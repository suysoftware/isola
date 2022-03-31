
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/chaos/chaos_group_members.dart';

class ChaosChatMessageTargetsCubit extends Cubit<ChaosGroupMembers> {
  ChaosChatMessageTargetsCubit() : super(ChaosGroupMembers("", "", "","","",""));

  void chatMessageTargetsChanger(
      {required String meUid,
      required String target1,
      required String target2,
         required String target3,
            required String target4,
               required String target5,



      
      }) {
    var targets = ChaosGroupMembers(meUid, target1, target2,target3,target4,target5);

    emit(targets);
  }

  
}
