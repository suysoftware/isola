// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/service/location/location_operations.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LocationAddPage extends StatefulWidget {
  const LocationAddPage({Key? key, required this.userUid}) : super(key: key);
  final userUid;

  @override
  _LocationAddPageState createState() => _LocationAddPageState();
}

class _LocationAddPageState extends State<LocationAddPage> {
  bool letsGo = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('asset/animation/get_location_animation.json',
                height: 30.h),
            SizedBox(
              height: 2.h,
            ),
            letsGo == false
                ? SizedBox(
                    height: 5.h,
                    width: 35.w,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: ColorConstant.messageBoxGrey,
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                        child: Text(
                          "LET'S GO",
                          style: 100.h <= 1100
                              ? StyleConstants.firstLocTextStyle
                              : StyleConstants.firstLocTabletTextStyle,
                        ),
                        onPressed: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    content:  Text(LocaleKeys.main_givelocation.tr()),
                                    actions: [
                                      CupertinoButton(
                                          color:
                                              ColorConstant.iGradientMaterial1,
                                          child:  Text(LocaleKeys.main_givelocation.tr()),
                                          onPressed: () {
                                            getLocation(uid: widget.userUid)
                                                .whenComplete(() {
                                              letsGo = true;

                                              Navigator.pushReplacementNamed(
                                                  context, navigationBar);
                                            });
                                          }),
                                    ],
                                  ));
                        }),
                  )
                : SizedBox(
                    height: 5.h,
                    width: 35.w,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: ColorConstant.chatGradientMaterial1,
                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                        child: Text(
                          "LET'S GO",
                          style: 100.h <= 1100
                              ? StyleConstants.firstLocTextStyle
                              : StyleConstants.firstLocTabletTextStyle,
                        ),
                        onPressed: () {}),
                  ),
          ],
        ),
      ),
    );
  }
}
