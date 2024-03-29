import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/blocs/chaos_chat_message_target.dart';
import 'package:isola_app/src/blocs/chaos_group_setting_cubit.dart';
import 'package:isola_app/src/blocs/chat_message_targets_cubit.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/chat_voice_message_cubit.dart';
import 'package:isola_app/src/blocs/current_chat_cubit.dart';
import 'package:isola_app/src/blocs/group_is_chaos_cubit.dart';
import 'package:isola_app/src/blocs/group_merge_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/match_button_cubit.dart';
import 'package:isola_app/src/blocs/search_cubit.dart';
import 'package:isola_app/src/blocs/search_status_cubit.dart';
import 'package:isola_app/src/blocs/sign_up_cubit.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/blocs/user_hive_cubit.dart';
import 'package:isola_app/src/constants/language_constants.dart';
import 'package:isola_app/src/model/chaos/chaos_group_setting_model.dart';
import 'package:isola_app/src/model/group/group_chat_voice.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/page/interest_add_page.dart';
import 'package:isola_app/src/page/profile/profile_interest_edit.dart';
import 'package:isola_app/src/page/splash_page.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:sizer/sizer.dart';

late Box box;
late UserHive _userHive;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //mesaj kategori ve tiplerini ayarla
  // ignore: avoid_print
  print('Handling a background message ${message.messageId}');
  await Firebase.initializeApp();
}

Future<void> main() async {
  await init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(EasyLocalization(
      supportedLocales: AppConstant.SUPPORTED_LOCALE,
      path: AppConstant.LANG_PATH,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  await Hive.initFlutter();
  box = await Hive.openBox('HiveDatabase2');
  await dotenv.load(fileName: ".env");
  Hive.registerAdapter(UserHiveAdapter());

  var history = <String>[];
  history.add("11");
  var likeList = <String>[];
  likeList.add("22");
  await Hive.openBox('userHive')
      .then((value) => _userHive = value.get('datetoday'))
      .onError((error, stackTrace) =>
          _userHive = UserHive(likesData: likeList, exloreData: history));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDisplay = IsolaUserDisplay(
        "null",
        "null",
        "null",
        true,
        true,
        ["interest1", "interest2"],
        true,
        "null",
        ["null1", "null2"],
        ["null1", "null2"],
        "");
    var userMeta = IsolaUserMeta(
        "null",
        0,
        ["null", "null"],
        "null",
        true,
        ["null", "null"],
        ["null", "null"],
        ["null", "null"],
        false,
        ["null", "null"]);

    var userAll = IsolaUserAll(userDisplay, userMeta);

    var groupSetting = GroupSettingModel(
        groupMemberAvatarUrl2: '',
        groupMemberAvatarUrl1: '',
        groupMemberAvatarUrl3: '',
        groupMemberName1: '',
        groupMemberName2: '',
        groupMemberName3: '',
        groupMemberUid3: '',
        groupMemberUid2: '',
        groupNo: '',
        userUid: '',
        newNotiValueAmount: 0);

    var chaosGroupSetting = ChaosGroupSettingModel(
      groupMemberAvatarUrl2: '',
      groupMemberAvatarUrl1: '',
      groupMemberAvatarUrl3: '',
      groupMemberName1: '',
      groupMemberName2: '',
      groupMemberName3: '',
      groupMemberUid3: '',
      groupMemberUid2: '',
      groupNo: '',
      userUid: '',
      groupMemberAvatarUrl4: '',
      groupMemberAvatarUrl6: '',
      groupMemberAvatarUrl5: '',
      groupMemberName4: '',
      groupMemberName5: '',
      groupMemberName6: '',
      groupMemberUid4: '',
      groupMemberUid5: '',
      groupMemberUid6: '',
    );

    var groupChatVoice =
        GroupChatVoice(const Icon(CupertinoIcons.play), const Duration(), "");

    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(create: (context) {
            return UserHiveCubit(_userHive);
          }),
          BlocProvider(
            create: (context) {
              return MatchButtonCubit();
            },
          ),
          BlocProvider(
            create: (context) {
              return SearchStatusCubit();
            },
          ),
          BlocProvider(
            create: (context) {
              return JoinedListCubit();
            },
          ),
          BlocProvider(
            create: (context) {
              return ChatReferenceCubit();
            },
          ),
          BlocProvider(
            create: (context) {
              return UserAllCubit(userAll);
            },
          ),
          BlocProvider(
            create: (context) {
              return GroupSettingCubit(groupSetting);
            },
          ),
          BlocProvider(
            create: (context) {
              return ChaosGroupSettingCubit(chaosGroupSetting);
            },
          ),
          BlocProvider(
            create: (context) {
              return ChatVoiceMessageCubit(groupChatVoice: groupChatVoice);
            },
          ),
          BlocProvider(create: (context) {
            return SignUpCubit();
          }),
          BlocProvider(create: (context) {
            return HobbyStatusCubit();
          }),
          BlocProvider(create: (context) {
            return HobbyEditStatusCubit();
          }),
          BlocProvider(create: (context) {
            return ChatMessageTargetsCubit();
          }),
          BlocProvider(create: (context) {
            return ChaosChatMessageTargetsCubit();
          }),
          BlocProvider(create: (context) {
            return ChatIsChaosCubit();
          }),
          BlocProvider(create: (context) {
            return TimelineItemListCubit(testItem: <TimelineItem>[]);
          }),
          BlocProvider(create: (context) {
            return CurrentChatCubit();
          }),
          BlocProvider(create: (context) {
            return GroupMergeCubit();
          }),
        ],
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const SplashPage(),
          onGenerateRoute: RouterSystem.generateRoute,
          initialRoute: splashPage,
        ),
      );
    });
  }
}
