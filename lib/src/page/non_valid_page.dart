import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  Image.asset(name),
        Center(child: Text('SEN EZİKSİN')),

        Icon(
          CupertinoIcons.flag_fill,
          size: 40.sp,
        ),
        CupertinoButton(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.left_chevron,
                  color: ColorConstant.softBlack,
                ),
                Text(LocaleKeys.settings_logout.tr()),
              ],
            ),
            onPressed: () async {
              await Authentication.signOut().whenComplete(() {
                Navigator.pushNamed(context, loggingOutRoute);
              });
            })
      ],
    ));
  }
}
