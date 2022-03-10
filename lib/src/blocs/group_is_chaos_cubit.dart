import 'package:flutter_bloc/flutter_bloc.dart';

class ChatIsChaosCubit extends Cubit<bool> {
  ChatIsChaosCubit() : super(false);

  void chatIsChaosTrue() {
    emit(true);
  }

   void chatIsChaosFalse() {
    emit(false);
  }
}

/*
class GroupIsChaosCubit extends Cubit<GroupIsChaosModel> {
  GroupIsChaosCubit() : super(GroupIsChaosModel(false, false, false, false, false));

 

   void group1IsChaos(bool status) {
    var groupChaosModel=GroupIsChaosModel(status,state.group2,state.group3,state.group4,state.group5);
    emit(groupChaosModel);
  }

    void group2IsChaos(bool status) {
    var groupChaosModel=GroupIsChaosModel(state.group1,status,state.group3,state.group4,state.group5);
    emit(groupChaosModel);
  }

  
  


     void group3IsChaos(bool status) {
    var groupChaosModel=GroupIsChaosModel(state.group1,state.group2,status,state.group4,state.group5);
    emit(groupChaosModel);
  }




     void group4IsChaos(bool status) {
    var groupChaosModel=GroupIsChaosModel(state.group1,state.group2,state.group3,status,state.group5);
    emit(groupChaosModel);
  }

   



     void group5IsChaos(bool status) {
    var groupChaosModel=GroupIsChaosModel(state.group1,state.group2,state.group3,state.group4,status);
    emit(groupChaosModel);
  }



 
}
*/