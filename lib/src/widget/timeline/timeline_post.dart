// ignore_for_file: must_be_immutable, unused_local_variable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/blocs/user_hive_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/target_profiles.dart';
import 'package:isola_app/src/service/firebase/storage/deleting/feed_delete.dart';
import 'package:isola_app/src/service/firebase/storage/hive_operations.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../extensions/locale_keys.dart';
import '../report_sheets.dart';

class TimelineItem extends StatefulWidget {
  IsolaFeedModel feedMeta;
  String userUid;
  IsolaUserAll isolaUserAll;

  bool isTimeline;
  TimelineItem(
      {Key? key,
      required this.feedMeta,
      required this.userUid,
      required this.isTimeline,
      required this.isolaUserAll})
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
              if (widget.isTimeline == true) {
                if (widget.isolaUserAll.isolaUserMeta.userFriends
                        .contains(widget.feedMeta.userUid) ==
                    false) {
                  print('alerttt no friend');
                }
                else{
                        Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => TargetProfilePage(
                              targetUid: widget.feedMeta.userUid,
                              targetName: widget.feedMeta.userName,
                              targetAvatarUrl: widget.feedMeta.userAvatarUrl,
                              userUid: widget.userUid,
                              isolaUserAll: widget.isolaUserAll,
                            )));
                }
          
              }
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
                                    backgroundColor: ColorConstant.milkColor,
                                    radius: 100.h >= 1100 ? 13.sp : 20.sp,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.feedMeta.userAvatarUrl,
                                      width: 100.h >= 1100 ? 26.sp : 40.sp,
                                      height: 100.h >= 1100 ? 26.sp : 40.sp,
                                      fit: BoxFit.cover,
                                      cacheManager: CacheManager(Config(
                                        "cachedImageFiles",
                                        stalePeriod: const Duration(days: 3),
                                        //one week cache period
                                      )),
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
                                                          Image unlike =
                                                              Image.asset(
                                                                  "asset/img/mini_like_button.png");

                                                          if (context
                                                                  .read<
                                                                      TimelineModel>()
                                                                  .imageLikeReader()
                                                                  .image ==
                                                              unlike.image) {
                                                            try {
                                                              print('like et');
                                                              timelineModelNesne
                                                                  .imageLikeOn();

                                                              likeFeed(
                                                                      feedLikeList: widget
                                                                          .feedMeta
                                                                          .likeList,
                                                                      targetUid: widget
                                                                          .feedMeta
                                                                          .userUid,
                                                                      userUid:
                                                                          widget
                                                                              .userUid,
                                                                      feedNo: widget
                                                                          .feedMeta
                                                                          .feedNo,
                                                                      isImage:
                                                                          false)
                                                                  .whenComplete(
                                                                      () {
                                                                timelineUpOrDown
                                                                    .likeUp();
                                                                context
                                                                    .read<
                                                                        TimelineItemListCubit>()
                                                                    .timelineItemLike(
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
                                                                      userUid:
                                                                          widget
                                                                              .userUid,
                                                                      feedNo: widget
                                                                          .feedMeta
                                                                          .feedNo,
                                                                      feedLikeList: widget
                                                                          .feedMeta
                                                                          .likeList,
                                                                      isImage:
                                                                          false)
                                                                  .whenComplete(
                                                                      () {
                                                                timelineUpOrDown
                                                                    .likeDown();
                                                                context
                                                                    .read<
                                                                        TimelineItemListCubit>()
                                                                    .timelineItemLike(
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
                                           
                                              actions: [
                                                widget.feedMeta.userUid ==
                                                        widget.userUid
                                                    ? CupertinoButton(
                                                        child: Text(
                                                          "${LocaleKeys.main_delete.tr()} Post",
                                                          style:const TextStyle(
                                                              color:
                                                                  CupertinoColors
                                                                      .black),
                                                        ),
                                                        onPressed: () {
                                                          textFeedDelete(
                                                              widget.feedMeta
                                                                  .feedNo,
                                                              widget.userUid);
                                                          // ignore: iterable_contains_unrelated_type
                                                          if (context
                                                              .read<
                                                                  TimelineItemListCubit>()
                                                              .state
                                                              .contains(widget
                                                                  .feedMeta
                                                                  .feedNo)) {
                                                            context
                                                                .read<
                                                                    TimelineItemListCubit>()
                                                                .timelineFeedRemover(
                                                                    widget
                                                                        .feedMeta
                                                                        .feedNo);
                                                          }

                                                          Navigator.pop(
                                                              context);
                                                        })
                                                    : CupertinoButton(
                                                        child:  Text(
                                                        LocaleKeys.main_report.tr(),
                                                          style:const TextStyle(
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
                                                                      userUid:
                                                                          widget
                                                                              .userUid,
                                                                      feedMeta:
                                                                          widget
                                                                              .feedMeta,
                                                                    )))),
                                                CupertinoButton(
                                                    child:Text(LocaleKeys.main_back.tr()),
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
  const AddPostReportContainer(
      {Key? key, required this.feedMeta, required this.userUid})
      : super(key: key);

  final IsolaFeedModel feedMeta;
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
                         Text(
                          LocaleKeys.report_reportingtextouter.tr(),
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
                        Navigator.pop(context);
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => ReportFeedSheet(
                                  reporterUid: widget.userUid,
                                  isImageFeed: false,
                                  feedNo: widget.feedMeta.feedNo,
                                  targetUid: widget.feedMeta.userUid,
                                ));
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
                                LocaleKeys.main_report.tr(),
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
