// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, unused_field, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/blocs/group_merge_cubit.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/search_status_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chatpage.dart';
import 'package:isola_app/src/page/homepage.dart';
import 'package:isola_app/src/page/profilepage.dart';
import 'package:isola_app/src/page/searchpage.dart';
import 'package:isola_app/src/page/timelinepage.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:provider/src/provider.dart';
import '../blocs/current_chat_cubit.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({
    Key? key,
    this.currentState,
  }) : super(key: key);

  final int? currentState;

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with WidgetsBindingObserver {
  late User user;

  late IsolaUserAll userAll;
  late var userLikeHistory;
  String userUidForOnlinity = " ";

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  CollectionReference userDisplayRef =
      FirebaseFirestore.instance.collection('users_display');

  Future<void> _firebaseMessagingOnMessageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (message.data['notiCategory'] == 'chat_message') {
      if (message.data['notiGroupNo'] ==
          context.read<CurrentChatCubit>().state) {
        messaging.setForegroundNotificationPresentationOptions(
            alert: false, badge: false, sound: false);
      } else {
        messaging.setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
      }
    } else {
      messaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

    if (message.notification!.body == 'The group member left the group ') {
      try {
        Navigator.maybePop(context);
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  Future<void> _firebaseMessagingOpenedAppHandler(
      RemoteMessage message) async {}

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser!;

    FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessageHandler);
    FirebaseMessaging.onMessageOpenedApp
        .listen(_firebaseMessagingOpenedAppHandler);
    context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = true;

    userDisplayRef.doc(user.uid).update({'uOnline': true});

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    userUidForOnlinity = user.uid;
    getUserAllFromDataBase(user.uid)
        .then((value) => userAll = value)
        .whenComplete(() {
      context
          .read<JoinedListCubit>()
          .joinedListAllAdd(userAll.isolaUserMeta.joinedGroupList);

      if (userAll.isolaUserMeta.userIsSearching == true) {
        context.read<SearchStatusCubit>().searching();
      } else {
        context.read<SearchStatusCubit>().pauseSearching();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      print(
          "uygulamalar arası geçişte\nyukarıdan saati çekince\ndiger yukarıdan çekilen sürgü ile");

      messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (state == AppLifecycleState.paused) {
      await userDisplayRef.doc(userUidForOnlinity).update({'uOnline': false});

      //  print(" altta atıldı");
      messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (state == AppLifecycleState.resumed) {
      print('resume');
      //"alta atıp geri gelince");
      await userDisplayRef.doc(userUidForOnlinity).update({'uOnline': true});

      messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (state == AppLifecycleState.detached) {
      print("detached");
      messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = false;
      await DefaultCacheManager().removeFile("cachedImageFiles");
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: ColorConstant.milkColor,
        currentIndex: widget.currentState ?? 2,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("asset/img/bottom_timeline.png"),
            activeIcon: Image.asset("asset/img/bottom_timeline_act.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("asset/img/bottom_search.png"),
            activeIcon: Image.asset("asset/img/bottom_search_act.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("asset/img/bottom_homebutton.png"),
            activeIcon: Image.asset("asset/img/bottom_homebutton_act.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("asset/img/bottom_chat.png"),
            activeIcon: Image.asset("asset/img/bottom_chat_act.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("asset/img/bottom_profile.png"),
            activeIcon: Image.asset("asset/img/bottom_profile_act.png"),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                //    future: getDisplayData(user.uid),
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      //  return const CupertinoActivityIndicator();
                      return TimelinePage(user: user, userAll: userAll);

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        var userAllSnap = snapshot.data as IsolaUserAll;

                        context.read<UserAllCubit>().userAllChanger(
                              userAllSnap,
                            );
  
                        return TimelinePage(user: user, userAll: userAllSnap);
                      }
                  }
                },
              );
            });

          case 1:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      //  return const CupertinoActivityIndicator();
                      return SearchPage(user: user, userAll: userAll);

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        var userAllSnap = snapshot.data as IsolaUserAll;

                        return SearchPage(
                          user: user,
                          userAll: userAllSnap,
                        );
                      }
                  }
                },
              );
            });
          case 2:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      // return const CupertinoActivityIndicator();
                   
                      return HomePage(
                          userAll: context.read<UserAllCubit>().state);

                    case ConnectionState.done:
                      
                      var userAllInfo = snapshot.data as IsolaUserAll;
                      context.read<UserAllCubit>().userAllChanger(
                            userAllInfo,
                          );
                           

             
                      return HomePage(
                        userAll: userAllInfo,
                      );

                    /*  default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        var userAllInfo = snapshot.data as IsolaUserAll;

                        context
                            .read<UserAllCubit>()
                            .userAllChanger(userAllInfo);

                        return HomePage(
                          userAll: userAllInfo,
                        );
                      }*/
                    case ConnectionState.none:

                      return const Text("Error");
                    case ConnectionState.active:
                   
                      return HomePage(
                          userAll: context.read<UserAllCubit>().state);
                  }
                },
              );
            });
          case 3:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                  future: mergeForChatPage(user.uid),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        if (context
                                .read<GroupMergeCubit>()
                                .state
                                .userAll
                                .isolaUserMeta
                                .userUid ==
                            'null') {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else {
                          return ChatPage(
                              user: user,
                              groupMergeData:
                                  context.read<GroupMergeCubit>().state,
                              messaging: messaging);
                        }
                      //  return const Center( child: CupertinoActivityIndicator());

                      /*    var groupsModelInit = GroupsModel(false, 2, true, true,
                            true, true, 1, [], "0ainitgroup", false, "", false);

                        var dataLst = <GroupsModel>[groupsModelInit,groupsModelInit,groupsModelInit];
                        var initData =
                            GroupMergeData(userAll,dataLst, []);*/

                      /* case ConnectionState.done:
                        if ((snapshot.data as GroupMergeData)
                                    .userAll
                                    .isolaUserMeta
                                    .joinedGroupList[0] ==
                                "nothing" &&
                            (snapshot.data as GroupMergeData)
                                    .userAll
                                    .isolaUserMeta
                                    .userIsSearching ==
                                false) {
                  
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("asset/img/chat_warning_icon.png"),
                                const Text(
                                  "You didnt join group",
                                  style:
                                      TextStyle(color: ColorConstant.softBlack),
                                ),
                              ],
                            ),
                          );
                        } else {
                          var refChatPageItems =
                              snapshot.data as GroupMergeData;
   context
                              .read<GroupMergeCubit>()
                              .groupMergeChanger(refChatPageItems);
                          return ChatPage(
                            user: user,
                            groupMergeDataComing: refChatPageItems,
                            messaging: messaging,
                          );
                        }
*/

                      case ConnectionState.none:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("asset/img/chat_warning_icon.png"),
                              const Text(
                                "You didnt join group",
                                style:
                                    TextStyle(color: ColorConstant.softBlack),
                              ),
                            ],
                          ),
                        );

                      case ConnectionState.active:
                        if (context
                                .read<GroupMergeCubit>()
                                .state
                                .userAll
                                .isolaUserMeta
                                .userUid ==
                            'null') {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else {
                          return ChatPage(
                              user: user,
                              groupMergeData:
                                  context.read<GroupMergeCubit>().state,
                              messaging: messaging);
                        }
                      case ConnectionState.done:
                        if (snapshot.hasError ||
                            context
                                        .read<GroupMergeCubit>()
                                        .userMeta
                                        .joinedGroupList
                                        .first ==
                                    'nothing' &&
                                context
                                        .read<GroupMergeCubit>()
                                        .userMeta
                                        .userIsSearching ==
                                    false) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("asset/img/chat_warning_icon.png"),
                                const Text(
                                  "You didnt join group",
                                  style:
                                      TextStyle(color: ColorConstant.softBlack),
                                ),
                              ],
                            ),
                          );
                        } else {
                 
                          var refChatPageItems =
                              snapshot.data as GroupMergeData;
                          context
                              .read<GroupMergeCubit>()
                              .groupMergeChanger(refChatPageItems);
                          return ChatPage(
                            user: user,
                            groupMergeData: refChatPageItems,
                            messaging: messaging,
                          );
                        }
                    }
                  });
            });

          case 4:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      // return const CupertinoActivityIndicator();
                      return ProfilePage(user: user, userAll: userAll);

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        var userAllSnap = snapshot.data as IsolaUserAll;

                        context
                            .read<UserAllCubit>()
                            .userAllChanger(userAllSnap);
                        return ProfilePage(user: user, userAll: userAllSnap);
                      }
                  }
                },
              );
            });
        }

        return CupertinoTabView(builder: (BuildContext context) {
          return FutureBuilder(
            future: getUserAllFromDataBase(user.uid),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CupertinoActivityIndicator();
                // return HomePage(
                //   userAll: userAll,
                //   );

                default:
                  if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    var userAll = snapshot.data as IsolaUserAll;

                    context.read<UserAllCubit>().userAllChanger(userAll);
 context
                            .read<GroupMergeCubit>()
                            .groupMergeUserAllChanger(userAll);
                    return HomePage(
                      userAll: userAll,
                    );
                  }
              }
            },
          );
        });
      },
    );
  }
}
