// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class ProfileTimelinePage extends StatefulWidget {
  // const ProfileTimelinePage({Key? key}) : super(key: key);
  final User user;
  final UserDisplay userDisplay;

  const ProfileTimelinePage({
    Key? key,
    required this.user,
    required this.userDisplay,
  }) : super(key: key);

  @override
  _ProfileTimelinePageState createState() => _ProfileTimelinePageState();
}

class _ProfileTimelinePageState extends State<ProfileTimelinePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late var _profileRef;
  late int amountData;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      amountData = 10;
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (amountData < 50) {
      if (mounted) {
        setState(() {
          amountData = amountData + 10;
        });
      }
     
    }
     _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    amountData = 10;
    _profileRef = refGetter(
        enum2: RefEnum.Basereadfeeds,
        targetUid: widget.user.uid,
        userUid: widget.user.uid,
        crypto: "");
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<dynamic>(
          stream: _profileRef.limitToLast(amountData).onValue,
          builder: (context, event) {
            if (event.hasData && event.data.snapshot.value != null) {
              var bioTimeLineDatas = <FeedMeta>[];
              var bioTimeLineItem = <TimelineItem>[];

              var gettingBioTimeline = event.data.snapshot.value as Map;

              gettingBioTimeline.forEach((key, event) {
                var comingItem = FeedMeta.fromJson(event);

                bioTimeLineDatas.add(comingItem);

                var bioTimeItem = TimelineItem(
                  feedMeta: comingItem,
                  userUid: widget.user.uid,
                  userDisplay: widget.userDisplay,
                  isTimeline: false,
                );
                bioTimeLineItem.add(bioTimeItem);
              });
              if (bioTimeLineItem.isNotEmpty) {
                bioTimeLineItem.sort((b, a) =>
                    a.feedMeta.feedTime.compareTo(b.feedMeta.feedTime));
              }
              return bioTimeLineItem.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.pen,
                          size: 65.sp,
                          color: ColorConstant.softGrey,
                        ),
                        const Text("You have not post")
                      ],
                    ))
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      footer: const ClassicFooter(),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: bioTimeLineItem.length,
                          itemBuilder: (context, indeks) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(3.w, 0.0, 3.w, 1.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [bioTimeLineItem[indeks]],
                              ),
                            );
                          }),
                    );
            } else {
              return Center(
                  child: Column(
                children: [
                  Icon(
                    CupertinoIcons.pen,
                    size: 65.sp,
                    color: ColorConstant.softGrey,
                  ),
                  const Text("You have not post")
                ],
              ));
            }
          }),
    );
  }
}
