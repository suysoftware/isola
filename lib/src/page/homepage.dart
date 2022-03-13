// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, avoid_print, invalid_use_of_protected_member, must_be_immutable, unused_field, duplicate_ignore
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/match_button_cubit.dart';
import 'package:isola_app/src/blocs/search_status_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_finder.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.userAll,
  })
  // required this.searchStatus})
  : super(key: key);
  final IsolaUserAll userAll;
  // final bool searchStatus;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late bool isTablet;
  late var _refTimeline;
  int popularItemAmount = 0;

  late AnimationController animationController;
  late AnimationController animationController2;
  late AnimationController animationController3;

  late Animation<double> scaleAnimationValue;
  late Animation<double> scaleAnimationValueForTablet;
  late Animation<double> scaleAnimationValue2;
  late Animation<double> scaleAnimationValue2ForTablet;
  late Animation<double> rotateAnimationValue;
  late Animation<double> rotateAnimationValue2;

//searching animations
  late AnimationController animationController4;
  late Animation<double> rotateAnimationValue3;

  void addGroupToJoinedList(String comingValue) {
    context.read<JoinedListCubit>().joinedListAdd(comingValue);
  }

  void addGroupToJoinedListDeleteNothing(String comingValue) {
    context.read<JoinedListCubit>().joinedListWithoutNothing(comingValue);
  }

  @override
  void initState() {
    super.initState();

    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);
    print(widget.userAll.isolaUserMeta.userIsSearching);

    print(widget.userAll.isolaUserMeta.joinedGroupList.length);
    print(widget.userAll.isolaUserMeta.joinedGroupList.length);

    print(widget.userAll.isolaUserMeta.joinedGroupList.length);
    print(widget.userAll.isolaUserMeta.joinedGroupList.length);
    print(widget.userAll.isolaUserMeta.joinedGroupList.length);

    isTablet = 100.h >= 1100 ? true : false;

    _refTimeline = refGetter(
        enum2: RefEnum.Timelinereadfeeds,
        userUid: "",
        crypto: '',
        targetUid: '');

    animationController = AnimationController(
        duration: (const Duration(milliseconds: 3000)), vsync: this);

    animationController2 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationController3 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationController4 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    scaleAnimationValue =
        Tween(begin: 80.0, end: 65.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
    scaleAnimationValueForTablet =
        Tween(begin: 135.0, end: 130.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
    scaleAnimationValue2 =
        Tween(begin: 10.0, end: 7.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    scaleAnimationValue2ForTablet =
        Tween(begin: 11.0, end: 8.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    rotateAnimationValue =
        Tween(begin: 0.0, end: pi * 2).animate(animationController2)
          ..addListener(() {
            setState(() {});
          });

    rotateAnimationValue2 = Tween(begin: 0.0, end: pi * 24).animate(
        CurvedAnimation(parent: animationController3, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          widget.userAll.isolaUserMeta.userIsSearching = true;
        });
      });
    rotateAnimationValue3 = Tween(begin: 0.0, end: pi * 2).animate(
        CurvedAnimation(parent: animationController4, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    if (widget.userAll.isolaUserMeta.userIsSearching != false) {
      context.read<MatchButtonCubit>().imageButtonSearching(isTablet: isTablet);
      print("burada***");
      // widget.userAll.isolaUserMeta.userIsSearching = true;
      animationController4.repeat(period: const Duration(milliseconds: 1800));
      context.read<SearchStatusCubit>().searching();
    } else {
      context.read<SearchStatusCubit>().pauseSearching();
      switch (widget.userAll.isolaUserMeta.joinedGroupList.length) {
        case 1:
          context
              .read<MatchButtonCubit>()
              .imageButtonSearcingCancel(isTablet: isTablet);

          break;
        case 2:
          context
              .read<MatchButtonCubit>()
              .imageButtonSearcingCancel(isTablet: isTablet);

          break;
        case 3:
          context
              .read<MatchButtonCubit>()
              .imageButtonUseToken(isTablet: isTablet);

          break;
        case 4:
          context
              .read<MatchButtonCubit>()
              .imageButtonUseToken(isTablet: isTablet);

          break;

        case 5:
          context.read<MatchButtonCubit>().imageButtonFull(isTablet: isTablet);

          break;
      }
    }

/*
    if (context.read<SearchStatusCubit>().state == true) {
//burası çalışınca 10 saniyedebir kontrolüde çalıştırabiliriz.
      context.read<MatchButtonCubit>().imageButtonSearching(isTablet: isTablet);
      print("burada***");
      animationController4.repeat();
    } else {
      print("burada****");
      if (context.read<JoinedListCubit>().state.length == 3 ||
          context.read<JoinedListCubit>().state.length == 4 &&
              context.read<SearchStatusCubit>().state != true) {
        print("1*1*1");
        context
            .read<MatchButtonCubit>()
            .imageButtonUseToken(isTablet: isTablet);
      } else if (context.read<JoinedListCubit>().state.length == 5 &&
          context.read<SearchStatusCubit>().state != true) {
        print("2*2*2");
        context.read<MatchButtonCubit>().imageButtonFull(isTablet: isTablet);
      } else {
        print("3*3*3");
        context
            .read<MatchButtonCubit>()
            .imageButtonSearcingCancel(isTablet: isTablet);
      }
    }

    searchingStatus(context.read<JoinedListCubit>().state).then((value) {
      if (value == true) {
        print("burada*");
        context.read<SearchStatusCubit>().searching();
        context
            .read<MatchButtonCubit>()
            .imageButtonSearching(isTablet: isTablet);
        animationController4.repeat(period: const Duration(milliseconds: 1800));

        print("burada1****");
        if (context.read<JoinedListCubit>().state.length == 3 ||
            context.read<JoinedListCubit>().state.length == 4 &&
                context.read<SearchStatusCubit>().state != true) {
          print("burada2**");
          context
              .read<MatchButtonCubit>()
              .imageButtonUseToken(isTablet: isTablet);
        } else if (context.read<JoinedListCubit>().state.length == 5 &&
            context.read<SearchStatusCubit>().state != true) {
          print("burada3**");
          context.read<MatchButtonCubit>().imageButtonFull(isTablet: isTablet);
        } else {
          print("burada4**");
          // context
          //   .read<MatchButtonCubit>()
          // .imageButtonSearcingCancel(isTablet: isTablet);
        }
      } else {
        print("burada**");

        context.read<SearchStatusCubit>().pauseSearching();
        context
            .read<MatchButtonCubit>()
            .imageButtonSearcingCancel(isTablet: isTablet);
        if (mounted) {
          setState(() {
            animationController4.stop();
          });
        }

        print("burada****");
        if (context.read<JoinedListCubit>().state.length == 3 ||
            context.read<JoinedListCubit>().state.length == 4) {
          context
              .read<MatchButtonCubit>()
              .imageButtonUseToken(isTablet: isTablet);
        } else if (context.read<JoinedListCubit>().state.length == 5) {
          context.read<MatchButtonCubit>().imageButtonFull(isTablet: isTablet);
        } else {
          context
              .read<MatchButtonCubit>()
              .imageButtonSearcingCancel(isTablet: isTablet);
        }
      }
    });
    */
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    animationController3.dispose();
    if (mounted) {
      animationController4.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userAll.isolaUserMeta.userIsSearching) {
      
      animationController4.repeat(period: const Duration(milliseconds: 1800));
      context.read<MatchButtonCubit>().imageButtonSearching(isTablet: isTablet);
    }

    //  print(100.h);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: false,
          trailing: Padding(
            padding: EdgeInsets.zero,
            child: GestureDetector(
                onTap: () {
                  /*
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              SignUpPage(userDisplay: widget.userDisplay))
                              );*/
/*
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => InterestAddPage(
                                userUid: widget.userDisplay.userUid,
                              )));*/
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${widget.userAll.isolaUserMeta.userToken}',
                        style: StyleConstants.isolaTokenTextStyle,
                      ),
                    ),
                    SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          "asset/img/isola_token.png",
                        )),
                  ],
                )),
          )),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(gradient: ColorConstant.isolaHomeBgGradient),
        child: Column(
//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Image.asset(
                  "asset/img/homepage_top.png",
                  fit: BoxFit.fill,
                  width: 100.w,
                  height: 100.h <= 400 ? 47.h : 50.h,
                ),
                Positioned(
                  top: 100.h >= 1100 ? 8.3.h : 7.3.h,
                  left: 100.h >= 1100 ? 35.6.w : 25.4.w,
                  child: Transform.rotate(
                    angle: context.read<SearchStatusCubit>().state == true
                        ? rotateAnimationValue3.value
                        : rotateAnimationValue2.value,

                    // angle: rotateAnimationDegerleri.value,
                    child: CircularText(
                      children: [
                        TextItem(
                          text: Text(LocaleKeys.homepage_circulartext.tr(),
                              style: 100.h >= 1100
                                  ? StyleConstants.circularTabletTextStyle
                                  : StyleConstants.circularTextStyle),
                          space: 100.h >= 1100
                              ? scaleAnimationValue2ForTablet.value
                              : scaleAnimationValue2.value,
                          startAngle: -50,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.clockwise,
                        ),
                      ],
                      radius: 100.h >= 1100 ? 16.w : 26.w,
                      position: CircularTextPosition.outside,
                      backgroundPaint: Paint()
                        ..color = ColorConstant.transparentColor,
                    ),
                  ),
                ),
                BlocBuilder<MatchButtonCubit, Image>(
                    builder: (context, matchButtonType) {
                  return Positioned(
                    top: 9.2.h,
                    left: 8.w,
                    right: 5.w,
                    child: GestureDetector(
                      onTap: () {
                        /*    joinToMatchingPool(
                            widget.userAll.isolaUserMeta.userUid,
                            widget.userAll.isolaUserDisplay.userSex,
                            widget.userAll.isolaUserDisplay.userIsNonBinary,
                            widget.userAll.isolaUserMeta.userIsValid);*/

                        if (widget.userAll.isolaUserMeta.userIsSearching) {
                          print("zaten searching şuan");
                        } else {
                          if (widget.userAll.isolaUserMeta.joinedGroupList
                                  .length <
                              3) {
                            animationController.forward();
                            animationController2.forward().whenComplete(() {
                              animationController3.forward().whenComplete(() {
                                joinToMatchingPool(
                                        widget.userAll.isolaUserMeta.userUid,
                                        widget.userAll.isolaUserDisplay.userSex,
                                        widget.userAll.isolaUserDisplay
                                            .userIsNonBinary,
                                        widget
                                            .userAll.isolaUserMeta.userIsValid)
                                    .whenComplete(() {
                                  context
                                      .read<MatchButtonCubit>()
                                      .imageButtonSearching(isTablet: isTablet);
                                  context.read<SearchStatusCubit>().searching();
                                  animationController.reset();
                                });
                              });
                            });
                          } else if (widget.userAll.isolaUserMeta
                                  .joinedGroupList.length <
                              5) {
                            if (widget.userAll.isolaUserMeta.userToken > 0) {
                              // YOU HAVE TOKEN AND YOU CAN USE
                                  animationController.forward();
                                                animationController2
                                                    .forward()
                                                    .whenComplete(() {
                                                  animationController3
                                                      .forward()
                                                      .whenComplete(() {
                                                    joinToMatchingPool(
                                                            widget
                                                                .userAll
                                                                .isolaUserMeta
                                                                .userUid,
                                                            widget
                                                                .userAll
                                                                .isolaUserDisplay
                                                                .userSex,
                                                            widget
                                                                .userAll
                                                                .isolaUserDisplay
                                                                .userIsNonBinary,
                                                            widget
                                                                .userAll
                                                                .isolaUserMeta
                                                                .userIsValid)
                                                        .whenComplete(() {
                                                      context
                                                          .read<
                                                              MatchButtonCubit>()
                                                          .imageButtonSearching(
                                                              isTablet:
                                                                  isTablet);
                                                      context
                                                          .read<
                                                              SearchStatusCubit>()
                                                          .searching();
                                                      animationController
                                                          .reset();

                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              navigationBar);
                                                    });
                                                  });
                                                });
                            } else {
                              // YOU HAVENT TOKEN , YOU HAVE TO BUY
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content: const Text(
                                            "You need token"),
                                        title: const Text("Token Alert"),
                                        actions: [
                                          CupertinoButton(
                                              child: Text("Earn token",
                                                  style: TextStyle(
                                                      fontSize: 11.sp)),
                                              onPressed: () {
                                                //watch ads
                                              }),
                                          CupertinoButton(
                                              child: Text(
                                                "No Doesnt Yet",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ));
                            }

                            //

                            //
                          } else if (widget.userAll.isolaUserMeta
                                  .joinedGroupList.length ==
                              5) {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                      content: const Text(
                                          "No more match :("),
                                      title: const Text("Full"),
                                      actions: [
                                        CupertinoButton(
                                            child: Text("Okey",
                                                style:
                                                    TextStyle(fontSize: 11.sp)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ));
                          }
                        }

                        /*
                        //buraya grup tamamlanma şartı koy bastınv eo grup tamamlanana kadar kapatma yok iptal etme koyulabilir ve iptal ile o grup silinir
                        if (context.read<SearchStatusCubit>().state != true) {
                          if (context.read<JoinedListCubit>().state.length <
                              3) {
                            findGroup(widget.userAll)
                                .then((value) => context
                                    .read<JoinedListCubit>()
                                    // ignore: invalid_use_of_visible_for_testing_member
                                    .emit(value));
                            animationController.forward();
                            animationController2
                                .forward()
                                .whenComplete(() => animationController3
                                        .forward()
                                        .whenComplete(() {
                                      animationController.reset();
                                      animationController2.reset();
                                      animationController3.reset();

                                      //   animationController4.repeat();

                                      //  animationController.reverse();

                                      //animationController.reset();
                                      //animationController2.reset();
                                      //animationController3.reset();
                                    }))
                                .whenComplete(() {
                              context
                                  .read<MatchButtonCubit>()
                                  .imageButtonSearching(isTablet: isTablet);
                              context.read<SearchStatusCubit>().searching();
                              setState(() {});

                              animationController4.repeat(
                                  period: const Duration(milliseconds: 1800));
                            });
                          } else {
                            if (widget.userAll.isolaUserMeta.userToken > 0) {
                              // YOU HAVE TOKEN AND YOU CAN USE
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content: const Text(
                                            "Do you wanna spend token for more match,or you can leave your current group"),
                                        title: const Text("Use Token "),
                                        actions: [
                                          CupertinoButton(
                                              child: Text("Use",
                                                  style: TextStyle(
                                                      fontSize: 11.sp)),
                                              onPressed: () {}),
                                          CupertinoButton(
                                              child: Text(
                                                "No Doesnt Yet",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ));
                            } else {
                              // YOU HAVENT TOKEN , YOU HAVE TO BUY
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content: const Text(
                                            "You havent permission for more match"),
                                        title: const Text("Token Alert"),
                                        actions: [
                                          CupertinoButton(
                                              child: Text("Buy token",
                                                  style: TextStyle(
                                                      fontSize: 11.sp)),
                                              onPressed: () {}),
                                          CupertinoButton(
                                              child: Text(
                                                "No Doesnt Yet",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ));
                            }
                          }
                        }*/
                      },
                      child: CircleAvatar(
                        radius: 100.h >= 1100
                            ? scaleAnimationValueForTablet.value
                            : scaleAnimationValue.value,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.01,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: -2,
                                    blurRadius: 10.sp,
                                    offset: const Offset(0.0, 6.0),
                                    color: ColorConstant.softBlack
                                        .withOpacity(0.5))
                              ]),
                          child: Transform.rotate(
                              angle: rotateAnimationValue.value,
                              child: matchButtonType),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 0.0, 0.0, 4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ContWithBorder(
                    childWidget: Center(
                        child: Text(
                      LocaleKeys.homepage_populartext.tr(),
                      style: 100.h <= 1100
                          ? StyleConstants.softDarkTextStyle
                          : StyleConstants.softDarkTabletTextStyle,
                    )),
                    heightSize: 100.h < 820 ? 3 : (100.h <= 1100 ? 4 : 6),
                    widthSize: 45),
              ),
            ),
            //  SizedBox(height: 1.h),
            HomePageCard(
                contHeightSize: 100.h <= 820 ? 10 : 11,
                contWidthSize: 90,
                context: context,
                targetName: 'Tony Capple',
                targetText:
                    'bir berber bir berbere gel beraber berber dükkanı açalım',
                isLeft: true,
                letterTextStyle: 100.h <= 1100
                    ? StyleConstants.cardTextStyle
                    : StyleConstants.cardTabletTextStyle),
            SizedBox(height: 1.h),
            HomePageCard(
                contHeightSize: 100.h <= 820 ? 10 : 11,
                contWidthSize: 90,
                context: context,
                targetName: 'Jessi Klein',
                targetText:
                    'consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim fringilla urna, porttitor rhoncus dolor purus non enim fringilla urna, porttitor rhoncus dolor purus non enim',
                isLeft: false,
                letterTextStyle: 100.h <= 1100
                    ? StyleConstants.cardTextStyle
                    : StyleConstants.cardTabletTextStyle),
          ],
        ),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  int contHeightSize;
  int contWidthSize;
  String targetText;
  String targetName;
  bool isLeft;
  TextStyle letterTextStyle;
  HomePageCard(
      {Key? key,
      required this.contHeightSize,
      required this.contWidthSize,
      required context,
      required this.targetText,
      required this.targetName,
      required this.isLeft,
      required this.letterTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContWithBorder(
        childWidget: CardInline(
            context: context,
            targetAvatar: 's',
            targetName: targetName,
            targetText: targetText,
            avatarRadius: 100.h <= 1100
                ? (100.h <= 800 ? contHeightSize - 9 : contHeightSize - 8)
                : contHeightSize - 6,
            isLeft: isLeft,
            letterTextStyle: letterTextStyle),
        heightSize: 100.h <= 1100 ? contHeightSize : contHeightSize + 4,
        widthSize: contWidthSize);
  }
}

class ContWithBorder extends StatelessWidget {
  Widget childWidget;
  int heightSize;
  int widthSize;

  ContWithBorder(
      {Key? key,
      required this.childWidget,
      required this.heightSize,
      required this.widthSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.all(Radius.circular(heightSize + 0.1))),
      child: Padding(
        padding: const EdgeInsets.all(0.1),
        child: Container(
          height: heightSize.h,
          width: widthSize.w,
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.milkColor),
              color: ColorConstant.milkColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(heightSize + 0.1))),
          child: childWidget,
        ),
      ),
    );
  }
}

class CardInline extends StatelessWidget {
  String targetAvatar;
  String targetName;
  String targetText;
  double avatarRadius;
  bool isLeft;
  TextStyle letterTextStyle;
  CardInline(
      {Key? key,
      required this.targetAvatar,
      required this.targetName,
      required this.targetText,
      required this.avatarRadius,
      required this.isLeft,
      required this.letterTextStyle,
      required context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: isLeft == true
            ? Row(
                children: [
                  PostAvatarLeft(avatarRadius: avatarRadius),
                  HomeTextsLeft(
                      targetName: targetName,
                      context: context,
                      targetText: targetText,
                      rowLetterValue: 100.h >= 1100 ? 60 : 45,
                      letterTextStyle: letterTextStyle,
                      heightValue: 1),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HomeTextsRight(
                      targetName: targetName,
                      context: context,
                      targetText: targetText,
                      rowLetterValue: 100.h >= 1100 ? 60 : 45,
                      letterTextStyle: letterTextStyle),
                  PostAvatarRight(avatarRadius: avatarRadius),
                ],
              ));
  }
}

class PostAvatarLeft extends StatelessWidget {
  double avatarRadius;

  PostAvatarLeft({Key? key, required this.avatarRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 4.0, 10.0),
      child: CircleAvatar(
        radius: avatarRadius.h,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.sp),
            child: Image.network(
                'https://images.unsplash.com/photo-1565464027194-7957a2295fb7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80')),
      ),
    );
  }
}

// ignore: must_be_immutable
class PostAvatarRight extends StatelessWidget {
  double avatarRadius;

  PostAvatarRight({Key? key, required this.avatarRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0.0, 10.0, 2.0),
      child: CircleAvatar(
        radius: avatarRadius.h,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.sp),
            child: Image.network(
                'https://images.unsplash.com/photo-1528341866330-07e6d1752ec2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=881&q=80')),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeTextsRight extends StatelessWidget {
  String targetName;

  String targetText;
  int rowLetterValue;
  TextStyle letterTextStyle;
  HomeTextsRight(
      {Key? key,
      required this.targetName,
      required context,
      required this.targetText,
      required this.rowLetterValue,
      required this.letterTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: 100.h <= 1100
              ? (100.h >= 400
                  ? EdgeInsets.fromLTRB(6.0, 0.0, 7.w, 0.0)
                  : EdgeInsets.fromLTRB(6.0, 0.0, 7.w, 0.0))
              : EdgeInsets.fromLTRB(3.w, 1.5.h, 10.w, 0.0),
          child: Text(
            targetName,
            style: 100.h >= 1100
                ? StyleConstants.softDarkTabletTextStyle
                : StyleConstants.softDarkTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(2.0, 0.0, 5.w, 2.0),
          child: textWidgetGetter(context,
              targetMessage: targetText,
              targetName: targetName,
              rowLetterValue: rowLetterValue,
              letterTextStyle: letterTextStyle),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class HomeTextsLeft extends StatelessWidget {
  String targetName;

  String targetText;
  int rowLetterValue;
  TextStyle letterTextStyle;
  double heightValue;
  HomeTextsLeft(
      {Key? key,
      required this.targetName,
      required context,
      required this.targetText,
      required this.rowLetterValue,
      required this.letterTextStyle,
      required this.heightValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: 100.h <= 1100
              ? (100.h >= 400
                  ? EdgeInsets.fromLTRB(6.0, 0.0, 7.w, 0.0)
                  : EdgeInsets.fromLTRB(6.0, 0.0, 7.w, 0.0))
              : EdgeInsets.fromLTRB(3.w, 1.5.h, 4.w, 0.0),
          child: Text(
            targetName,
            style: 100.h >= 1100
                ? StyleConstants.softDarkTabletTextStyle
                : StyleConstants.softDarkTextStyle,
          ),
        ),
        Container(
          padding: 100.h >= 400
              ? EdgeInsets.fromLTRB(8.0, 0.0, 0.0, (heightValue + 1).h)
              : EdgeInsets.fromLTRB(8.0, 0.0, 0.0, (heightValue - 1).h),
          child: textWidgetGetter(context,
              targetMessage: targetText,
              targetName: targetName,
              rowLetterValue: rowLetterValue,
              letterTextStyle: letterTextStyle),
        ),
      ],
    );
  }
}
