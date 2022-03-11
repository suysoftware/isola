import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';

Future<void> addFriend(String targetUid, IsolaUserAll userAll) async {
  var myFriends = <dynamic>[];
  myFriends.addAll(userAll.isolaUserMeta.userFriends);

  if (myFriends.contains(targetUid) == false) {
    myFriends.add(targetUid);

    var refAddFriend = refGetter(
        enum2: RefEnum.Userdisplay,
        targetUid: userAll.isolaUserMeta.userUid,
        userUid: "",
        crypto: "");

   await refAddFriend.child("user_friends").set(myFriends);
  }
}
