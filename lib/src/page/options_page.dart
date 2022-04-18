import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/language_constants.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../extensions/locale_keys.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int _selectedValue = 0;
  String languageText = "default";
  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: 100.w,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(),
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: [
                  Text('English'),
                  Text('Turkish'),
                ],
                onSelectedItemChanged: (value) {
                  print(value);

                  setState(() {
                    switch (value) {
                      case 0:
                        setState(() {
                          languageText = "English";
                          context.setLocale(AppConstant.EN_LOCALE);
                        });
                        break;
                      case 1:
                        setState(() {
                          languageText = "Turkish";
                          context.setLocale(AppConstant.TR_LOCALE);
                        });
                        break;
                      default:
                    }
                    _selectedValue = value;
                  });
                },
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('1');
    print(context.deviceLocale);
        print('2');
    print(context.localizationDelegates);
        print('3');
    print(context.locale);
        print('4');
    print(context.fallbackLocale);
        print('5');
    print(context.fallbackLocale);
    print(context.fallbackLocale);
    if (languageText == "default") {
      switch (context.locale.toString()) {
        case 'en_US':
          languageText = 'English';

          break;
        case 'tr_TR':
          languageText = 'Turkish';

          break;
        default:
      }
    }

    return CupertinoPageScaffold(
        backgroundColor: ColorConstant.themeGrey,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.only(bottom: 2.h),
          automaticallyImplyLeading: true,
          middle: Text(LocaleKeys.settings_options.tr()),
          previousPageTitle: LocaleKeys.settings_settings.tr(),
        ),
        child: ListView(
          children: [
            buttonGetterOptions(Icon(CupertinoIcons.location,color: ColorConstant.softBlack,),
                Text(LocaleKeys.settings_language.tr(), style: TextStyle(color: ColorConstant.softBlack),), () => _showPicker(context),Text('$languageText     ',style: TextStyle(color: ColorConstant.softBlack)))
          ],
        ));
  }
}

class LanguageBar extends StatefulWidget {
  const LanguageBar({Key? key}) : super(key: key);

  @override
  State<LanguageBar> createState() => _LanguageBarState();
}

class _LanguageBarState extends State<LanguageBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget buttonGetterOptions(
    Icon settingsItemIcon, Text settingsItemText, Function() settingsItemFunc,Text languageText) {
  return Container(
    decoration: BoxDecoration(
        color: ColorConstant.milkColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 1.sp,
              spreadRadius: 0.2.sp,
              offset: const Offset(0.0, 0.0),
              color: ColorConstant.softBlack.withOpacity(0.2))
        ],
        border: Border.all(width: 0.01, color: ColorConstant.softBlack)),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: CupertinoButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: settingsItemIcon,
                ),  settingsItemText,
              ],
            ),
          
            languageText
          ],
        ),
        onPressed: settingsItemFunc,
      ),
    ),
  );
}
