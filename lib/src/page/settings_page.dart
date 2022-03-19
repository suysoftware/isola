// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/account_setting.dart';
import 'package:isola_app/src/service/firebase/authentication.dart';
import 'package:isola_app/src/service/firebase/storage/add_user.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_feeds.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/like_feeds.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

TextStyle settingTextStyle = 100.h >= 1100
    ? StyleConstants.settingsTabletPageItemStyle
    : StyleConstants.settingsPageItemStyle;

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;
  signOut() async {
    await Authentication.signOut().whenComplete(() {
      Navigator.pushNamed(context, loggingOutRoute);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: ColorConstant.themeGrey,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.only(bottom: 2.h),
          automaticallyImplyLeading: true,
          previousPageTitle: "Settings",
        ),
        child: ListView(
          children: [
            buttonGetter(
                const Icon(
                  CupertinoIcons.bell,
                  color: ColorConstant.softBlack,
                ),
                Text(
                  "Notifications",
                  style: settingTextStyle,
                ), () {
              addSearchPageFeed100(user!.uid);
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.lock, color: ColorConstant.softBlack),
                Text("Privacy", style: settingTextStyle), () {
              // for (var i = 3000; i < 15000; i++) {
              //  addFeedToTextFeed(99999);
              //  addFeedToExample();
              //  print(i);
              //  print(i);
              //  }
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.shield,
                    color: ColorConstant.softBlack),
                Text("Security", style: settingTextStyle), () async {
              //User? user = FirebaseAuth.instance.currentUser;

              var uidList = <String>[
                '0EOs1AhPCddXz7RGOkNzE9HHzr62',
                'I9Pp17tqTRUflixnRosdsiNM2FA2',
                'Q1j0ibLDbhQye11fduuKmjkw3Ry2',
                'UJz489Kp1eeG5fQsHY0Lhunc9Nf1',
                'hz94SInSRXc5YOToR2Kn0gNDOwf2',
                '6WsWSakp5dURSSBo1h9Ob2ruI0l2'
              ];

              var nameList = <String>[
                'ilion12mini device',
                'Batuhan Yavuz',
                'Ufuk Yavuz',
                'ilion13mini device',
                'ilion13promax device',
                'meryem can11'
              ];

              /*    int i = 0;
              for (var uidItem in uidList) {
           

                addTextFeedToDatabase(
                    uidItem,
                    DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
                    'https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fdefault_profile_photo.png?alt=media&token=fd38c835-ce62-4e3b-8dec-3914f2c94586',
                    nameList[i]);

                         i = i + 1;
              }*/

              /*await FirebaseFirestore.instance
                  .collectionGroup("text_feeds")
                  .whereArrayContainsAny('user_uid', arrayContainsAny: [
                    '0EOs1AhPCddXz7RGOkNzE9HHzr62',
                    'I9Pp17tqTRUflixnRosdsiNM2FA2',
                    'Q1j0ibLDbhQye11fduuKmjkw3Ry2',
                    'UJz489Kp1eeG5fQsHY0Lhunc9Nf1',
                    'hz94SInSRXc5YOToR2Kn0gNDOwf2',
                    '6WsWSakp5dURSSBo1h9Ob2ruI0l2'
                  ])*/
//'dateTime': DateTime.parse('2019-03-13 16:49:42.044'
              //w     FirebaseFirestore.instance.collectionGroup("text_feeds").whereGreaterThan('feed_date',1000).orderBy('feed_date',descending: true)
              print("dfs");

              final Timestamp now = Timestamp.fromDate(DateTime.now());
              final Timestamp yesterday = Timestamp.fromDate(
                DateTime.now().subtract(const Duration(days: 1)),
              );




       
/*


              for (var item in uidList) {
                var testQuery = FirebaseFirestore.instance
                    .collection('feeds')
                    .doc(item)
                    .collection('text_feeds')
                    .where('feed_date',
                        isLessThan: now, isGreaterThan: yesterday).limit(1);

                      

                
                

                if (uidList.last == item) {
                  testQuery.get().then((value) {
                    for (var item in value.docs) {
                      print('Name : ${item['user_name']}');
                      print('Tarih : ${item['feed_date']}');
                      print('Like : ${item['like_value']}');
                      print('Uid : ${item['user_uid']}');

                      print('//////////////////////');
                    }
                  });
                }
              }*/

              /* FirebaseFirestore.instance
                  .collectionGroup('text_feeds')
                  .where('Q1j0ibLDbhQye11fduuKmjkw3Ry2', isEqualTo: 'user_uid')
                  .get()
                  //.where('feed_date', isLessThan: now, isGreaterThan: yesterday)
                  //.orderBy('feed_date', descending: true)
                  //.get()
                  .then((value) {
                for (var item in value.docs) {
                  print('Name : ${item['user_name']}');
                  print('Tarih : ${item['feed_date']}');
                  print('Like : ${item['like_value']}');
                  print('Uid : ${item['user_uid']}');

                  print('//////////////////////');
                }
              });
*/
              // .orderBy('like_value', descending: true);
              /*    .where('user_uid', arrayContainsAny: uidList)
                  .orderBy('feed_date', descending: true);*/

              //var snapshot = query.orderBy('like_value',descending: true).get();
              //var ss = snapshot.docs[0]['feed_date'];
              //print(ss);
/*
              print('///');
              print(snapshot.docs.first['feed_date']);
              print(snapshot.docs.first['feed_no']);
              print(snapshot.docs.first['like_value']);
              print(snapshot.docs.first['user_name']);*/

              // namedQueryGet('popular_feeds');
              // .collection("popular_feeds")
              /* .get()
                  .then((value) {
                for (var item in value.docs) {
                  print('Name : ${item['user_name']}');
                  print('Tarih : ${item['feed_date']}');
                }
              });*/

/*
              await likeAddToPool(
                  "4em8s6rMxzGtFBhubdWr",
                  "6WsWSakp5dURSSBo1h9Ob2ruI0l2",
                  true,
                  "8nRYW1UcOPd7aUw5keHADQhfc302");
*/
              //

              //    late UserDisplay userDisplay;
              //  await getDisplayData(user!.uid)
              //    .then((value) => userDisplay = value);
              //print(userDisplay.userBiography);
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.person_circle,
                    color: ColorConstant.softBlack),
                Text("Account", style: settingTextStyle), () {
              User? user = FirebaseAuth.instance.currentUser;
              //  print("ff");
              //try {
              //  addSearchPageFeed100(user!.uid);
              //} catch (e) {}

              showCupertinoDialog(
                  context: context,
                  builder: (context) => AccountSettingPage(
                        userUid: user!.uid,
                      ));
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.question_circle,
                    color: ColorConstant.softBlack),
                Text(
                  "Help",
                  style: settingTextStyle,
                ),
                () {}),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.info_circle,
                    color: ColorConstant.softBlack),
                Text("About", style: settingTextStyle), () {
              getUserAllFromDataBase(user!.uid).then((value) {
                print(value.isolaUserDisplay.userName);
              });

              /*
              addUserCloudFirestore(
                  "ornekuid123",
                  IsolaUserDisplay("testname", "testbio", "testavatar", true,
                      true, ["d", "sda"], false));*/
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(
                  CupertinoIcons.left_chevron,
                  color: ColorConstant.softBlack,
                ),
                Text("Log out", style: settingTextStyle),
                () => signOut()),
          ],
        ));
  }
}

//
Widget buttonGetter(
    Icon settingsItemIcon, Text settingsItemText, Function() settingsItemFunc) {
  return Container(
    decoration: BoxDecoration(
        color: ColorConstant.milkColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 1.sp,
              spreadRadius: 0.2.sp,
              offset: const Offset(0.0, 0.0),
              color: ColorConstant.softBlack.withOpacity(0.2))
        ],
        border: Border.all(width: 0.01, color: ColorConstant.softBlack)),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: CupertinoButton(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: settingsItemIcon,
            ),
            settingsItemText,
          ],
        ),
        onPressed: settingsItemFunc,
      ),
    ),
  );
}
