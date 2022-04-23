import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../extensions/locale_keys.dart';
import '../service/firebase/authentication.dart';

class NonValidPage extends StatelessWidget {
  const NonValidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
      decoration: BoxDecoration(gradient: ColorConstant.startingPageGradient),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  Image.asset(name),
          SizedBox(height: 13.h,),
          Padding(
            padding:EdgeInsets.only(right: 20.w),
            child: Text("WELCOME TO \nISOLA!",
                style: TextStyle(
                  fontSize: 35.sp,
                  fontFamily: GoogleFonts.staatliches().fontFamily,
                )),
          ),
        Padding(
          padding:  EdgeInsets.all(12.w),
          child: RichText(text: TextSpan(text: "Dear user, For the purpose of giving you and other users the best student experience on Isola, we need to verify that you are a student. For this reason we ask all of you to register with your student email address!\n\nIn case your student email address is not working through the registration process, please check on our website if your University or higher education instruction, is on the list of our partners. In the unfortunate case we are not partnered with your institution, we kindly ask you to give us more time to do so",style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.staatliches().fontFamily,color: CupertinoColors.black
                  ))),
        ),
       SizedBox(height: 5.h,),
          CupertinoButton(
              child: Container(
                width: 65.w,
                height: 5.h,
                 decoration: BoxDecoration(
                                        color: ColorConstant.startingButtonColor,
                                        border: Border.all(
                                            color:
                                                ColorConstant.transparentColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.sp))),
                child: Row(
                  children: [
                    SizedBox(width: 4.w,),
                    const Icon(
                      CupertinoIcons.left_chevron,
                      color: ColorConstant.milkColor,
                    ), SizedBox(width: 14.w,),
                  Text(LocaleKeys.settings_logout.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.staatliches().fontFamily,
                  color: ColorConstant.milkColor
                )),
                  ],
                ),
              ),
              onPressed: () async {
                await Authentication.signOut().whenComplete(() {
                  Navigator.pushNamed(context, loggingOutRoute);
                });
              }),
        ],
      ),
    ));
  }
}
