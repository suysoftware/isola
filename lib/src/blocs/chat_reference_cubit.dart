import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';

class ChatReferenceCubit extends Cubit<CollectionReference> {
  ChatReferenceCubit()
      : super(FirebaseFirestore.instance.collection('users_display'));

  void chatGroupChanger(String groupNo,bool isChaos) {

    if(isChaos){

 var changingRef = FirebaseFirestore.instance
        .collection('chaos_groups_chat')
        .doc(groupNo)
        .collection('chat_data');
          emit(changingRef);
    }
    else{
 var changingRef = FirebaseFirestore.instance
        .collection('groups_chat')
        .doc(groupNo)
        .collection('chat_data');
          emit(changingRef);
    }
   
    /* var changingRef = refGetter(
        enum2: RefEnum.Groupchatlist,
        targetUid: "",
        userUid: "",
        crypto: groupNo);*/

  
  }

  void chatChaosGroupChanger(String groupNo,bool isChaos) {
 /*   var changingRef = refGetter(
        enum2: RefEnum.Chaosgroupchatlist,
        targetUid: "",
        userUid: "",
        crypto: groupNo);*/
        var changingRef=FirebaseFirestore.instance
        .collection('chaos_groups_chat')
        .doc(groupNo)
        .collection('chat_data');

    emit(changingRef);
  }
}
