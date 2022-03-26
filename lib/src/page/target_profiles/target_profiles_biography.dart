// ignore_for_file: prefer_final_fields, unused_field, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TargetProfileBiographPage extends StatefulWidget {
  const TargetProfileBiographPage({Key? key, required this.targetUid})
      : super(key: key);

  final String targetUid;

  @override
  _TargetProfileBiographPageState createState() =>
      _TargetProfileBiographPageState();
}

TextStyle biographyStyle = 100.h >= 1100
    ? StyleConstants.biographTabletTextStyle
    : StyleConstants.biographTextStyle;

TextStyle hobbiesStyle = 100.h >= 1100
    ? StyleConstants.hobbiesTabletTextStyle
    : StyleConstants.hobbiesTextStyle;

double hobbiesIconSize = 100.h >= 1100 ? 25.sp : 30.sp;

class _TargetProfileBiographPageState extends State<TargetProfileBiographPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase _refConnect = FirebaseDatabase.instance;
  late User user;
  // ignore: prefer_typing_uninitialized_variables
  //late var _refBio;

  void _onRefresh() async {}

  void _onLoading() async {}

  @override
  void initState() {
    super.initState();
    /*
    user = auth.currentUser!;
    _refBio = refGetter(
      enum2: RefEnum.Userdisplay,
      userUid: user.uid,
      targetUid: user.uid,
      crypto: '',
    );*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDisplay(widget.targetUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CupertinoActivityIndicator());
          }
          var userDisplay = snapshot.data as IsolaUserDisplay;
          return Flexible(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              footer: const ClassicFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0.0, 0.0, 0.5.h),
                        child: Text("Biography", style: biographyStyle),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100.h >= 1100 ? 15.h : 11.h,
                    width: 94.w,
                    child: BiographPageContainer(
                        contInteriorWidget: Padding(
                      padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 2.h),
                      child: FutureBuilder(
                        initialData: const CupertinoActivityIndicator(),
                        builder: (context, snapshot) {
                          return bioTextWidgetGetter(context,
                              targetMessage: userDisplay.userBiography,
                              targetName: "",
                              rowLetterValue: 70,
                              letterTextStyle: biographyStyle);
                        },
                      ),
                    )),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 1.h, 0.0, 0.5.h),
                        child: Text("Club & Activities (coming soon)", style: biographyStyle),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 100.h >= 1100 ? 15.h : 12.h),
                      child: const ClubGridView()),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 2.h, 0.0, 1.5.h),
                        child: Text(
                          "Hobbies & Interests",
                          style: biographyStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                "asset/img/hobbies_icons/active_${userDisplay.userInterest[0]}.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "${userDisplay.userInterest[0]}",
                              style: hobbiesStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                  "asset/img/hobbies_icons/active_${userDisplay.userInterest[1]}.png",
                                  fit: BoxFit.cover),
                            ),
                            Text(
                              "${userDisplay.userInterest[1]}",
                              style: hobbiesStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                "asset/img/hobbies_icons/active_${userDisplay.userInterest[2]}.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "${userDisplay.userInterest[2]}",
                              style: hobbiesStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                "asset/img/hobbies_icons/active_${userDisplay.userInterest[3]}.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text("${userDisplay.userInterest[3]}",
                                style: hobbiesStyle),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                "asset/img/hobbies_icons/active_${userDisplay.userInterest[4]}.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text("${userDisplay.userInterest[4]}",
                                style: hobbiesStyle),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ClubGridView extends StatelessWidget {
  const ClubGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 0.0, 0.0, 0.0),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   mainAxisSpacing: 20.w, crossAxisCount: 1, childAspectRatio: 2 / 1),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, mainAxisExtent: 45.w, mainAxisSpacing: 3.w),

        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, indeks) {
          return ClubImageTile(
            index: indeks,
            width: 200,
            height: 200,
          );
        },
      ),
    );
  }
}

class ClubImageTile extends StatelessWidget {
  const ClubImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return BiographPageContainer(
      contInteriorWidget: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
          imageUrl: 'https://picsum.photos/$width/$height?random=$index',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Icon(CupertinoIcons.xmark_square),
        ),
      ),
    );
  }
}

class BiographPageContainer extends StatelessWidget {
  Widget contInteriorWidget;

  BiographPageContainer({Key? key, required this.contInteriorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: ColorConstant.isolaMainGradient,
            border: Border.all(color: ColorConstant.transparentColor),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.milkColor,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: contInteriorWidget),
        ),
      ),
    );
  }
}
