import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/group/group_members.dart';

class ChatMessageTargetsCubit extends Cubit<GroupMembers> {
  ChatMessageTargetsCubit() : super(GroupMembers("", "", ""));

  void chatMessageTargetsChanger(
      {required String meUid,
      required String target1,
      required String target2}) {
    var targets = GroupMembers(meUid, target1, target2);

    emit(targets);
  }

  
}




