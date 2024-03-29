import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/terms_privacy/policy_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../extensions/locale_keys.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By creating an account, you are agreeing to our\n ",
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: CupertinoColors.systemGrey3,
              fontFamily: "CoderStyle",
              fontSize: 10.sp),
          children: [
            TextSpan(
              text: LocaleKeys.main_termsandconditions.tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.themeGrey),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return PolicyDialog(
                          mdFileName: 'terms_and_conditions.md',
                        );
                      });
                },
            ),
             TextSpan(text:LocaleKeys.main_and.tr()),
            TextSpan(
              text: "Privacy Policy! ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.themeGrey),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
