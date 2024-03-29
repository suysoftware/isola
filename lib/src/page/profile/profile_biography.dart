// ignore_for_file: prefer_final_fields, unused_field, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/profile/profile_interest_edit.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/user_all_cubit.dart';
import '../../extensions/locale_keys.dart';

class ProfileBiographPage extends StatefulWidget {
  const ProfileBiographPage(
      {Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User? user;
  final IsolaUserAll userAll;

  @override
  _ProfileBiographPageState createState() => _ProfileBiographPageState();
}

TextStyle biographyStyle = 100.h >= 1100
    ? StyleConstants.biographTabletTextStyle
    : StyleConstants.biographTextStyle;

TextStyle hobbiesStyle = 100.h >= 1100
    ? StyleConstants.hobbiesTabletTextStyle
    : StyleConstants.hobbiesTextStyle;

class _ProfileBiographPageState extends State<ProfileBiographPage>
    with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase _refConnect = FirebaseDatabase.instance;

  var iconNameListForName = [
    LocaleKeys.interest_hiking.tr(),
    LocaleKeys.interest_reading.tr(),
    LocaleKeys.interest_art.tr(),
    LocaleKeys.interest_cooking.tr(),
    LocaleKeys.interest_theater.tr(),
    LocaleKeys.interest_traveling.tr(),
    LocaleKeys.interest_swimming.tr(),
    LocaleKeys.interest_basketball.tr(),
    LocaleKeys.interest_football.tr(),
    LocaleKeys.interest_volleyball.tr(),
    LocaleKeys.interest_tennis.tr(),
    LocaleKeys.interest_skiing.tr(),
    LocaleKeys.interest_cycling.tr(),
    LocaleKeys.interest_baseball.tr(),
    LocaleKeys.interest_climbing.tr(),
    LocaleKeys.interest_blogging.tr(),
    LocaleKeys.interest_astrology.tr(),
    LocaleKeys.interest_movies.tr(),
    LocaleKeys.interest_music.tr(),
    LocaleKeys.interest_gardening.tr(),
    LocaleKeys.interest_calligraphy.tr(),
    LocaleKeys.interest_yoga.tr(),
    LocaleKeys.interest_language.tr(),
    LocaleKeys.interest_camping.tr(),
    LocaleKeys.interest_dance.tr(),
    LocaleKeys.interest_games.tr(),
    LocaleKeys.interest_design.tr(),
    LocaleKeys.interest_photography.tr(),
    LocaleKeys.interest_chess.tr(),
    LocaleKeys.interest_running.tr(),
    LocaleKeys.interest_bowling.tr(),
    LocaleKeys.interest_skate.tr(),
    LocaleKeys.interest_martial.tr(),
    LocaleKeys.interest_fashion.tr(),
    LocaleKeys.interest_pet.tr()
  ];

  var iconNameList = [
    "hiking",
    "reading",
    "art",
    "cooking",
    "theater",
    "travelling",
    "swimming",
    "basketball",
    "football",
    "volleyball",
    "tennis",
    "skiing",
    "cycling",
    "baseball",
    "climbing",
    "blogging",
    "astrology",
    "movies",
    "music",
    "gardening",
    "calligraphy",
    "yoga",
    "language",
    "camping",
    "dance",
    "games",
    "design",
    "photography",
    "chess",
    "running",
    "bowling",
    "skate",
    "martial",
    "fashion",
    "pet"
  ];
  late User user;
  late IsolaUserAll userAll;
  bool editingHobby = false;
  String editingChooseText = " ";
  void _onRefresh() async {
    await getUserAllFromDataBase(widget.userAll.isolaUserMeta.userUid)
        .then((value) {
      setState(() {
        userAll = value;
                context
                          .read<UserAllCubit>()
                          .userAllChanger(value);
      });
    });

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {}

  @override
  void initState() {
    super.initState();

    user = auth.currentUser!;

    userAll = widget.userAll;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double hobbiesIconSize = editingHobby == false
        ? (100.h >= 1100 ? 25.sp : 30.sp)
        : (100.h >= 1100 ? 30.sp : 35.sp);

    int interestLine1 =
        iconNameList.indexOf(userAll.isolaUserDisplay.userInterest[0]);
    int interestLine2 =
        iconNameList.indexOf(userAll.isolaUserDisplay.userInterest[1]);
    int interestLine3 =
        iconNameList.indexOf(userAll.isolaUserDisplay.userInterest[2]);
    int interestLine4 =
        iconNameList.indexOf(userAll.isolaUserDisplay.userInterest[3]);
    int interestLine5 =
        iconNameList.indexOf(userAll.isolaUserDisplay.userInterest[4]);

    return Flexible(
      child: GestureDetector(
        onTap: () {
          setState(() {
            editingHobby = false;
          });
        },
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
                    child: Text(LocaleKeys.main_biography.tr(),
                        style: biographyStyle),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) => Center(
                    child: BioEditContainer(userAll: userAll),
                  ),
                ),
                child: SizedBox(
                  height: 100.h >= 1100 ? 13.h : 9.h,
                  width: 94.w,
                  child: BiographPageContainer(
                      contInteriorWidget: Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 2.h),
                    child: FutureBuilder(
                      initialData: const CupertinoActivityIndicator(),
                      builder: (context, snapshot) {
                        return bioTextWidgetGetter(context,
                            targetMessage:
                                userAll.isolaUserDisplay.userBiography,
                            targetName: "",
                            rowLetterValue: 70,
                            letterTextStyle: biographyStyle);
                      },
                    ),
                  )),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 1.h, 0.0, 0.5.h),
                    child: Text(
                        "${LocaleKeys.profile_clubandact.tr()} (${LocaleKeys.main_comingsoon.tr()})",
                        style: biographyStyle),
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
                    padding: EdgeInsets.fromLTRB(5.w, 2.h, 0.0, 0.5.h),
                    child: Text(LocaleKeys.profile_hobbiesandinterest.tr(),
                        style: biographyStyle),
                  ),
                ],
              ),
              Row(
                children: [
                  Visibility(
                    visible: editingHobby == true ? true : false,
                    child: GestureDetector(
                      onLongPress: () {},
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(1.w, 0.0, 0.0, 0.0),
                          child: CupertinoButton(
                              child: Icon(
                                CupertinoIcons.add_circled,
                                size: 24.sp,
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                ProfileInterestEditPage(
                                                    userAll: userAll)),
                                        ModalRoute.withName('/'))
                                    .whenComplete(() => editingHobby = false);
                              })),
                    ),
                  ),
                  GestureDetector(
                      onLongPress: () {
                        setState(() {
                          editingHobby = true;
                        });
                      },
                      child: Padding(
                        padding: editingHobby == false
                            ? EdgeInsets.fromLTRB(4.w, 0.0, 1.w, 0.0)
                            : EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hobbiesIconSize,
                              width: hobbiesIconSize,
                              child: Image.asset(
                                editingHobby == false
                                    ? "asset/img/hobbies_icons/active_${userAll.isolaUserDisplay.userInterest[0]}.png"
                                    : "asset/img/hobbies_icons_grey/${userAll.isolaUserDisplay.userInterest[0]}_grey_icon.png",
                                fit: editingHobby == false
                                    ? BoxFit.cover
                                    : BoxFit.contain,
                              ),
                            ),
                            editingHobby == false
                                ? Text(
                                    iconNameListForName[interestLine1],
                                    //  "${userAll.isolaUserDisplay.userInterest[0]}",
                                    style: hobbiesStyle,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      )),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        editingHobby = true;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hobbiesIconSize,
                            width: hobbiesIconSize,
                            child: Image.asset(
                              editingHobby == false
                                  ? "asset/img/hobbies_icons/active_${userAll.isolaUserDisplay.userInterest[1]}.png"
                                  : "asset/img/hobbies_icons_grey/${userAll.isolaUserDisplay.userInterest[1]}_grey_icon.png",
                              fit: editingHobby == false
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),
                          editingHobby == false
                              ? Text(
                                  iconNameListForName[interestLine2],
                                  style: hobbiesStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        editingHobby = true;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hobbiesIconSize,
                            width: hobbiesIconSize,
                            child: Image.asset(
                              editingHobby == false
                                  ? "asset/img/hobbies_icons/active_${userAll.isolaUserDisplay.userInterest[2]}.png"
                                  : "asset/img/hobbies_icons_grey/${userAll.isolaUserDisplay.userInterest[2]}_grey_icon.png",
                              fit: editingHobby == false
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),
                          editingHobby == false
                              ? Text(
                                  iconNameListForName[interestLine3],
                                  style: hobbiesStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        editingHobby = true;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hobbiesIconSize,
                            width: hobbiesIconSize,
                            child: Image.asset(
                              editingHobby == false
                                  ? "asset/img/hobbies_icons/active_${userAll.isolaUserDisplay.userInterest[3]}.png"
                                  : "asset/img/hobbies_icons_grey/${userAll.isolaUserDisplay.userInterest[3]}_grey_icon.png",
                              fit: editingHobby == false
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),
                          editingHobby == false
                              ? Text(
                                  iconNameListForName[interestLine4],
                                  style: hobbiesStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        editingHobby = true;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(1.w, 0.0, 1.w, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hobbiesIconSize,
                            width: hobbiesIconSize,
                            child: Image.asset(
                              editingHobby == false
                                  ? "asset/img/hobbies_icons/active_${userAll.isolaUserDisplay.userInterest[4]}.png"
                                  : "asset/img/hobbies_icons_grey/${userAll.isolaUserDisplay.userInterest[4]}_grey_icon.png",
                              fit: editingHobby == false
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),
                          editingHobby == false
                              ? Text(
                                  iconNameListForName[interestLine5],
                                  style: hobbiesStyle,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
            errorWidget: (context, url, error) =>
                const Icon(CupertinoIcons.xmark_square),
            cacheManager: CacheManager(Config(
              "cachedImageFiles",
              stalePeriod: const Duration(days: 3),
              //one week cache period
            )),
            fit: BoxFit.cover),
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

class BioEditContainer extends StatefulWidget {
  const BioEditContainer({Key? key, required this.userAll}) : super(key: key);
  final IsolaUserAll userAll;

  @override
  State<BioEditContainer> createState() => _BioEditContainerState();
}

class _BioEditContainerState extends State<BioEditContainer> {
  var t1 = TextEditingController();

  @override
  void initState() {
    super.initState();

    t1.text = widget.userAll.isolaUserDisplay.userBiography;
  }

  @override
  void dispose() {
    t1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      width: 95.w,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(25.0))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: ColorConstant.themeGrey,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 2.7.h, 3.w, 0.0),
                    child: SizedBox(
                      height: 12.h,
                      width: 85.w,
                      child: CupertinoTextField(
                        controller: t1,
                        padding: const EdgeInsets.all(8.0),
                        maxLength: 99,
                        autofocus: true,
                        cursorColor: ColorConstant.doubleSoftBlack,
                        showCursor: true,
                        style: StyleConstants.postAddTextStyle,
                        minLines: 1,
                        maxLines: 4,
                        decoration: BoxDecoration(
                            color: ColorConstant.addTimelinePost,
                            border: Border.all(width: 0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 1.4,
                                  offset: Offset(0.0, -0.05),
                                  spreadRadius: 0.01)
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60.w, 1.5.h, 1.0, 1.0),
                    child: GestureDetector(
                      onTap: () {
                        CollectionReference userDisplayRef = FirebaseFirestore
                            .instance
                            .collection('users_display');

                        userDisplayRef
                            .doc(widget.userAll.isolaUserMeta.userUid)
                            .update({
                          'uBio': t1.text,
                        });

                        t1.clear();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 3.5.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                            gradient: ColorConstant.isolaMainGradient,
                            border: Border.all(
                                color: ColorConstant.transparentColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                color: ColorConstant.themeGrey,
                                border: Border.all(
                                    color: ColorConstant.transparentColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0))),
                            child: Center(
                              child: Text(
                                "Update",
                                style: StyleConstants.postAddTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
