import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_display.dart';

Future<void> addFriend(String targetUid, UserDisplay userDisplay) async {
  var myFriends = <dynamic>[];
  myFriends.addAll(userDisplay.userFriends);

  if (myFriends.contains(targetUid) == false) {
    myFriends.add(targetUid);

    var refAddFriend = refGetter(
        enum2: RefEnum.Userdisplay,
        targetUid: userDisplay.userUid,
        userUid: "",
        crypto: "");

   await refAddFriend.child("user_friends").set(myFriends);
  }
}
