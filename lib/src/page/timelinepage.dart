// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_field
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/blocs/timeline_item_list_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_feeds.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/feed_timestamp.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({
    Key? key,
    required this.user,
    required this.userAll,
  }) : super(key: key);
  final User? user;
  final IsolaUserAll userAll;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  late int itemCountValue;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshController2 =
      RefreshController(initialRefresh: false);

  var t1 = TextEditingController();
  int kullanilmayanData = 0;
  int islemMiktar = 0;

  FirebaseAuth auth = FirebaseAuth.instance;
  late var _refTimeline;
  late var _refTimelineToText;
  late var _refTimelineExample;
  late var _refTimelineExample2;

  late bool isRefresh;

  TimelineItem timelineWithLikeInfo(FeedMeta feedMeta, bool isLiked) {
    var timeItem = TimelineItem(
      feedMeta: feedMeta,
      userUid: widget.user!.uid,

      isTimeline: true,
    );

    return timeItem;
  }

  void _onRefresh() async {
    // monitor network fetch
    print("onrefresh");
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      print("111");
      isRefresh = true;
      itemCountValue = 20;
    });

    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("onloading");
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) {
      setState(() {
        itemCountValue = itemCountValue + 20;
        isRefresh = false;
        //_onRefresh();
      });
      refreshController.loadComplete();
    }
  }

  void _onRefresh2() async {
    // monitor network fetch
    print("onrefresh");
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      print("111");
      isRefresh = true;
      itemCountValue = 20;
    });

    refreshController2.refreshCompleted();
  }

  void _onLoading2() async {
    print("onloading");
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) {
      setState(() {
        itemCountValue = itemCountValue + 20;
        isRefresh = false;
        //_onRefresh();
      });
      refreshController2.loadComplete();
    }
  }

  @override
  void initState() {
    super.initState();
    print("GENE INITLEDİ");
    itemCountValue = 20;
    if (context.read<TimelineItemListCubit>().state.isEmpty) {
      isRefresh = true;
    } else {
      isRefresh = false;
    }

    User? user = auth.currentUser;
    _refTimeline = refGetter(
        enum2: RefEnum.Timelinereadfeeds,
        userUid: user!.uid,
        crypto: '',
        targetUid: '');
  
    _refTimelineToText = refGetter(
        enum2: RefEnum.Feedcomesfromfeedtext,
        targetUid: "",
        userUid: "",
        crypto: "");
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeGrey,
      navigationBar: CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          leading: const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Timeline"),
              )),
          trailing: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 50,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(1.0),
                   onPressed: () async => addPostDialogContent(context),
                /*  onPressed: () async {
                    var ref = await refGetter(
                        enum2: RefEnum.Feedtofeedtext,
                        targetUid: "",
                        userUid: "",
                        crypto: "");

                    ref.remove();


                    ref
                        .child(widget.userDisplay.userUid)
                        .child("-Mx_oVl5PTbwt7-1zwVf").remove();
                  },*/
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                        child: Image.asset("asset/img/add_post_button.png")),
                  ),
                ),
              ),
            ),
          )),
      child: Container(
        color: ColorConstant.themeGrey,
        child: isRefresh == false
            ? SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                footer: const ClassicFooter(),
                header: const ClassicHeader(),
                controller: refreshController2,
                onRefresh: _onRefresh2,
                onLoading: _onLoading2,
                child: ListView.builder(
                    //   itemCount: timelineItem.length,

                    itemCount: itemCountValue >=
                            context.read<TimelineItemListCubit>().state.length
                        ? context.read<TimelineItemListCubit>().state.length
                        : itemCountValue,
                    itemBuilder: (context, indeks) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(3.w, 5.0, 3.w, 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            context.read<TimelineItemListCubit>().state[indeks]
                          ],
                        ),
                      );
                    }),
              )
            : FutureBuilder(
                future: getTimelineDatas(widget.userAll, 10),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      if (context
                              .read<TimelineItemListCubit>()
                              .state
                              .isNotEmpty ==
                          false) {}

                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.sp,
                          animating: true,
                        ),
                      );
                    case ConnectionState.done:
                      isRefresh = false;
                      context
                          .read<TimelineItemListCubit>()
                          .timelineAdder(snapshot.data as List<dynamic>);

                      context.read<TimelineItemListCubit>().timelineItemsSort();
                      // var userAllSnap = snapshot.data as UserAll;
                      print("fdsfs");
                      for (var item
                          in context.read<TimelineItemListCubit>().state) {
                        //print(item.feedMeta.feedText);
                      }
                      print("fdsfs2");
                      print(context.read<TimelineItemListCubit>().state.length);
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        footer: const ClassicFooter(),
                        header: const ClassicHeader(),
                        controller: refreshController,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView.builder(
                            //   itemCount: timelineItem.length,

                            itemCount: itemCountValue >=
                                    context
                                        .read<TimelineItemListCubit>()
                                        .state
                                        .length
                                ? context
                                    .read<TimelineItemListCubit>()
                                    .state
                                    .length
                                : itemCountValue,
                            itemBuilder: (context, indeks) {
                              return Padding(
                                padding:
                                    EdgeInsets.fromLTRB(3.w, 5.0, 3.w, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    context
                                        .read<TimelineItemListCubit>()
                                        .state[indeks]
                                  ],
                                ),
                              );
                            }),
                      );

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

                        context
                            .read<TimelineItemListCubit>()
                            .timelineAdder(snapshot.data as List<dynamic>);

                        context
                            .read<TimelineItemListCubit>()
                            .timelineItemsSort();
                        // var userAllSnap = snapshot.data as UserAll;
                        for (var item
                            in context.read<TimelineItemListCubit>().state) {
                          print(item.feedMeta.feedText);
                        }

                        return SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          footer: const ClassicFooter(),
                          header: const ClassicHeader(),
                          controller: refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: ListView.builder(
                              //   itemCount: timelineItem.length,

                              itemCount: itemCountValue >=
                                      context
                                          .read<TimelineItemListCubit>()
                                          .state
                                          .length
                                  ? context
                                      .read<TimelineItemListCubit>()
                                      .state
                                      .length
                                  : itemCountValue,
                              itemBuilder: (context, indeks) {
                                return Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(3.w, 5.0, 3.w, 5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      context
                                          .read<TimelineItemListCubit>()
                                          .state[indeks]
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                  }
                },
              ),
      ),
    );
  }

  addPostDialogContent(BuildContext context) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Center(
        child: AddPostContainer(
          userAll: widget.userAll,
        ),
      ),
    );
  }
}

class AddPostContainer extends StatefulWidget {
  const AddPostContainer({Key? key, required this.userAll})
      : super(key: key);
  final IsolaUserAll userAll;

  @override
  State<AddPostContainer> createState() => _AddPostContainerState();
}

class _AddPostContainerState extends State<AddPostContainer> {
  var t1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
     print(100.h);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       
        Container(
          height: 100.h<=700?35.h:30.h,
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 1.h, 0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21.sp),
                            child: CircleAvatar(
                              radius: 20.sp,
                              child: Image.network(
                                widget.userAll.isolaUserDisplay.avatarUrl,
                                width: 40.sp,
                                height: 40.sp,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 1.9.h, 0.0, 0.0),
                          child: Text(
                            widget.userAll.isolaUserDisplay.userName,
                            style: StyleConstants.softDarkTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 0.7.h, 0.0, 0.0),
                          child: SizedBox(
                            height:100.h<=700?15.h : 12.h,
                            width: 65.w,
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
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
                          padding: EdgeInsets.fromLTRB(50.w, 1.5.h, 1.0, 8.0),
                          child: Container(
                            height: 100.h<=700?5.h:3.5.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                                gradient: ColorConstant.isolaMainGradient,
                                border: Border.all(
                                    color: ColorConstant.transparentColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CupertinoButton(
                                padding: const EdgeInsets.all(0.2),
                                onPressed: () {
                                  addFeed(widget.userAll.isolaUserMeta.userUid,
                                      widget.userAll, t1.text);

                                  t1.clear();
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.themeGrey,
                                      border: Border.all(
                                          color:
                                              ColorConstant.transparentColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6.0))),
                                  child: Center(
                                    child: Text(
                                      "Post",
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
          ),
        ),
        SizedBox(height: 48.h)
      ],
    );
  }
}
