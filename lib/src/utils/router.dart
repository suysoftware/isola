import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:isola_app/src/page/groupchat/group_settings_page.dart';
import 'package:isola_app/src/page/logging_out.dart';
import 'package:isola_app/src/page/navigationbar.dart';
import 'package:isola_app/src/page/settings_page.dart';
import 'package:isola_app/src/page/splash_page.dart';

import '../page/groupchat/chatpage/chat_chaos/chaos_chatting_page.dart';

class RouterSystem {
  static Route<dynamic> generateRoute(RouteSettings settings, [User? user,]) {
    switch (settings.name) {
      case loggingOutRoute:
        return CupertinoPageRoute(builder: (_) => const LoggingOut());
      case navigationBar:
        return CupertinoPageRoute(builder: (_) =>  const NavigationBar());
      case chatInteriorPage:
        return CupertinoPageRoute(builder: (_) => const ChatInteriorPage());
        case chaosChatInteriorPage:
        return CupertinoPageRoute(builder: (_) => const ChaosChatInteriorPage());
      case groupSettingsPage:
        return CupertinoPageRoute(builder: (_) => const GroupSettingsPage());
      case settingsPage:
        return CupertinoPageRoute(builder: (_) => const SettingsPage());
     
      case splashPage:
        return CupertinoPageRoute(builder: (_) => const SplashPage());

      default:
        return CupertinoPageRoute(
            builder: (_) => const CupertinoPageScaffold(
                backgroundColor: CupertinoColors.systemRed,
                child: Text("birşeyler teers giti")));
    }
  }
}

const String loggingOutRoute = '/LoggingOut';
//const String homePageRoute = '/HomePage';
const String navigationBar = '/NavigationBar';
const String chatInteriorPage = '/ChatInteriorPage';
const String chaosChatInteriorPage = '/ChaosChatInteriorPage';
const String groupSettingsPage = '/GroupSettingsPage';
const String settingsPage = '/SettingsPage';
const String splashPage = '/';
