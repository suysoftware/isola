import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isola_app/src/model/user/user_all.dart';


Future<void> addFriend(String targetUid, IsolaUserAll userAll) async {
  var myFriends = <dynamic>[];
  var myBlocked = <dynamic>[];
  var myFriendOrders = <dynamic>[];

  myFriends.addAll(userAll.isolaUserMeta.userFriends);
  myBlocked.addAll(userAll.isolaUserMeta.userBlocked);
  myFriendOrders.addAll(userAll.isolaUserMeta.userFriendOrders);

  if (myFriends.contains(targetUid) == false &&
      myBlocked.contains(targetUid) == false &&
      myFriendOrders.contains(targetUid) == false) {
    myFriends.add(targetUid);
    if (myFriends.contains("nothing")) {
      myFriends.remove("nothing");
    }

    DocumentReference uFriendsRef =
        FirebaseFirestore.instance.collection('add_friend_orders').doc();

    await uFriendsRef.set({
      'inviterUser': userAll.isolaUserMeta.userUid,
      'orderDate': DateTime.now().toUtc(),
      'orderNo': uFriendsRef.id,
      'targetUser': targetUid,
    });
  }
}
