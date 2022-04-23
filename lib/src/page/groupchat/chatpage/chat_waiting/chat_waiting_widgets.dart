import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../extensions/locale_keys.dart';

class ChatGroupContWaiting extends StatelessWidget {
  const ChatGroupContWaiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: ColorConstant.milkColor,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: const BorderRadius.all(Radius.circular(15.0))),
            child: Row(
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Lottie.asset(
                  'asset/animation/waiting_animation.json',
                  height: 10.h,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Waiting For Others",
                  style: 100.h >= 1100
                      ? StyleConstants.groupTabletCardTextStyle
                      : StyleConstants.groupCardTextStyle,
                ),
                SizedBox(
                  width: 16.w,
                ),
                CupertinoButton(
                    child: SizedBox(
                        height: 1.h,
                        width: 5.w,
                        child: Image.asset(
                          "asset/img/chat_page_three_dot.png",
                          fit: BoxFit.contain,
                        )),
                    onPressed: () => showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                           
                              actions: [
                                CupertinoButton(
                                    child: Text(
                                   LocaleKeys.chat_reportgroup.tr(),
                                      style:const TextStyle(
                                          color: CupertinoColors.systemRed),
                                    ),
                                    onPressed: () {}),
                                CupertinoButton(
                                    child:  Text(LocaleKeys.main_back.tr()),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ))),
              ],
            )),
      ),
    );
  }
}
