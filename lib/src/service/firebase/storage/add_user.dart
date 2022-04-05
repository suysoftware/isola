// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
Future<void> addUser(String uid, String userName, String userMail) async {
  String fileID = const Uuid().v4();
  String fileID2 = const Uuid().v4();

  var refAddUserDisplay = refGetter(
      enum2: RefEnum.Userdisplay, targetUid: uid, crypto: "", userUid: uid);

  var refAddUserMeta = refGetter(
      enum2: RefEnum.Usermeta, targetUid: uid, crypto: "", userUid: uid);

  var refAddUserExplore = refGetter(
      enum2: RefEnum.Userexploredata, targetUid: uid, crypto: "", userUid: uid);

  var refAddUserLikeHistory = refGetter(
      enum2: RefEnum.LikeSave, targetUid: uid, crypto: fileID2, userUid: uid);
  var userExploreData = <String>[];

  userExploreData.add("16b162f3-3f12-4786-84ba-cca2f1e557cf");

  var userLikeHistory = <String>[];
  userLikeHistory.add(DateTime.now().toString());

  var userFriends = <String>[];
  userFriends.add("nothing");

  var userBlocked = <String>[];
  userBlocked.add("okan");
  userBlocked.add("javier");

  var activites = <String>[];
  activites.add("activity1");
  activites.add("activity2");
  activites.add("activity3");
  activites.add("activity4");

  var interest = <String>[];
  interest.add("interest1");
  interest.add("interest2");
  interest.add("interest3");
  interest.add("interest4");

  var joinedGroupList = <String>[];
  joinedGroupList.add("nothing");

  var feedLikes = <String>[];
  feedLikes.add("start");

  var userMeta = HashMap<String, dynamic>();
  userMeta["user_email"] = userMail;
  userMeta["user_token"] = 0;
  userMeta["user_loc_longitude"] = 22.2;
  userMeta["user_loc_latitude"] = 23.4;
  userMeta["joined_group_list"] = joinedGroupList;
/*
  var feedMeta = HashMap<String, dynamic>();
  feedMeta["feed_time"] = ServerValue.timestamp;
  feedMeta["feed_date"] = "22.22.22";
  feedMeta["feed_no"] = "16b162f3-3f12-4786-84ba-cca2f1e557cf";
  feedMeta["feed_image_url"] = "nothing";
  feedMeta["feed_text"] = "HELLO EVERYONE !";
  feedMeta["like_value"] = 0;
  feedMeta["feed_is_image"] = false;
  feedMeta["user_activities"] = activites;
  feedMeta["user_interest"] = interest;
  feedMeta["like_list"] = feedLikes;
  feedMeta["user_friends"] = userFriends;
  feedMeta["user_blocked"] = userBlocked;
  feedMeta["user_uid"] = uid;
  feedMeta["user_name"] = "Raif Efendi";
  feedMeta["user_biography"] = "ben nereden geldim gittim";
  feedMeta["user_avatar_url"] =
      "https://media.istockphoto.com/photos/young-man-looking-away-picture-id878088156?k=20&m=878088156&s=612x612&w=0&h=2XfPn-PDRKLa9Wa8dwP_ji9Q7JP4hH8lnpDa0cOQ7cw=";
  feedMeta["user_university"] = "Technische Universitat Munchen";
  feedMeta["user_sex"] = true;
  feedMeta["user_is_online"] = true;
  feedMeta["user_is_valid"] = true;
*/
  var userDisplay = HashMap<String, dynamic>();

  userDisplay["user_uid"] = uid;
  userDisplay["user_name"] = userName;
  userDisplay["user_biography"] = "My biography";
  userDisplay["user_avatar_url"] =
      "https://firebasestorage.googleapis.com/v0/b/isoladeneme.appspot.com/o/constant_files%2Fnative_profile_photo.png?alt=media&token=00bedb23-f169-41d6-9054-04233f892214";
  userDisplay["user_university"] = "-";
  userDisplay["user_sex"] = false;
  userDisplay["user_is_non_binary"] = true;
  userDisplay["user_is_online"] = true;
  userDisplay["user_is_valid"] = false;
  userDisplay["user_activities"] = activites;
  userDisplay["user_interest"] = interest;
  userDisplay["user_friends"] = userFriends;
  userDisplay["user_blocked"] = userBlocked;

  refAddUserDisplay.set(userDisplay);
  refAddUserMeta.set(userMeta);
  refAddUserExplore.set(userExploreData);
  refAddUserLikeHistory.set(userLikeHistory);

/*
  var isolaUserDisplay = IsolaUserDisplay(
      userName, "My Biography", "", false, false, interest, true,);
  await addUserCloudFirestore(uid, isolaUserDisplay);*/
  //////firestore database operation

  // refAddUserTimelineFeed.set(feedMeta);
}
*/

/*
Future<void> addUserCloudFirestore(
    String userUid, IsolaUserDisplay isolaUserDisplay) {
  // FirebaseAuth _auth =  FirebaseAuth.instance;

  CollectionReference users =
      FirebaseFirestore.instance.collection('users_display');
  // Call the user's CollectionReference to add a new user
  return users
      .doc(userUid)
      .set({
        'uPic': isolaUserDisplay.avatarUrl,
        'uBio': isolaUserDisplay.userBiography,
        'uInterest': isolaUserDisplay.userInterest,
        'uNonBinary': isolaUserDisplay.userIsNonBinary,
        'uOnline': isolaUserDisplay.userIsOnline,
        'uName': isolaUserDisplay.userName,
        'uSex': isolaUserDisplay.userSex,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<UserDisplay> createUserChecker(String uid) async {
  var _ref = refGetter(
      enum2: RefEnum.Createuser, userUid: uid, targetUid: uid, crypto: "");

  dynamic comingValue;
  await _ref.once().then((snapshot) => comingValue = snapshot.snapshot.value);
  var userDisplay = UserDisplay(
      comingValue["user_uid"],
      comingValue["user_name"],
      comingValue["user_biography"],
      comingValue["user_avatar_url"],
      comingValue["user_university"],
      comingValue["user_sex"],
      comingValue["user_is_online"],
      comingValue["user_is_valid"],
      comingValue["user_activities"],
      comingValue["user_interest"],
      comingValue["user_friends"],
      comingValue["user_blocked"],
      comingValue["user_is_non_binary"]);

  return userDisplay;
}
*/

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser!.uid;
  print(token);

  await FirebaseFirestore.instance
      .collection('users_display')
      .doc(userId)
      .get()
      .then((value) {
    if (value.data() != null) {
      var targetUserDisplayData = value.data();

      var targetToken = targetUserDisplayData!['uDbToken'];
      if (token != targetToken) {
        FirebaseFirestore.instance
            .collection('users_display')
            .doc(userId)
            .update({
          'uDbToken': token,
        });
      }
    }
  });

  await FirebaseFirestore.instance
      .collection('users_display')
      .doc(userId)
      .update({
    //'uDbToken': FieldValue.arrayUnion([token]),
    'uDbToken': token
  });
}
