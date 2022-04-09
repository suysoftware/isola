import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/terms_privacy/policy_dialog.dart';
import 'package:sizer/sizer.dart';

class AgreeTermsOfUse extends StatelessWidget {
  const AgreeTermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "I agree  ",
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: ColorConstant.doubleSoftBlack,
              fontFamily: "CoderStyle",
              fontSize: 10.sp),
          children: [
            TextSpan(
              text: "Terms & Conditions ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.signUpGenderButtons),
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
            const TextSpan(text: "and "),
            TextSpan(
              text: "Privacy Policy! ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.signUpGenderButtons),
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



class SettingsTermsOfUse extends StatelessWidget {
  const SettingsTermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "I agree  ",
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: ColorConstant.doubleSoftBlack,
              fontFamily: "CoderStyle",
              fontSize: 10.sp),
          children: [
            TextSpan(
              text: "Terms & Conditions ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.signUpGenderButtons),
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
            const TextSpan(text: "and "),
            TextSpan(
              text: "Privacy Policy! ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.signUpGenderButtons),
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
