import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';

class ChatReferenceCubit extends Cubit<DatabaseReference> {
  ChatReferenceCubit()
      : super(refGetter(
            enum2: RefEnum.Groupchatlist,
            targetUid: "",
            userUid: "",
            crypto: ""));

  void chatGroupChanger(String groupNo) {
    var changingRef = refGetter(
        enum2: RefEnum.Groupchatlist,
        targetUid: "",
        userUid: "",
        crypto: groupNo);

    emit(changingRef);
  }

  void chatChaosGroupChanger(String groupNo) {
    var changingRef = refGetter(
        enum2: RefEnum.Chaosgroupchatlist,
        targetUid: "",
        userUid: "",
        crypto: groupNo);

    emit(changingRef);
  }
}

