import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConstant {
  static const Color milkColor = CupertinoColors.white;
  static const Color themeColor = Color(0xFFF2F3F5);
  static const Color textColor = CupertinoColors.white;
  static const Color softBlack = CupertinoColors.black;
  static const Color redAlert = CupertinoColors.destructiveRed;
  static const Color doubleSoftBlack = CupertinoColors.darkBackgroundGray;
  static const Color themeGrey = Color(0xFFF2F3F5);
  static const Color messageBoxGrey = Color(0xFFE1E1E1);
  static const Color chatPageThemeGrey = Color(0xFFF4F4F4);
  static const Color addTimelinePost = Color(0xFFE8E8E8);
  static const Color signUpGenderButtons = Color(0xFF955AD0);
  static const Color accountEditButtonColor = Color(0xFFC498F1);
  static const Color isolaTokenColor = Color(0xFFA88300);
  static const Color isolaTokenColorLight = Color(0xFFFFC700);
  static const Color friendAmount = Color(0xFF6622CC);

  static const Color groupSettingsButton1 = Color(0xFF485FDB);
  static const Color groupSettingsButton2 = Color(0xFF5973FF);

  static const Color chatNameTextColor1 = Color(0xFF00C2FF);
  static const Color chatNameTextColor2 = Color(0xFFE167FF);
  static const Color chatNameTextColor3 = Color(0xFFFFB800);
  static const Color chatNameTextColor4 = Color(0xFFFF3666);
  static const Color chatNameTextColor5 = Color(0xFF00E35B);

  static const Color startingPageGradientMaterial1 = Color(0x80F1198E);
  static const Color startingPageGradientMaterial2 = Color(0x59284AF9);
  static const Color startingPageGradientMaterial3 = Color(0x4014D1FB);
  static const Color startingPageGradientMaterial4 = Color(0xFFFFFFFF);

  static Color startingButtonColor = const Color.fromARGB(126, 225, 178, 255);

  static const Color softPurple = Color(0xFFAF43FD);
  static Color softGrey = CupertinoColors.black.withOpacity(0.7);
  static const Color iGradientMaterial1 = Color(0xFFC549FF);
  static const Color iGradientMaterial2 = Color(0xFF67F9F9);

  static const Color iGradientMaterial3 = Color(0xFFFD299B);
  static const Color iGradientMaterial4 = Color(0xFF5873FF);
  static const Color iGradientMaterial5 = Color(0xFF5BFFFF);

  static const Color iGradientMaterial6 = Color(0xFF155563);

  static const Color chatGradientMaterial1 = Color(0xFF5873FF);
  static const Color chatGradientMaterial2 = Color(0xFF80E8FF);

  static Color iGradientMaterial7 = const Color(0xFF80E8FF).withOpacity(0.15);

  static const transparentColor = Colors.transparent;

  static const Gradient isolaMainGradient = LinearGradient(
      begin: Alignment(-0.05, -2.2),
      end: Alignment(0.05, 1.9),
      colors: [
        ColorConstant.iGradientMaterial1,
        ColorConstant.iGradientMaterial2,
      ]);
  static Gradient isolaHomeBgGradient = LinearGradient(
      begin: const Alignment(-0.05, -2.2),
      end: const Alignment(0.05, 1.9),
      colors: [
        ColorConstant.iGradientMaterial6,
        ColorConstant.iGradientMaterial7,
      ]);
  static const Gradient isolaTriumGradient = LinearGradient(
      begin: Alignment(-0.88, -2.0),
      end: Alignment(0.1, 1.9),
      stops: [
        0.15,
        0.5,
        0.88
      ],
      colors: [
        ColorConstant.iGradientMaterial3,
        ColorConstant.iGradientMaterial4,
        ColorConstant.iGradientMaterial5,
      ]);
  static Gradient startingPageGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.07,
        0.38,
        0.67,
        1.0
      ],
      colors: [
        ColorConstant.startingPageGradientMaterial1,
        ColorConstant.startingPageGradientMaterial2,
        ColorConstant.startingPageGradientMaterial3,
        ColorConstant.startingPageGradientMaterial4,
      ]);
}
