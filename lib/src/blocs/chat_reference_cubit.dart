import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatReferenceCubit extends Cubit<CollectionReference> {
  ChatReferenceCubit()
      : super(FirebaseFirestore.instance.collection('users_display'));

  void chatGroupChanger(String groupNo, bool isChaos) {
    if (isChaos) {
      var changingRef = FirebaseFirestore.instance
          .collection('chaos_groups_chat')
          .doc(groupNo)
          .collection('chat_data');
      emit(changingRef);
    } else {
      var changingRef = FirebaseFirestore.instance
          .collection('groups_chat')
          .doc(groupNo)
          .collection('chat_data');
      emit(changingRef);
    }
  }

  void chatChaosGroupChanger(String groupNo, bool isChaos) {
    var changingRef = FirebaseFirestore.instance
        .collection('chaos_groups_chat')
        .doc(groupNo)
        .collection('chat_data');

    emit(changingRef);
  }
}
