import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

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
                SizedBox(width: 2.w,),
                                Lottie.asset('asset/animation/waiting_animation.json',height: 10.h,),
                /*
                Padding(
                  padding: 100.h >= 1100
                      ? const EdgeInsets.all(15.0)
                      : const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: ColorConstant.chatGradientMaterial1,
                    radius: 15.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                      child: Image.asset(
                        "asset/img/chatpage_waiting_person_icon.png",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: 100.h >= 1100
                      ? const EdgeInsets.all(15.0)
                      : const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: ColorConstant.chatGradientMaterial1,
                    radius: 15.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                      child: Image.asset(
                        "asset/img/chatpage_waiting_person_icon.png",
                      ),
                    ),
                  ),
                ),*/
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
                              content: const Text("dasdadsadsa"),
                              actions: [
                                CupertinoButton(
                                    child: const Text(
                                      "Report Group",
                                      style: TextStyle(
                                          color: CupertinoColors.systemRed),
                                    ),
                                    onPressed: () {



                                      
                                    }),
                                CupertinoButton(
                                    child: const Text("Back"),
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