// ignore_for_file: avoid_print, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/page/sign_up_page.dart';
import 'package:isola_app/src/service/firebase/authentication.dart';
import 'package:isola_app/src/service/firebase/storage/add_user.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/button_widgets.dart';
import 'package:sizer/sizer.dart';

class LoggingOut extends StatefulWidget {
  const LoggingOut({Key? key}) : super(key: key);

  @override
  _LoggingOutState createState() => _LoggingOutState();
}

class _LoggingOutState extends State<LoggingOut> {
  // GoogleSignIn _googleSignIn = GoogleSignIn();

  authenticationButtonFunc() async {
    User? user = await Authentication.signInWithGoogle(context: context);

    if (user != null) {
      print("girdi");
      try {
        await getUserAllFromDataBase(user.uid).then((value) {
          if (value.isolaUserDisplay.userInterest.first == "interest1") {
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => SignUpPage(userAll: value)));
          } else {
            Navigator.pushNamed(context, navigationBar);
          }
        });
      } catch (e) {
        print(e);
        Navigator.pushReplacementNamed(context, loggingOutRoute);
      }
    } else {
      print("nulmuş");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("H: ${100.h}");
    print("W: ${100.w}");
    return CupertinoPageScaffold(
        child: Stack(
      children: [
        100.h >= 750
            ? Image.asset("asset/img/logging_out.png",
                width: 100.w, fit: BoxFit.fitHeight)
            : Image.asset(
                "asset/img/logging_out_backscreen_for_low_height.png",
                fit: BoxFit.fitWidth,
                width: 100.w,
              ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "asset/img/isola_white_logo.png",
            height: 20.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 1.w, 2.h),
          child: Align(
            alignment: Alignment.bottomRight,
            child: oblongTextIconButton(
                buttonImage: Image.asset("asset/img/google_logo.png"),
                buttonColor: CupertinoColors.white,
                buttonFunc: authenticationButtonFunc,
                buttonGradient: ColorConstant.isolaMainGradient,
                buttonText: LocaleKeys.loggingout_buttontext.tr(),
                isGradient: true,
                textStyle: StyleConstants.softMilkTextStyle,
                buttonHeight: 6,
                buttonWidth: 52,
                buttonPadding: 2.0,
                borderWidth: 0.25,
                borderColor: ColorConstant.softBlack),
          ),
        ),
      ],
    ));
  }
}
