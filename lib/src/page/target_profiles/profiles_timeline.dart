// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TargetProfileTimelinePage extends StatefulWidget {
  // const ProfileTimelinePage({Key? key}) : super(key: key);
  final String targetUid;
  final String userUid;

  const TargetProfileTimelinePage(
      {Key? key, required this.targetUid, required this.userUid})
      : super(key: key);

  @override
  _TargetProfileTimelinePageState createState() =>
      _TargetProfileTimelinePageState();
}

class _TargetProfileTimelinePageState extends State<TargetProfileTimelinePage> {
  final RefreshController _refreshController =
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
    _profileRef = FirebaseFirestore.instance
        .collection('feeds')
        .doc(widget.targetUid)
        .collection('text_feeds');
    /*  _profileRef = refGetter(
        enum2: RefEnum.Basetargetreadfeeds,
        targetUid: widget.feedMeta.userUid,
        userUid: "",
        crypto: "");*/
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<dynamic>(
          stream: _profileRef
              .orderBy("feed_date", descending: true)
              .limit(amountData)
              /*.withConverter<IsolaFeedModel>(
                fromFirestore: (snapshot, _) =>
                    IsolaFeedModel.fromJson(snapshot.data()!),
                toFirestore: (message, _) => message.toJson(),
              )*/
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var bioTimeLineItem = <TimelineItem>[];

              //  var gettingBioTimeline = event.data.snapshot.value as Map;
              if (!snapshot.hasData)
                return Center(
                  child: CupertinoActivityIndicator(
                      animating: true, radius: 12.sp),
                );

              /*
              gettingBioTimeline.forEach((key, event) {
                var comingItem = FeedMeta.fromJson(event);

                bioTimeLineDatas.add(comingItem);

                var bioTimeItem = TimelineItem(
                  feedMeta: comingItem,
                  userUid: widget.feedMeta.userUid,
                  isTimeline: false,
                );
                bioTimeLineItem.add(bioTimeItem);
              });
  
  */
              final data = snapshot.requireData;

              /*if (bioTimeLineItem.isNotEmpty) {
                bioTimeLineItem.sort((b, a) =>
                    a.feedMeta.feedTime.compareTo(b.feedMeta.feedTime));
              }*/

              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                footer: const ClassicFooter(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.size,
                    itemBuilder: (context, indeks) {
                      return Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 0.0, 3.w, 1.h),
                          child: TimelineItem(
                            feedMeta: IsolaFeedModel(
                                data.docs[indeks]['feed_date'],
                                data.docs[indeks]['feed_no'],
                                data.docs[indeks]['feed_text'],
                                data.docs[indeks]['like_list'],
                                data.docs[indeks]['like_value'],
                                data.docs[indeks]['user_avatar_url'],
                                data.docs[indeks]['user_name'],
                                data.docs[indeks]['user_uid']),
                            userUid: widget.userUid,
                            isTimeline: false,
                          )

                          /*Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [bioTimeLineItem[indeks]],
                        ),*/
                          );
                    }),
              );
            } else {
              return Center(
                child:
                    CupertinoActivityIndicator(animating: true, radius: 12.sp),
              );
            }
          }),
    );
  }
}
