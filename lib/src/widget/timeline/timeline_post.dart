// ignore_for_file: must_be_immutable, unused_local_variable
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/blocs/user_hive_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/target_profiles.dart';
import 'package:isola_app/src/service/firebase/storage/hive_operations.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class TimelineItem extends StatefulWidget {
  FeedMeta feedMeta;
  String userUid;

  bool isTimeline;
  TimelineItem(
      {Key? key,
      required this.feedMeta,
      required this.userUid,
      required this.isTimeline})
      : super(key: key);

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

TextStyle nameStyle = 100.h >= 1100
    ? StyleConstants.softDarkTabletTextStyle
    : StyleConstants.softDarkTextStyle;

TextStyle cardStyle = 100.h >= 1100
    ? StyleConstants.cardTabletTextStyle
    : StyleConstants.cardTextStyle;

class _TimelineItemState extends State<TimelineItem>
    with SingleTickerProviderStateMixin {
  bool isFirstCycle = true;

  void likeChekers(String feedNo) async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = await box.get('datetoday');
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
    return BlocBuilder<UserHiveCubit, UserHive>(builder: (context, userHive) {
      return GestureDetector(
          onTap: () async {
            if (widget.feedMeta.userUid != widget.userUid) {
/*
  var userDisplay = UserDisplay(
      comingValue["user_uid"],
      comingValue["user_name"],
      comingValue["user_biography"],
      comingValue["user_avatar_url"],
      comingValue["user_university"],
      comingValue["user_sex"],
      comingValue["user_is_online"],
      comingValue["user_is_valid"],
      comingValue["user_activities"],
      comingValue["user_interest"],
      comingValue["user_friends"],
      comingValue["user_blocked"],
      comingValue["user_is_non_binary"]);*/

              var targetProfileDisplay = UserDisplay(
                  widget.feedMeta.userUid,
                  widget.feedMeta.userName,
                  widget.feedMeta.userBiography,
                  widget.feedMeta.avatarUrl,
                  widget.feedMeta.userUniversity,
                  widget.feedMeta.userSex,
                  widget.feedMeta.userIsOnline,
                  widget.feedMeta.userIsValid,
                  widget.feedMeta.userActivities,
                  widget.feedMeta.userInterest,
                  widget.feedMeta.userFriends,
                  widget.feedMeta.userBlocked,
                  widget.feedMeta.userIsNonBinary);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => TargetProfilePage(
                            feedMeta: widget.feedMeta,
                          )));

              /*
              refTargetProfile.get().then((value) {
                var gettingInfo = value.snapshot.value as Map;

                gettingInfo.forEach((key, value) {
                  var comingItem = UserDisplay.fromJson(value);

                  var targetProfileDisplay = UserDisplay(
                      comingItem.userUid,
                      comingItem.userName,
                      comingItem.userBiography,
                      comingItem.avatarUrl,
                      comingItem.userUniversity,
                      comingItem.userSex,
                      comingItem.userIsOnline,
                      comingItem.userIsValid,
                      comingItem.userActivities,
                      comingItem.userInterest,
                      comingItem.userFriends,
                      comingItem.userBlocked,
                      comingItem.userIsNonBinary);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => TargetProfilePage(
                              userDisplay: targetProfileDisplay)));
                });
              });*/
            }
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: ColorConstant.isolaMainGradient,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Container(
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    color: ColorConstant.milkColor,
                    border: Border.all(color: ColorConstant.transparentColor),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(25.0))),
                child: Card(
                  elevation: 0.0,
                  color: ColorConstant.transparentColor,
                  child: Padding(
                      padding: 100.h >= 1100
                          ? EdgeInsets.fromLTRB(2.w, 1.h, 4.0, 0.0)
                          : const EdgeInsets.fromLTRB(8.0, 2.0, 4.0, 0.0),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: CircleAvatar(
                                    radius: 100.h >= 1100 ? 13.sp : 20.sp,
                                    child: Image.network(
                                      widget.feedMeta.avatarUrl,
                                      width: 100.h >= 1100 ? 26.sp : 40.sp,
                                      height: 100.h >= 1100 ? 26.sp : 40.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: 100.h >= 1100
                                    ? EdgeInsets.fromLTRB(11.w, 2, 2, 4.0)
                                    : EdgeInsets.fromLTRB(14.w, 2, 2, 4.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: PostTextsLeft(
                                      targetName: widget.feedMeta.userName,
                                      context: context,
                                      targetText: widget.feedMeta.feedText,
                                      rowLetterValue: 100.h >= 1100 ? 65 : 46,
                                      letterTextStyle: cardStyle,
                                      heightValue: 100.h >= 1100
                                          ? (widget.feedMeta.feedText.length <=
                                                  65
                                              ? 2.8
                                              : widget.feedMeta.feedText
                                                      .length /
                                                  32.round())
                                          : (widget.feedMeta.feedText.length /
                                              34.round())),
                                ),
                              ),
                              MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                        create: (context) => TimelineModel(
                                            userHiveLikes: userHive.likesData,
                                            feedNo: widget.feedMeta.feedNo)),
                                    BlocProvider(
                                        create: (context) => TimelineLikeModel(
                                            feedLikeValue:
                                                widget.feedMeta.likeValue)),
                                  ],
                                  child: Positioned(
                                      top: 5.5.h,
                                      right: 6.w,
                                      child: Consumer<TimelineModel>(builder:
                                          (context, timelineModelNesne, child) {
                                        return Row(
                                          children: [
                                            BlocBuilder<TimelineLikeModel, int>(
                                              builder: (
                                                context,
                                                likeValue,
                                              ) =>
                                                  Text(
                                                "$likeValue",
                                                style:
                                                    TextStyle(fontSize: 9.sp),
                                              ),
                                            ),
                                            Consumer<TimelineLikeModel>(builder:
                                                (context, timelineUpOrDown,
                                                    child) {
                                              return BlocBuilder<TimelineModel,
                                                  Image>(
                                                builder: (
                                                  context,
                                                  likeImage,
                                                ) =>
                                                    CupertinoButton(
                                                        child: SizedBox(
                                                          height: 8.sp,
                                                          width: 8.sp,
                                                          child: context
                                                              .read<
                                                                  TimelineModel>()
                                                              .imageLikeReader(),
                                                        ),
                                                        onPressed: () {
                                                          var refLikeFeed =
                                                              refGetter(
                                                                  enum2: RefEnum
                                                                      .Feedsdelete,
                                                                  targetUid: "",
                                                                  userUid: widget
                                                                      .userUid,
                                                                  crypto: widget
                                                                      .feedMeta
                                                                      .feedNo);

                                                          refLikeFeed
                                                              .child(
                                                                  "like_value")
                                                              .once()
                                                              .then((value) {
                                                            if (value.snapshot
                                                                .exists) {
                                                              Image unlike =
                                                                  Image.asset(
                                                                      "asset/img/mini_like_button.png");

                                                              if (context
                                                                      .read<
                                                                          TimelineModel>()
                                                                      .imageLikeReader()
                                                                      .image ==
                                                                  unlike
                                                                      .image) {
                                                                try {
                                                                  timelineModelNesne
                                                                      .imageLikeOn();

                                                                  likeFeed(
                                                                    feedMeta: widget
                                                                        .feedMeta,
                                                                    targetUid: widget
                                                                        .feedMeta
                                                                        .userUid,
                                                                    userUid: widget
                                                                        .userUid,
                                                                    feedNo: widget
                                                                        .feedMeta
                                                                        .feedNo,
                                                                  ).whenComplete(
                                                                      () {
                                                                    timelineUpOrDown
                                                                        .likeUp();
                                                                    context.read<TimelineItemListCubit>().timelineItemLike(
                                                                        widget
                                                                            .feedMeta
                                                                            .feedNo,
                                                                        true,
                                                                        widget
                                                                            .userUid);
                                                                  });
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                              } else {
                                                                try {
                                                                  timelineModelNesne
                                                                      .imageLikeOff();

                                                                  unLikeFeed(
                                                                    targetUid: widget
                                                                        .feedMeta
                                                                        .userUid,
                                                                    userUid: widget
                                                                        .userUid,
                                                                    feedNo: widget
                                                                        .feedMeta
                                                                        .feedNo,
                                                                    feedMeta: widget
                                                                        .feedMeta,
                                                                  ).whenComplete(
                                                                      () {
                                                                    timelineUpOrDown
                                                                        .likeDown();
                                                                    context.read<TimelineItemListCubit>().timelineItemLike(
                                                                        widget
                                                                            .feedMeta
                                                                            .feedNo,
                                                                        false,
                                                                        widget
                                                                            .userUid);
                                                                  });
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                              }
                                                              print("exist");
                                                            } else {
                                                              showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CupertinoAlertDialog(
                                                                            title:
                                                                                Text("This Post Already Deleted"),
                                                                            actions: [
                                                                              CupertinoButton(
                                                                                  child: Text("Okey"),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  })
                                                                            ],
                                                                          ));
                                                            }
                                                          });
                                                        }),
                                              );
                                            }),
                                          ],
                                        );
                                      }))),
                              Positioned(
                                top: -8.0,
                                right: 2.w,
                                child: CupertinoButton(
                                    child: SizedBox(
                                        height: 1.h,
                                        width: 5.w,
                                        child: Image.asset(
                                          "asset/img/chat_page_three_dot.png",
                                          fit: BoxFit.contain,
                                        )),
                                    onPressed: () => showCupertinoDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                              content:
                                                  const Text("What's problem"),
                                              actions: [
                                                widget.feedMeta.userUid ==
                                                        widget.userUid
                                                    ? CupertinoButton(
                                                        child: const Text(
                                                          "Delete Post",
                                                          style: TextStyle(
                                                              color:
                                                                  CupertinoColors
                                                                      .black),
                                                        ),
                                                        onPressed: () {
                                                          var refDeleteFeed = refGetter(
                                                              enum2: RefEnum
                                                                  .Feedsdelete,
                                                              targetUid: "",
                                                              userUid: widget
                                                                  .userUid,
                                                              crypto: widget
                                                                  .feedMeta
                                                                  .feedNo);

                                                          try {
                                                            refDeleteFeed
                                                                .remove()
                                                                .whenComplete(
                                                                    () {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } catch (e) {
                                                            print(e.toString());

                                                            print(e);
                                                            print(e);
                                                            print(e);

                                                            print(e);
                                                          }

                                                          /*  refDeleteFeed
                                                              .remove()
                                                              .whenComplete(() {
                                                            Navigator.pop(
                                                                context);
                                                          });*/
                                                        })
                                                    : CupertinoButton(
                                                        child: const Text(
                                                          "Report",
                                                          style: TextStyle(
                                                              color:
                                                                  CupertinoColors
                                                                      .systemRed),
                                                        ),
                                                        onPressed: () =>
                                                            showCupertinoDialog(
                                                                barrierDismissible:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder: (context) =>
                                                                    Center(
                                                                        child:
                                                                            AddPostReportContainer(
                                                                  userUid: widget.userUid,
                                                                      feedMeta:
                                                                          widget
                                                                              .feedMeta,
                                                                    )))),
                                                CupertinoButton(
                                                    child: const Text("Back"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            ))),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ));
    });
  }
}

class PostTextsLeft extends StatelessWidget {
  String targetName;
  String targetText;
  int rowLetterValue;
  TextStyle letterTextStyle;
  double heightValue;
  PostTextsLeft(
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
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 2.0),
          child: Text(
            targetName,
            style: nameStyle,
          ),
        ),
        Container(
          width: 70.w,
          padding: EdgeInsets.fromLTRB(8.0, 0, 4.0, (heightValue + 1).h),
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

class TimelineModel extends Cubit<Image> {
  List<String> userHiveLikes;
  String feedNo;

  TimelineModel({required this.userHiveLikes, required this.feedNo})
      : super(Image.asset(
          "asset/img/mini_like_button.png",
          fit: BoxFit.contain,
        ));

  Image imageLike = Image.asset(
    "asset/img/mini_like_button.png",
    fit: BoxFit.contain,
  );

  void imageLikeOn() {
    imageLike = Image.asset(
      "asset/img/timeline_red_like_icon.png",
      fit: BoxFit.contain,
    );
    emit(imageLike);
  }

  void imageLikeOff() {
    imageLike = Image.asset(
      "asset/img/mini_like_button.png",
      fit: BoxFit.contain,
    );
    emit(imageLike);
  }

  Image imageLikeReader() {
    if (userHiveLikes.contains(feedNo)) {
      imageLikeOn();
      return imageLike;
    } else {
      imageLikeOff();
      return imageLike;
    }
  }
}

class TimelineLikeModel extends Cubit<int> {
  int feedLikeValue;
  TimelineLikeModel({required this.feedLikeValue}) : super(feedLikeValue);

  void likeUp() {
    int feedLikeValueReturn = state + 1;
    emit(feedLikeValueReturn);
  }

  void likeDown() {
    int feedLikeValueReturn = state - 1;
    emit(feedLikeValueReturn);
  }
}

class AddPostReportContainer extends StatefulWidget {
  const AddPostReportContainer({Key? key, required this.feedMeta,required this.userUid})
      : super(key: key);

  final FeedMeta feedMeta;
  final String userUid;

  @override
  State<AddPostReportContainer> createState() => _AddPostReportContainerState();
}

class _AddPostReportContainerState extends State<AddPostReportContainer> {
  var t1 = TextEditingController();

  @override
  void dispose() {
    t1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
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
                    padding: EdgeInsets.fromLTRB(0.w, 0.5.h, 0.0, 0.0),
                    child: Row(
                      children: [
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.back),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        const Text(
                          "Why you report this post , please explain",
                          style: StyleConstants.softDarkTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 0.7.h, 0.0, 0.0),
                    child: SizedBox(
                      height: 12.h,
                      width: 80.w,
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
                        String fileReportID = const Uuid().v4();
                        var refReport = refGetter(
                            enum2: RefEnum.Feedreports,
                            targetUid: "",
                            userUid: "",
                            crypto: widget.feedMeta.feedNo);

                        var feedReport = HashMap<String, dynamic>();

                        feedReport["reporter_user"] = widget.userUid;
                        feedReport["report_time"] = ServerValue.timestamp;
                        feedReport["report_date"] = DateTime.now().toString();
                        feedReport["report_title"] = t1.text;
                        feedReport["report_no"] = fileReportID;

                        refReport
                            .child(widget.feedMeta.userUid)
                            .child(widget.feedMeta.feedNo)
                            .child(widget.userUid)
                            .set(feedReport);
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
                                "Report",
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
