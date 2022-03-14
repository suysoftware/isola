// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, unused_field, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/search_status_cubit.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chatpage.dart';
import 'package:isola_app/src/page/homepage.dart';
import 'package:isola_app/src/page/profilepage.dart';
import 'package:isola_app/src/page/searchpage.dart';
import 'package:isola_app/src/page/timelinepage.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:provider/src/provider.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with WidgetsBindingObserver {
  late User user;
  late var _refUserDisplay;

// late UserDisplay userDisplay;
  late IsolaUserAll userAll;
  late var userLikeHistory;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser!;
    _refUserDisplay = refGetter(
        enum2: RefEnum.Userdisplay,
        targetUid: user.uid,
        userUid: user.uid,
        crypto: "");
    context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = true;

    _refUserDisplay.child("user_is_online").set(true);
    //  getDisplayData(user.uid).then((value) => userDisplay = value);
    getUserAllFromDataBase(user.uid)
        .then((value) => userAll = value)
        .whenComplete(() {
      context
          .read<JoinedListCubit>()
          .joinedListAllAdd(userAll.isolaUserMeta.joinedGroupList);

      if (userAll.isolaUserMeta.userIsSearching == true) {
        context.read<SearchStatusCubit>().searching();
        print("searhingbastınavigation");
      } else {
        context.read<SearchStatusCubit>().pauseSearching();
        print("pausesearhingbastınavigation");
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
    }

    if (state == AppLifecycleState.paused) {
      print(" altta atıldı");
      await _refUserDisplay.child("user_is_online").set(false);
      context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = false;
    }

    if (state == AppLifecycleState.resumed) {
      print("alta atıp geri gelince");
      await _refUserDisplay.child("user_is_online").set(true);
      context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = true;
    }

    if (state == AppLifecycleState.detached) {
      print("detached");

      _refUserDisplay.child("user_is_online").set(false);
      context.read<UserAllCubit>().state.isolaUserDisplay.userIsOnline = false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      //  backgroundColor: ColorConstant.milkColor,
      tabBar: CupertinoTabBar(
        backgroundColor: ColorConstant.milkColor,
        currentIndex: 2,
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
                      return const CupertinoActivityIndicator();

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        /*
                        var userDisplaySnap = snapshot.data as UserDisplay;
                        return TimelinePage(
                          user: user,
                          userDisplay: userDisplay,
                        );
                        */
                        var userAllSnap = snapshot.data as IsolaUserAll;

                        context
                            .read<UserAllCubit>()
                            .userAllChanger(userAllSnap);
                        return TimelinePage(user: user, userAll: userAllSnap);
                      }
                  }
                },
              );
            });

          case 1:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                //  future: getDisplayData(user.uid),
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CupertinoActivityIndicator();

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        /*
                        var userDisplaySnap = snapshot.data as UserDisplay;
                        return SearchPage(
                          user: user,
                          userDisplay: userDisplay,
                        );
                        */
                        var userAllSnap = snapshot.data as UserAll;
                        context.read<UserAllCubit>().userAllChanger(userAll);
                        return SearchPage(user: user, userAll: userAll);
                      }
                  }
                },
              );
            });
          case 2:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                // future: getDisplayData(user.uid),
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CupertinoActivityIndicator();

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        // var userDisplaySnap = snapshot.data as UserDisplay;
                        var userAllInfo = snapshot.data as IsolaUserAll;

                        //    return HomePage(
                        //    userDisplay: userDisplaySnap,
                        //);
                        context
                            .read<UserAllCubit>()
                            .userAllChanger(userAllInfo);

                        return HomePage(
                          userAll: userAllInfo,
                        );
                        //   searchStatus: userAll.searchStatus);
                      }
                  }
                },
              );
            });
          case 3:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                  //   future: getAllDataForChatPage(user.uid),
                  future: mergeForChatPage(user.uid),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: const CupertinoActivityIndicator());
                      case ConnectionState.done:
                          if ((snapshot.data as GroupMergeData).userAll.isolaUserMeta.joinedGroupList[0]=="nothing"&&(snapshot.data as GroupMergeData).userAll.isolaUserMeta.userIsSearching==false) {
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
                          return ChatPage(
                            user: user,
                            groupMergeDataComing: refChatPageItems,
                          );
                        }


                      default:
                        if (snapshot.hasError||!snapshot.hasData) {
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
                          return ChatPage(
                            user: user,
                            groupMergeDataComing: refChatPageItems,
                          );
                        }
                    }
                  });
            });

          case 4:
            return CupertinoTabView(builder: (BuildContext context) {
              return FutureBuilder(
                //future: getDisplayData(user.uid),
                future: getUserAllFromDataBase(user.uid),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CupertinoActivityIndicator();

                    default:
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        /*
                        var userDisplaySnap = snapshot.data as UserDisplay;
                        return ProfilePage(
                          user: user,
                          userDisplay: userDisplay,
                        );
                        */
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
            //  future: getDisplayData(user.uid),
            future: getUserAllFromDataBase(user.uid),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CupertinoActivityIndicator();

                default:
                  if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    //  var userDisplaySnap = snapshot.data as UserDisplay;
                    var userAll = snapshot.data as IsolaUserAll;
                    //  return HomePage(
                    //  userDisplay: userDisplaySnap,
                    //);
                    context.read<UserAllCubit>().userAllChanger(userAll);

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
