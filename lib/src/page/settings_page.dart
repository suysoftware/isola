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
              User? user = FirebaseAuth.instance.currentUser;

              await likeAddToPool("4em8s6rMxzGtFBhubdWr", user!.uid, false,
                  "8nRYW1UcOPd7aUw5keHADQhfc302");

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
