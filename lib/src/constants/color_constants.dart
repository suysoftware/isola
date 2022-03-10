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

  static const Color groupSettingsButton1 = Color(0xFF485FDB);
  static const Color groupSettingsButton2 = Color(0xFF5973FF);

  static const Color chatNameTextColor1 = Color(0xFFFF0000);
  static const Color chatNameTextColor2 = Color(0xFF0075FF);

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
}
