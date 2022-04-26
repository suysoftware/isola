import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class StyleConstants {
  static const TextStyle splashScreenDynamicGentisTextStyle = TextStyle(
      fontFamily: "Roboto-Bold", color: ColorConstant.textColor, fontSize: 18);
  static const TextStyle softMilkTextStyle = TextStyle(
      fontFamily: "Roboto-Bold", color: ColorConstant.textColor, fontSize: 16);
        static  TextStyle loggingOutTextStyle = TextStyle(
      fontFamily: "Roboto-Bold", color: ColorConstant.textColor, fontSize: 10.sp);
  static const TextStyle softDarkTextStyle = TextStyle(
      fontFamily: "Roboto-Bold", color: ColorConstant.softBlack, fontSize: 14);
  static const TextStyle softDarkTabletTextStyle = TextStyle(
      fontFamily: "Roboto-Bold", color: ColorConstant.softBlack, fontSize: 27);
  static const TextStyle cardTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 11.5,
    overflow: TextOverflow.fade,
  );
  static const TextStyle cardTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 23,
    height: 1.3,
    overflow: TextOverflow.fade,
  );
  static const TextStyle firstLocTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 16,
    overflow: TextOverflow.fade,
  );
  static const TextStyle firstLocTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 34,
    height: 1.3,
    overflow: TextOverflow.fade,
  );
  static const TextStyle biographTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 14,
    height: 1.2,
    wordSpacing: 0.2,
    letterSpacing: 0.02,
    overflow: TextOverflow.fade,
  );
  static const TextStyle signUpGenderButtonActiveTextStyle =
      TextStyle(shadows: [
    Shadow(
      blurRadius: 2.0,
    )
  ], fontFamily: "Roboto-Bold", color: ColorConstant.textColor, fontSize: 30);
  static const TextStyle signUpGenderPassiveButtonTextStyle =
      TextStyle(shadows: [
    Shadow(
      blurRadius: 2.0,
    )
  ], fontFamily: "Roboto", color: ColorConstant.softBlack, fontSize: 30);
  static const TextStyle isolaTokenTextStyle = TextStyle(
      fontFamily: "Roboto-Black",
      color: ColorConstant.isolaTokenColor,
      fontSize: 18);
  static TextStyle isolaTokenPageStyle = TextStyle(
      fontFamily: "Roboto-Black",
      color: ColorConstant.isolaTokenColorLight,
      fontSize: 28.sp);
        static TextStyle isolaTokenCardYellowStyle = TextStyle(
      fontFamily: "Roboto-Black",
      color: ColorConstant.isolaTokenColorLight,
      fontSize: 20.sp);
      static TextStyle isolaTokenCardStyle = TextStyle(
      fontFamily: "Roboto-Black",
      color: ColorConstant.softBlack,
      fontSize: 14.sp);
  static const TextStyle biographTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 26,
    wordSpacing: 0.2,
    letterSpacing: 0.02,
    overflow: TextOverflow.fade,
  );
  static const TextStyle profileUniversityTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 14,
    overflow: TextOverflow.fade,
  );
  static const TextStyle profileUniversityTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 24,
    overflow: TextOverflow.fade,
  );
  static TextStyle imageFeedUniversityTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 14.sp,
    overflow: TextOverflow.fade,
  );
  static TextStyle imageFeedUniversityTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 13.sp,
    overflow: TextOverflow.fade,
  );
  static const TextStyle signUpTitlesTextStyle = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.softBlack,
    fontSize: 16,
  );
  static const TextStyle groupCardTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 12,
  );
  static const TextStyle groupTabletCardTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 23,
  );
  static TextStyle matchTextStyle = TextStyle(
      fontFamily: "Staatliches-Regular",
      color: ColorConstant.textColor,
      fontSize: 40,
      shadows: [
        Shadow(
            blurRadius: 3.0,
            color: ColorConstant.softGrey,
            offset: const Offset(-0.1, -3.0))
      ]);
  static TextStyle circularTextStyle = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.textColor,
    fontSize: 30,
    shadows: [
      Shadow(
          blurRadius: 18.0,
          color: ColorConstant.softGrey,
          offset: const Offset(0, 4)),
    ],
    decorationThickness: 1.0,
    fontFeatures: const [FontFeature.oldstyleFigures()],
  );
  static TextStyle circularTabletTextStyle = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.textColor,
    fontSize: 18.sp,
    shadows: [
      Shadow(
          blurRadius: 18.0,
          color: ColorConstant.softGrey,
          offset: const Offset(0, 4)),
    ],
    decorationThickness: 1.0,
    fontFeatures: const [FontFeature.oldstyleFigures()],
  );
  static const TextStyle profileNaviTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 16,
  );
  static const TextStyle profileNaviTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 24,
  );
  static const TextStyle profileMiniNaviTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 14,
  );
  static const TextStyle profileActiveNaviTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 17,
  );
  static const TextStyle settingsPageItemStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.doubleSoftBlack,
    fontSize: 17,
  );
  static const TextStyle settingsTabletPageItemStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.doubleSoftBlack,
    fontSize: 24,
  );
  static TextStyle profileNameTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 20.sp,
  );
  static TextStyle profileNameTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 18.sp,
  );
  static TextStyle searchFeedNameTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 16.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);
  static TextStyle searchFeedNameTabletTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 12.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);
  static TextStyle searchFeedLikeAndTokenTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 16.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);
  static TextStyle searchFeedLikeAndTokenTabletTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 12.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);

  static TextStyle searchFeedUniversityTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 10.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);
  static TextStyle searchFeedUniversityTabletTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.milkColor,
      fontSize: 7.sp,
      shadows: [
        Shadow(
            offset: Offset(1.sp, 1.sp),
            color: ColorConstant.softGrey,
            blurRadius: 5.sp)
      ]);
  static TextStyle hobbiesTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 9.sp,
  );
  static TextStyle chatTimeTextStyleRight = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.themeGrey,
    fontSize: 9.sp,
  );
  static TextStyle chatTabletTimeTextStyleRight = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.themeGrey,
    fontSize: 5.sp,
  );
  static TextStyle chatTimeTextStyleLeft = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 9.sp,
  );
  static TextStyle chatTabletTimeTextStyleLeft = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 5.sp,
  );
  static const TextStyle hobbiesTabletTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 20,
  );
  static TextStyle targetChatMessageTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 10.sp,
  );
  static TextStyle targetTabletChatMessageTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.softBlack,
    fontSize: 8.sp,
  );
  static TextStyle userChatMessageTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.milkColor,
    fontSize: 10.sp,
  );
  static TextStyle userTabletChatMessageTextStyle = TextStyle(
    fontFamily: "Roboto",
    color: ColorConstant.milkColor,
    fontSize: 8.sp,
  );
  static TextStyle chaosTimerTextStyle = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.milkColor,
    fontSize: 9.sp,
  );
  static TextStyle chaosTimerTabletTextStyle = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.milkColor,
    fontSize: 6.sp,
  );
  static TextStyle postAddTextStyle = TextStyle(
      fontFamily: "Roboto",
      color: ColorConstant.softBlack,
      fontSize: 11.sp,
      letterSpacing: 0.08);
  static TextStyle groupSettingsNameTextStyle = TextStyle(
    fontFamily: "Roboto-Medium",
    color: ColorConstant.softBlack,
    fontSize: 12.sp,
  );
  static TextStyle groupSettingsTabletNameTextStyle = TextStyle(
    fontFamily: "Roboto-Medium",
    color: ColorConstant.softBlack,
    fontSize: 10.sp,
  );
  static TextStyle chatNameTextStyle1 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor1.withOpacity(0.8),
    fontSize: 12,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatTabletNameTextStyle1 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor1.withOpacity(0.8),
    fontSize: 24,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatNameTextStyle2 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor2.withOpacity(0.8),
    fontSize: 12,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatTabletNameTextStyle2 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor2.withOpacity(0.8),
    fontSize: 24,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatNameTextStyle3 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor3.withOpacity(0.8),
    fontSize: 12,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatTabletNameTextStyle3 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor3.withOpacity(0.8),
    fontSize: 24,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatNameTextStyle4 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor4.withOpacity(0.8),
    fontSize: 12,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatTabletNameTextStyle4 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor4.withOpacity(0.8),
    fontSize: 24,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatNameTextStyle5 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor5.withOpacity(0.8),
    fontSize: 12,
    overflow: TextOverflow.fade,
  );
  static TextStyle chatTabletNameTextStyle5 = TextStyle(
    fontFamily: "Roboto-Bold",
    color: ColorConstant.chatNameTextColor5.withOpacity(0.8),
    fontSize: 24,
    overflow: TextOverflow.fade,
  );

  static TextStyle friendListNameTextStyle = TextStyle(
      fontFamily: 'Roboto-Medium',
      color: ColorConstant.doubleSoftBlack,
      fontSize: 15.sp);

  static TextStyle friendListNameTabletTextStyle = TextStyle(
      fontFamily: 'Roboto-Medium',
      color: ColorConstant.doubleSoftBlack,
      fontSize: 12.sp);

  static TextStyle friendListUniversityTextStyle = TextStyle(
      fontFamily: 'Roboto', color: ColorConstant.softBlack, fontSize: 11.sp);
  static TextStyle friendListUniversityTabletTextStyle = TextStyle(
      fontFamily: 'Roboto', color: ColorConstant.softBlack, fontSize: 8.sp);

  BoxDecoration isGradientBoxDec(
      {required bool isGradient,
      required Gradient buttonGradient,
      required Color buttonColor,
      required double buttonRadius,
      required double borderWidth,
      required Color borderColor}) {
    if (isGradient) {
      return BoxDecoration(
          gradient: buttonGradient,
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(buttonRadius.sp)));
    } else {
      return BoxDecoration(color: buttonColor);
    }
  }
}
