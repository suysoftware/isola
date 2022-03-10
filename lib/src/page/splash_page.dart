// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/page/sign_up_page.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initializeFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    print("sf");
    if (user != null) {
      getDisplayData(user.uid).then((value) {
        if (value.userDisplay.userInterest.first == "interest1") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      SignUpPage(userDisplay: value.userDisplay)));
        } else {
          Navigator.pushReplacementNamed(context, navigationBar);
        }
      });
    } else {
      Navigator.pushNamed(context, loggingOutRoute);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      initializeFirebase();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
              width: 60.w,
              height: 60.h,
              child: Image.asset("asset/img/isola_logo.png")),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: SizedBox(
              height: 6.h,
              child: Image.asset("asset/img/dynamic_gentis_text_logo_dark.png"),
            ),
          ),
        )
      ],
    ));
  }
}
