// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class TextChatContRight extends StatelessWidget {
  String targetMesaj;
  Timestamp messageTime;
  TextChatContRight(
      {Key? key, required this.targetMesaj, required this.messageTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dFormat = DateFormat("HH:mm");
    

        /*
    print(DateTime.fromMicrosecondsSinceEpoch(
            messageTime.microsecondsSinceEpoch.toInt(),
            isUtc: false)
        .timeZoneName);

    print('/////////');
    print(duration);
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale);
    print(DateTime.now().timeZoneName);
    print('//////////');
    */
    double contHeight = 100.h <= 1100
        ? ((targetMesaj.length < 50 ? 1 : targetMesaj.length / 50) + 1.0)
        : ((targetMesaj.length / 30) + 0.6);
    double topLeft = (contHeight * 2 + 6.5) * 3;
    double bottomLeft = (contHeight * 2 + 6.5) * 3;
    double bottomRight = (contHeight + 8) * 3;
    return Container(
      width: 70.w,
      height: (contHeight * 2 + 4).h,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            bottomRight: Radius.circular(bottomRight),
            bottomLeft: Radius.circular(bottomLeft),
          )),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Stack(
          children: [
            Padding(
              padding: 100.h >= 1100
                  ? const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0)
                  : const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
              child: RichText(
                text: TextSpan(
                    text: targetMesaj,
                    style: 100.h >= 1100
                        ? StyleConstants.userTabletChatMessageTextStyle
                        : StyleConstants.userChatMessageTextStyle),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.w, 0.3.h),
                child: Text(
                  '${dFormat.format(DateTime.fromMicrosecondsSinceEpoch(messageTime.microsecondsSinceEpoch.toInt(), isUtc: false))}',
                  style: 100.h <= 1100
                      ? StyleConstants.chatTimeTextStyleRight
                      : StyleConstants.chatTabletTimeTextStyleRight,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
