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
  // ignore: unused_field
  int _selectedValue = 0;
  String languageText = "default";
  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: 100.w,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(),
                scrollController: FixedExtentScrollController(initialItem: 1),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('English'),
                  const Text('Turkish'),
                ],
                onSelectedItemChanged: (value) {
               

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
            buttonGetterOptions(const Icon(CupertinoIcons.location,color: ColorConstant.softBlack,),
                Text(LocaleKeys.settings_language.tr(), style: const TextStyle(color: ColorConstant.softBlack),), () => _showPicker(context),Text('$languageText     ',style: const TextStyle(color: ColorConstant.softBlack)))
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
