// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/page/non_valid_page.dart';
import 'package:isola_app/src/page/sign_up_page.dart';
import 'package:isola_app/src/service/firebase/storage/add_user.dart';
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

    if (user != null) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();

      saveTokenToDatabase(token!);

      getUserAllFromDataBase(user.uid).then((value) {
        if (value.isolaUserMeta.userIsValid == true) {
          if (value.isolaUserDisplay.userInterest.first == "interest1") {
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => SignUpPage(userAll: value)));
          } else {
            context.read<UserAllCubit>().userAllChanger(
                  value,
                );

            Navigator.pushReplacementNamed(context, navigationBar);
          }
        } else {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => const NonValidPage()));
        }
      });
    } else {
      Navigator.pushReplacementNamed(context, loggingOutRoute);
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
