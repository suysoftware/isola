// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:isola_app/src/model/enum/ref_enum.dart';
/*
Future<bool> searchingStatus(List<dynamic> userGroupJoinedList) async {
  var refSearchingStatus = refGetter(
      enum2: RefEnum.Groupdisplay, targetUid: "", userUid: "", crypto: "");

  switch (userGroupJoinedList.length) {
    case 1:
      if (userGroupJoinedList[0] == "nothing") {
           print("nothing");
        return false;
      } else {
           print("1 tane varmış");
        var memberValue;
       await refSearchingStatus
            .child(userGroupJoinedList[0])
            .child("group_member_value")
            .once()
            .then((value) => memberValue = value.snapshot.value);

        if (memberValue == 3) {
          print("1 tane var ve false döndü");
          return false;
        } else {
             print("1 tane var ve true döndü");
          return true;
        }
      }

    case 2:
       print("2 tane");
      var memberValue1;
      var memberValue2;
     await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

      await refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

      if (memberValue1 == 3 && memberValue2 == 3) {
           print("2 tane false döndü");
        return false;
      } else {
           print("2 tane true döndü");
        return true;
      }

    case 3:
       print("3 tane döndü");
      var memberValue1;
      var memberValue2;
      var memberValue3;

     await refSearchingStatus
          .child(userGroupJoinedList[0])
          .child("group_member_value")
          .once()
          .then((value) => memberValue1 = value.snapshot.value);

    await  refSearchingStatus
          .child(userGroupJoinedList[1])
          .child("group_member_value")
          .once()
          .then((value) => memberValue2 = value.snapshot.value);

     await refSearchingStatus
          .child(userGroupJoinedList[2])
          .child("group_member_value")
          .once()
          .then((value) => memberValue3 = value.snapshot.value);

      if (memberValue1 == 3 && memberValue2 == 3 && memberValue3 == 3) {
           print("3 tane false");
        return false;
      } else {
           print("3 tane true");
        return true;
      }

    default:
       print("direk false");
      return false;
  }
}




*/
