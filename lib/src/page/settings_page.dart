// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/account_setting.dart';
import 'package:isola_app/src/service/firebase/authentication.dart';
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
                ),
                () {}),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.lock, color: ColorConstant.softBlack),
                Text("Privacy", style: settingTextStyle),
                () {}),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.shield,
                    color: ColorConstant.softBlack),
                Text("Security", style: settingTextStyle),
                () {}),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.person_circle,
                    color: ColorConstant.softBlack),
                Text("Account", style: settingTextStyle), () {
              User? user = FirebaseAuth.instance.currentUser;

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
                Text("About", style: settingTextStyle),
                () async {}),
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
