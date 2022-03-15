import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/target_profiles/profiles_biography.dart';
import 'package:isola_app/src/page/target_profiles/profiles_media.dart';
import 'package:isola_app/src/page/target_profiles/profiles_timeline.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:sizer/sizer.dart';

class TargetProfilePage extends StatefulWidget {
  const TargetProfilePage({Key? key, required this.feedMeta}) : super(key: key);

  final FeedMeta feedMeta;

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
          feedMeta: widget.feedMeta,
        );

      case 1:
        return TargetProfileMediaPage(userUid: widget.feedMeta.userUid);

      case 2:
        return TargetProfileBiographPage(
          feedMeta: widget.feedMeta,
        );
      default:
        return TargetProfileTimelinePage(feedMeta: widget.feedMeta);
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
        trailing: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
              onTap: () {},
              child: Image.asset("asset/img/settings_button.png")),
        ),
      ),
      child: FutureBuilder(
        future: getUserDisplay(widget.feedMeta.userUid),
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
                                                              .feedMeta
                                                              .avatarUrl,
                                                          width: 120.sp,
                                                          height: 120.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: widget
                                                              .feedMeta
                                                              .avatarUrl,
                                                          width: 80.sp,
                                                          height: 80.sp,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(CupertinoIcons
                                                                  .xmark_square),
                                                        ))
                                                  : CachedNetworkImage(
                                                      imageUrl: widget
                                                          .feedMeta.avatarUrl,
                                                      width: 65.sp,
                                                      height: 65.sp,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
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
                              widget.feedMeta.userName,
                              style: 100.h >= 1100
                                  ? StyleConstants.profileNameTabletTextStyle
                                  : StyleConstants.profileNameTextStyle,
                            ),
                            widget.feedMeta.userIsOnline
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
                        widget.feedMeta.userUniversity,
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
                var targetDisplay = snapshot.data as UserDisplay;

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
                                                          imageUrl:targetDisplay
                                                              .avatarUrl,
                                                          width: 120.sp,
                                                          height: 120.sp,
                                                          fit: BoxFit.cover,
                                                           errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                        )
                                                      : CachedNetworkImage(
                                                         imageUrl: targetDisplay
                                                              .avatarUrl,
                                                          width: 80.sp,
                                                          height: 80.sp,
                                                          fit: BoxFit.cover,
                                                           errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                        ))
                                                  : CachedNetworkImage(
                                                      imageUrl:targetDisplay.avatarUrl,
                                                      width: 65.sp,
                                                      height: 65.sp,
                                                      fit: BoxFit.cover,
                                                       errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
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
