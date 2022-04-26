import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/user/user_notification_settings.dart';
import 'package:isola_app/src/page/account_setting.dart';
import 'package:isola_app/src/page/guide_book_page.dart';
import 'package:isola_app/src/page/options_page.dart';
import 'package:isola_app/src/page/terms_privacy/licences_dialog.dart';
import 'package:isola_app/src/service/firebase/authentication.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:sizer/sizer.dart';

import '../extensions/locale_keys.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

TextStyle settingTextStyle = 100.h >= 1100
    ? StyleConstants.settingsTabletPageItemStyle
    : StyleConstants.settingsPageItemStyle;

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;
  signOut() async {
    await Authentication.signOut().whenComplete(() {
      Navigator.pushReplacementNamed(context, loggingOutRoute);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: ColorConstant.themeGrey,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.only(bottom: 2.h),
          automaticallyImplyLeading: true,
          previousPageTitle: LocaleKeys.settings_settings.tr(),
        ),
        child: ListView(
          children: [
            buttonGetter(
                const Icon(
                  CupertinoIcons.bell,
                  color: ColorConstant.softBlack,
                ),
                Text(
                  LocaleKeys.settings_notification.tr(),
                  style: settingTextStyle,
                ),
                () => showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const NotificationSettingsPage();
                      },
                    )),
            SizedBox(
              height: 1.h,
            ),
            /*
            buttonGetter(
                const Icon(CupertinoIcons.lock, color: ColorConstant.softBlack),
                Text("Privacy", style: settingTextStyle),
                () {}),
            SizedBox(
              height: 1.h,
            ),
                buttonGetter(
                const Icon(CupertinoIcons.shield,
                    color: ColorConstant.softBlack),
                Text("Security", style: settingTextStyle),
                () {}),
            SizedBox(
              height: 1.h,
            ),
              */
            buttonGetter(
                const Icon(CupertinoIcons.gear, color: ColorConstant.softBlack),
                Text(LocaleKeys.settings_options.tr(), style: settingTextStyle),
                () {
              showCupertinoDialog(
                  context: context, builder: (context) => const OptionsPage());
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.person_circle,
                    color: ColorConstant.softBlack),
                Text(LocaleKeys.settings_account.tr(), style: settingTextStyle),
                () {
              User? user = FirebaseAuth.instance.currentUser;

              showCupertinoDialog(
                  context: context,
                  builder: (context) => AccountSettingPage(
                        userUid: user!.uid,
                      ));
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.question_circle,
                    color: ColorConstant.softBlack),
                Text(
                  LocaleKeys.settings_help.tr(),
                  style: settingTextStyle,
                ), () {
              var refTest = FirebaseFirestore.instance
                  .collection('groups_chat')
                  .doc('0ainitgroup')
                  .collection('chat_data')
                  .doc();
              refTest.set({
                      'member_avatar_url': 'https://firebasestorage.googleapis.com/v0/b/isola-b2dd8.appspot.com/o/default_files%2Fdefault_profile_photo.png?alt=media&token=fd38c835-ce62-4e3b-8dec-3914f2c94586',
      'member_message': "mmessage",
      'member_message_time': DateTime.now().toUtc(),
      'member_name': "Member 1",
      'member_uid':"",
      'member_message_isvoice': false,
      'member_message_voice_url': "",
      'member_message_isattachment': false,
      'member_message_attachment_url': "",
      'member_message_isimage': false,
      'member_message_isvideo': false,
      'member_message_isdocument': false,
      'member_message_target_1_uid': "",
      'member_message_target_2_uid': "",
      'member_message_no': "messageno",
              });
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.book, color: ColorConstant.softBlack),
                Text(LocaleKeys.settings_guidebook.tr(),
                    style: settingTextStyle), () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const GuideBookPage()));
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(CupertinoIcons.info_circle,
                    color: ColorConstant.softBlack),
                Text(LocaleKeys.settings_about.tr(), style: settingTextStyle),
                () {
              showCupertinoModalPopup(
                  context: context,
                  //imageUrlList[index].userName
                  builder: (BuildContext context) => const AboutFeedSheet());
            }),
            SizedBox(
              height: 1.h,
            ),
            buttonGetter(
                const Icon(
                  CupertinoIcons.left_chevron,
                  color: ColorConstant.softBlack,
                ),
                Text(LocaleKeys.settings_logout.tr(), style: settingTextStyle),
                () => signOut()),
          ],
        ));
  }
}

//
Widget buttonGetter(
    Icon settingsItemIcon, Text settingsItemText, Function() settingsItemFunc) {
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
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: settingsItemIcon,
            ),
            settingsItemText,
          ],
        ),
        onPressed: settingsItemFunc,
      ),
    ),
  );
}

class AboutFeedSheet extends StatelessWidget {
  const AboutFeedSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            child: Text(LocaleKeys.main_termsandconditions.tr()),
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return TermsAndPrivacyDialog(
                      mdFileName: 'terms_and_conditions.md',
                      packageName: 'Terms And Conditions',
                    );
                  });
              //  Navigator.pop(context);
            }),
        CupertinoActionSheetAction(
          child: Text(LocaleKeys.main_privacypolicy.tr()),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return TermsAndPrivacyDialog(
                  mdFileName: 'privacy_policy.md',
                  packageName: 'Privacy Policy',
                );
              },
            );
          },
        ),
        CupertinoActionSheetAction(
          child: Text(LocaleKeys.settings_licences.tr()),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return const LicencesPage();
              },
            );
          },
        ),
        CupertinoActionSheetAction(
          child: Text(LocaleKeys.settings_rules.tr()),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return TermsAndPrivacyDialog(
                  mdFileName: 'rules_and_info.md',
                  packageName: 'Rules And Info',
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class LicencesPage extends StatefulWidget {
  const LicencesPage({Key? key}) : super(key: key);

  @override
  State<LicencesPage> createState() => _LicencesPageState();
}

class _LicencesPageState extends State<LicencesPage> {
  var licencesButtonList = <LicencesButton>[];

  var licencesList = [
    'CupertinoIcons',
    'EasyLocalization',
    'Sizer',
    'FlutterCircularText',
    'PullToRefresh',
    'FlutterStaggeredGridView',
    'AutoSizeText',
    'Provider',
    'FlutterBloc',
    'Uuid',
    'HiveFlutter',
    'HiveGenerator',
    'ImagePicker',
    'ExtendedImage',
    'PathProvider',
    'FlutterAudioRecorder2',
    'AudioPlayers',
    'AudioVideoProgressBar',
    'FilePicker',
    'FlutterCachedPdfView',
    'VideoPlayer',
    'FlutterMarkdown',
    'GeoLocator',
    'Lottie',
    'Image',
    'ImageEditor',
    'WechatAssetsPicker',
    'LiquidProgressIndicator',
    'FirebaseCore',
    'FirebaseAuth',
    'FirebaseDatabase',
    'GoogleSignIn',
    'FirebaseStorage',
    'CloudFirestore',
    'CachedNetworkImage',
    'FirebaseMessaging',
    'FlutterLocalNotifications',
    'LikeButton',
    'SwipableStack',
    'InAppReview',
    'FlutterCacheManager',
    'CircularCountDownTimer',
    'GoogleFonts',
    'GoogleMobileAds'
  ];

  @override
  void initState() {
    super.initState();

    for (var item in licencesList) {
      var licencesButtonItem = LicencesButton(settingsItemText: item);

      licencesButtonList.add(licencesButtonItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: ColorConstant.themeGrey,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.only(bottom: 2.h),
          automaticallyImplyLeading: true,
          previousPageTitle: LocaleKeys.settings_settings.tr(),
        ),
        child: ListView.builder(
            itemCount: licencesButtonList.length,
            itemBuilder: (context, indeksNumarasi) =>
                licencesButtonList[indeksNumarasi]
            /*   licencesButtonGetter(
                Text("Cupertino Icons", style: settingTextStyle), () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'privacy_policy.md',
                  );
                },
              );
            }),
               licencesButtonGetter(
                Text("Easy Localization", style: settingTextStyle), () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'privacy_policy.md',
                  );
                },
              );
            }),

            licencesButtonGetter(Text("Provider", style: settingTextStyle), () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'privacy_policy.md',
                  );
                },
              );
            }),
  */

            ));
  }
}

class LicencesButton extends StatelessWidget {
  const LicencesButton({Key? key, required this.settingsItemText})
      : super(key: key);
  final String settingsItemText;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(vertical: 0.1.h),
        child: CupertinoButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(settingsItemText, style: settingTextStyle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: const Icon(
                  CupertinoIcons.forward,
                  color: CupertinoColors.systemGrey2,
                ),
              ),
            ],
          ),
          onPressed: () => showCupertinoDialog(
            context: context,
            builder: (context) {
              return LicencesDialog(
                mdFileName: '$settingsItemText.md',
                packageName: settingsItemText,
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  bool newMatches = true;
  bool groupMessages = true;
  bool chaosMessages = true;
  bool likes = true;
  bool tokens = true;
  bool systemNotifications = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userNotificationSettingsGetter(user!.uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CupertinoActivityIndicator();

            default:
              if (snapshot.hasError) {
                return const Text("Error");
              } else {
                var comingData = snapshot.data as UserNotificationSettings;

                newMatches = comingData.new_matches;
                groupMessages = comingData.group_messages;
                chaosMessages = comingData.chaos_messages;
                likes = comingData.likes;
                systemNotifications = comingData.system_notifications;
                tokens = comingData.tokens;

                return CupertinoPageScaffold(
                  backgroundColor: ColorConstant.themeGrey,
                  navigationBar: CupertinoNavigationBar(
                    padding: EdgeInsetsDirectional.only(bottom: 2.h),
                    automaticallyImplyLeading: true,
                    middle: Text(LocaleKeys.settings_notification.tr()),
                    previousPageTitle: LocaleKeys.settings_settings.tr(),
                  ),
                  child: ListView(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      NotificationChangeButton(
                        switchName: LocaleKeys.notifications_newmatches.tr(),
                        switchStatus: newMatches,
                        switchDbName: 'new_matches',
                        userUid: user!.uid,
                      ),
                      NotificationChangeButton(
                        switchName: LocaleKeys.notifications_groupmessages.tr(),
                        switchStatus: groupMessages,
                        switchDbName: 'group_messages',
                        userUid: user!.uid,
                      ),
                      NotificationChangeButton(
                        switchName: LocaleKeys.notifications_chaosmessages.tr(),
                        switchStatus: chaosMessages,
                        switchDbName: 'chaos_messages',
                        userUid: user!.uid,
                      ),
                      NotificationChangeButton(
                        switchName: LocaleKeys.notifications_likes.tr(),
                        switchStatus: likes,
                        switchDbName: 'likes',
                        userUid: user!.uid,
                      ),
                      NotificationChangeButton(
                        switchName: LocaleKeys.notifications_tokens.tr(),
                        switchStatus: tokens,
                        switchDbName: 'tokens',
                        userUid: user!.uid,
                      ),
                      NotificationChangeButton(
                        switchName:
                            LocaleKeys.notifications_systemnotifications.tr(),
                        switchStatus: systemNotifications,
                        switchDbName: 'system_notifications',
                        userUid: user!.uid,
                      ),
                    ],
                  ),
                );
              }
          }
        });
  }
}

// ignore: must_be_immutable
class NotificationChangeButton extends StatefulWidget {
  NotificationChangeButton(
      {Key? key,
      required this.switchName,
      required this.switchStatus,
      required this.switchDbName,
      required this.userUid})
      : super(key: key);
  final String switchName;
  bool switchStatus;
  final String switchDbName;
  final String userUid;

  @override
  State<NotificationChangeButton> createState() =>
      _NotificationChangeButtonState();
}

class _NotificationChangeButtonState extends State<NotificationChangeButton> {
  void switcherOnChange(bool currentStatus) async {
    DocumentReference settingRef = FirebaseFirestore.instance
        .collection('users_notification_settings')
        .doc(widget.userUid);

    await settingRef.update({widget.switchDbName: currentStatus});

    setState(() {
      widget.switchStatus = currentStatus;
    });
  }

  TextStyle switchStyle = const TextStyle();

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(vertical: 0.1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(7.w, 0.5.h, 0.0, 0.5.h),
              child: Text(widget.switchName),
            ),
            Padding(
              padding: EdgeInsets.all(1.h),
              child: CupertinoSwitch(
                value: widget.switchStatus,
                onChanged: switcherOnChange,
                activeColor: ColorConstant.iGradientMaterial3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
