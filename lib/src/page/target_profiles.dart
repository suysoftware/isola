import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/target_profiles/target_profiles_biography.dart';
import 'package:isola_app/src/page/target_profiles/target_profiles_media.dart';
import 'package:isola_app/src/page/target_profiles/target_profiles_timeline.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:sizer/sizer.dart';

class TargetProfilePage extends StatefulWidget {
  const TargetProfilePage(
      {Key? key,
      required this.targetUid,
      required this.targetAvatarUrl,
      required this.targetName,
      required this.userUid,
      required this.isolaUserAll})
      : super(key: key);

  final String targetUid;
  final String targetAvatarUrl;
  final String targetName;
  final String userUid;
  final IsolaUserAll isolaUserAll;

  @override
  _TargetProfilePageState createState() => _TargetProfilePageState();
}

TextStyle navigatorStyle = 100.h >= 700
    ? (100.h >= 1100
        ? StyleConstants.profileNaviTabletTextStyle
        : StyleConstants.profileNaviTextStyle)
    : StyleConstants.profileMiniNaviTextStyle;

class _TargetProfilePageState extends State<TargetProfilePage> {
  int _profileSegmentedValue = 0;

  final Map<int, Widget> _profileTabs = <int, Widget>{
    0: Container(
      padding: EdgeInsets.zero,
      child: Text(
        "Timeline",
        style: navigatorStyle,
      ),
      color: ColorConstant.themeGrey,
    ),
    1: Padding(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text(
          "Media",
          style: navigatorStyle,
        ),
        color: ColorConstant.themeGrey,
      ),
    ),
    2: Padding(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text(
          "Biograph",
          style: navigatorStyle,
        ),
        color: ColorConstant.themeGrey,
      ),
    ),
  };

  StatefulWidget buildProfileWidget() {
    switch (_profileSegmentedValue) {
      case 0:
        return TargetProfileTimelinePage(
          targetUid: widget.targetUid,
          userUid: widget.userUid,
          isolaUserAll: widget.isolaUserAll,
        );

      case 1:
        return TargetProfileMediaPage(
          userAll: widget.isolaUserAll,
          targetUid: widget.targetUid,
        );

      case 2:
        return TargetProfileBiographPage(
          targetUid: widget.targetUid,
        );
      default:
        return TargetProfileTimelinePage(
          targetUid: widget.targetUid,
          userUid: widget.userUid,
          isolaUserAll: widget.isolaUserAll,
        );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorConstant.milkColor,
        automaticallyImplyLeading: true,
     /*   trailing: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
              onTap: () {},
              child: Image.asset("asset/img/settings_button.png")),
        ),*/
      ),
      child: FutureBuilder(
        future: getUserDisplay(widget.targetUid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CupertinoActivityIndicator());

            default:
              if (snapshot.hasError) {
                return Container(
                  color: ColorConstant.themeGrey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 2.h, 0.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient:
                                            ColorConstant.isolaMainGradient,
                                        border: Border.all(
                                            color:
                                                ColorConstant.transparentColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60.sp))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.milkColor,
                                              border: Border.all(
                                                  color: ColorConstant
                                                      .transparentColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60.sp))),
                                          child: ClipOval(
                                              child: 100.h >= 700
                                                  ? (100.h <= 1100
                                                      ? CachedNetworkImage(
                                                          imageUrl: widget
                                                              .targetAvatarUrl,
                                                          width: 120.sp,
                                                          height: 120.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                          cacheManager:
                                                              CacheManager(
                                                                  Config(
                                                            "cachedImageFiles",
                                                            stalePeriod:
                                                                const Duration(
                                                                    days: 3),
                                                            //one week cache period
                                                          )),
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: widget
                                                              .targetAvatarUrl,
                                                          width: 80.sp,
                                                          height: 80.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                          cacheManager:
                                                              CacheManager(
                                                                  Config(
                                                            "cachedImageFiles",
                                                            stalePeriod:
                                                                const Duration(
                                                                    days: 3),
                                                            //one week cache period
                                                          )),
                                                        ))
                                                  : CachedNetworkImage(
                                                      imageUrl: widget
                                                          .targetAvatarUrl,
                                                      width: 65.sp,
                                                      height: 65.sp,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                      cacheManager:
                                                          CacheManager(Config(
                                                        "cachedImageFiles",
                                                        stalePeriod:
                                                            const Duration(
                                                                days: 3),
                                                        //one week cache period
                                                      )),
                                                    ))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            Text(
                              widget.targetName,
                              style: 100.h >= 1100
                                  ? StyleConstants.profileNameTabletTextStyle
                                  : StyleConstants.profileNameTextStyle,
                            ),
                            true
                                ? Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.asset(
                                        "asset/img/profile_online.png"),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.asset(
                                        "asset/img/profile_offline.png"),
                                  ),
                          ],
                        ),
                      ),
                      Text(
                        "uni",
                        style: 100.h >= 1100
                            ? StyleConstants.profileUniversityTabletTextStyle
                            : StyleConstants.profileUniversityTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(
                                      color: ColorConstant.softPurple
                                          .withOpacity(0.6),
                                      width: 1.5))),
                          child: CupertinoSlidingSegmentedControl(
                              backgroundColor: ColorConstant.themeGrey,
                              thumbColor: ColorConstant.themeGrey,
                              groupValue: _profileSegmentedValue,
                              padding: const EdgeInsets.all(4.0),
                              children: _profileTabs,
                              onValueChanged: (dynamic i) {
                                setState(() {
                                  _profileSegmentedValue = i;
                                });
                              }),
                        ),
                      ),
                      buildProfileWidget(),
                    ],
                  ),
                );
              } else {
                /*
                        var userDisplaySnap = snapshot.data as UserDisplay;
                        return TimelinePage(
                          user: user,
                          userDisplay: userDisplay,
                        );
                        */
                var targetDisplay = snapshot.data as IsolaUserDisplay;

                return Container(
                  color: ColorConstant.themeGrey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 2.h, 0.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient:
                                            ColorConstant.isolaMainGradient,
                                        border: Border.all(
                                            color:
                                                ColorConstant.transparentColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60.sp))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.milkColor,
                                              border: Border.all(
                                                  color: ColorConstant
                                                      .transparentColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60.sp))),
                                          child: ClipOval(
                                              child: 100.h >= 700
                                                  ? (100.h <= 1100
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              targetDisplay
                                                                  .avatarUrl,
                                                          width: 120.sp,
                                                          height: 120.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                          cacheManager:
                                                              CacheManager(
                                                                  Config(
                                                            "cachedImageFiles",
                                                            stalePeriod:
                                                                const Duration(
                                                                    days: 3),
                                                            //one week cache period
                                                          )),
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl:
                                                              targetDisplay
                                                                  .avatarUrl,
                                                          width: 80.sp,
                                                          height: 80.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                          cacheManager:
                                                              CacheManager(
                                                                  Config(
                                                            "cachedImageFiles",
                                                            stalePeriod:
                                                                const Duration(
                                                                    days: 3),
                                                            //one week cache period
                                                          )),
                                                        ))
                                                  : CachedNetworkImage(
                                                      imageUrl: targetDisplay
                                                          .avatarUrl,
                                                      width: 65.sp,
                                                      height: 65.sp,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                      cacheManager:
                                                          CacheManager(Config(
                                                        "cachedImageFiles",
                                                        stalePeriod:
                                                            const Duration(
                                                                days: 3),
                                                        //one week cache period
                                                      )),
                                                    ))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            Text(
                              targetDisplay.userName,
                              style: 100.h >= 1100
                                  ? StyleConstants.profileNameTabletTextStyle
                                  : StyleConstants.profileNameTextStyle,
                            ),
                            targetDisplay.userIsOnline
                                ? Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.asset(
                                        "asset/img/profile_online.png"),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Image.asset(
                                          "asset/img/profile_offline.png"),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Text(
                        targetDisplay.userUniversity,
                        style: 100.h >= 1100
                            ? StyleConstants.profileUniversityTabletTextStyle
                            : StyleConstants.profileUniversityTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(
                                      color: ColorConstant.softPurple
                                          .withOpacity(0.6),
                                      width: 1.5))),
                          child: CupertinoSlidingSegmentedControl(
                              backgroundColor: ColorConstant.themeGrey,
                              thumbColor: ColorConstant.themeGrey,
                              groupValue: _profileSegmentedValue,
                              padding: const EdgeInsets.all(4.0),
                              children: _profileTabs,
                              onValueChanged: (dynamic i) {
                                setState(() {
                                  _profileSegmentedValue = i;
                                });
                              }),
                        ),
                      ),
                      buildProfileWidget(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
