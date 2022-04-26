// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class ProfileTimelinePage extends StatefulWidget {
  final User user;
  final IsolaUserAll userAll;

  const ProfileTimelinePage(
      {Key? key, required this.user, required this.userAll})
      : super(key: key);

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
        .doc(widget.userAll.isolaUserMeta.userUid)
        .collection('text_feeds');
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<dynamic>(
          stream: _profileRef
              .orderBy("feed_date", descending: true)
              .limit(amountData)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!snapshot.hasData) {
                return Center(
                  child: CupertinoActivityIndicator(
                      animating: true, radius: 12.sp),
                );
              }

              final data = snapshot.requireData;

              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                footer: const ClassicFooter(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child:data.size<1?Column(
                                  
                                  
                                    children: [
                                           SizedBox(height: 5.h,),
                                      Icon( CupertinoIcons.pencil_slash,size: 60.sp,color: CupertinoColors.systemGrey,),
                                     SizedBox(height: 2.h,),
                                      Text(LocaleKeys.profile_timelineempty.tr(),style: TextStyle(fontFamily: 'Roboto',fontSize: 12.sp),)
                                    ],
                                  ): ListView.builder(
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
                                widget.userAll.isolaUserDisplay.avatarUrl,
                                data.docs[indeks]['user_name'],
                                data.docs[indeks]['user_uid']),
                            userUid: widget.userAll.isolaUserMeta.userUid,
                            isTimeline: false,
                            isolaUserAll: widget.userAll,
                          ));
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
