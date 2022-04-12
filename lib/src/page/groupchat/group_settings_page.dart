// ignore_for_file: implementation_imports, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/service/firebase/storage/groups/add_friend.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_leave.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/report_sheets.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../widget/liquid_progress_indicator.dart';

class GroupSettingsPage extends StatefulWidget {
  const GroupSettingsPage({Key? key}) : super(key: key);

  @override
  _GroupSettingsPageState createState() => _GroupSettingsPageState();
}

TextStyle groupSettingsNameStyle = 100.h >= 1100
    ? StyleConstants.groupSettingsTabletNameTextStyle
    : StyleConstants.groupSettingsNameTextStyle;

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  late GroupSettingModel groupSettingModel;
  late List<dynamic> joinedList;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late IsolaUserAll userAll;
  // ignore: prefer_typing_uninitialized_variables
  late var refChatInterior;
  @override
  void initState() {
    super.initState();
    userAll = context.read<UserAllCubit>().state;
    groupSettingModel = context.read<GroupSettingCubit>().state;
    joinedList = context.read<JoinedListCubit>().state;
    refChatInterior = context.read<ChatReferenceCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstant.milkColor,
        ),
        child: Container(
          color: ColorConstant.themeGrey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 5.h,
                  left: 100.h <= 1100 ? 42.w : 32.w,
                  child: CircleImageContainer(
                      circleImage: CircleAvatar(
                    radius: 100.h <= 1100 ? 55.sp : 35.sp,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70.sp),
                        child: CachedNetworkImage(
                          imageUrl: groupSettingModel.groupMemberAvatarUrl2,
                          fit: BoxFit.cover,
                          height: 110.sp,
                          width: 110.sp,
                          errorWidget: (context, url, error) =>
                              const Icon(CupertinoIcons.xmark_square),
                          cacheManager: CacheManager(Config(
                            "cachedImageFiles",
                            stalePeriod: const Duration(days: 3),
                            //one week cache period
                          )),
                        )),
                  ))),
              Positioned(
                  top: 5.h,
                  right: 100.h <= 1100 ? 42.w : 32.w,
                  child: CircleImageContainer(
                      circleImage: CircleAvatar(
                    radius: 100.h <= 1100 ? 55.sp : 35.sp,
                    backgroundColor: ColorConstant.milkColor,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70.sp),
                        child: CachedNetworkImage(
                          imageUrl: groupSettingModel.groupMemberAvatarUrl3,
                          fit: BoxFit.cover,
                          height: 110.sp,
                          width: 110.sp,
                          errorWidget: (context, url, error) =>
                              const Icon(CupertinoIcons.xmark_square),
                          cacheManager: CacheManager(Config(
                            "cachedImageFiles",
                            stalePeriod: const Duration(days: 3),
                            //one week cache period
                          )),
                        )),
                  ))),
              Positioned(
                  top: 100.h <= 700 ? 28.h : 25.h,
                  child: Text(
                      "${(groupSettingModel.groupMemberName2.length>11?(groupSettingModel.groupMemberName2).substring(0, 10):groupSettingModel.groupMemberName2)} & ${(groupSettingModel.groupMemberName3.length>11?(groupSettingModel.groupMemberName3).substring(0, 10):groupSettingModel.groupMemberName3)}",
                      style: StyleConstants.profileNameTextStyle)),
              Positioned(
                top: 100.h <= 1100 ? (100.h <= 700 ? 34.h : 30.h) : 34.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Participant",
                        style: 100.h >= 1100
                            ? StyleConstants.targetTabletChatMessageTextStyle
                            : StyleConstants.targetChatMessageTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    GroupMemberCardContainer(
                      groupMembersCard: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: CircleImageContainer(
                                    circleImage: CircleAvatar(
                                  backgroundColor: ColorConstant.milkColor,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.sp),
                                    child: CachedNetworkImage(
                                      imageUrl: groupSettingModel
                                          .groupMemberAvatarUrl1,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              CupertinoIcons.xmark_square),
                                      cacheManager: CacheManager(Config(
                                        "cachedImageFiles",
                                        stalePeriod: const Duration(days: 3),
                                        //one week cache period
                                      )),
                                    ),
                                  ),
                                  radius: 100.h >= 1100 ? 15.sp : 18.sp,
                                )),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Text(
                                    groupSettingModel.groupMemberName1,
                                    style: groupSettingsNameStyle,
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 1.w),
                              child: CupertinoButton(
                                child: 100.h >= 1100
                                    ? Icon(
                                        CupertinoIcons.person,
                                        size: 16.sp,
                                      )
                                    : const Icon(CupertinoIcons.person),
                                onPressed: () {},
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                    GroupMemberCardContainer(
                      groupMembersCard: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: CircleImageContainer(
                                    circleImage: CircleAvatar(
                                  backgroundColor: ColorConstant.milkColor,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: CachedNetworkImage(
                                      imageUrl: groupSettingModel
                                          .groupMemberAvatarUrl2,
                                      fit: BoxFit.cover,
                                      height: 50.sp,
                                      width: 50.sp,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              CupertinoIcons.xmark_square),
                                      cacheManager: CacheManager(Config(
                                        "cachedImageFiles",
                                        stalePeriod: const Duration(days: 3),
                                        //one week cache period
                                      )),
                                    ),
                                  ),
                                  radius: 100.h >= 1100 ? 15.sp : 18.sp,
                                )),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Text(
                                      groupSettingModel.groupMemberName2,
                                      style: groupSettingsNameStyle)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: userAll.isolaUserMeta.userFriends
                                    .contains(groupSettingModel.groupMemberUid2)
                                ? CupertinoButton(
                                    child: 100.h >= 1100
                                        ? Icon(
                                            CupertinoIcons.person,
                                            size: 16.sp,
                                          )
                                        : const Icon(CupertinoIcons.person),
                                    onPressed: () {},
                                  )
                                : userAll.isolaUserMeta.userFriendOrders
                                        .contains(
                                            groupSettingModel.groupMemberUid2)
                                    ? CupertinoButton(
                                        child: 100.h >= 1100
                                            ? Icon(
                                                CupertinoIcons.clock_fill,
                                                size: 16.sp,
                                              )
                                            : const Icon(
                                                CupertinoIcons.clock_fill,
                                              ),
                                        onPressed: () {})
                                    : userAll.isolaUserMeta.userBlocked
                                            .contains(groupSettingModel
                                                .groupMemberUid2)
                                        ? CupertinoButton(
                                            child: 100.h >= 1100
                                                ? Icon(
                                                    CupertinoIcons
                                                        .exclamationmark_triangle,
                                                    color:
                                                        ColorConstant.redAlert,
                                                    size: 16.sp,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons
                                                        .exclamationmark_triangle,
                                                    color:
                                                        ColorConstant.redAlert,
                                                  ),
                                            onPressed: () {})
                                        : CupertinoButton(
                                            child: 100.h >= 1100
                                                ? Icon(
                                                    CupertinoIcons.plus,
                                                    size: 16.sp,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons.plus,
                                                  ),
                                            onPressed: () {
                                              addFriend(
                                                      groupSettingModel
                                                          .groupMemberUid2,
                                                      userAll)
                                                  .whenComplete(() {
                                                var friendOrderUpdate =
                                                    <dynamic>[];

                                                friendOrderUpdate.addAll(userAll
                                                    .isolaUserMeta.userFriends);

                                                friendOrderUpdate.add(
                                                    groupSettingModel
                                                        .groupMemberUid2);

                                                userAll.isolaUserMeta
                                                        .userFriendOrders =
                                                    friendOrderUpdate;

                                                setState(() {});
                                              });
                                            }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                    GroupMemberCardContainer(
                      groupMembersCard: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: CircleImageContainer(
                                    circleImage: CircleAvatar(
                                  backgroundColor: ColorConstant.milkColor,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.sp),
                                    child: CachedNetworkImage(
                                      imageUrl: groupSettingModel
                                          .groupMemberAvatarUrl3,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              CupertinoIcons.xmark_square),
                                      cacheManager: CacheManager(Config(
                                        "cachedImageFiles",
                                        stalePeriod: const Duration(days: 3),
                                        //one week cache period
                                      )),
                                    ),
                                  ),
                                  radius: 100.h >= 1100 ? 15.sp : 18.sp,
                                )),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Text(
                                      groupSettingModel.groupMemberName3,
                                      style: groupSettingsNameStyle)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: userAll.isolaUserMeta.userFriends
                                    .contains(groupSettingModel.groupMemberUid3)
                                ? CupertinoButton(
                                    child: 100.h >= 1100
                                        ? Icon(
                                            CupertinoIcons.person,
                                            size: 16.sp,
                                          )
                                        : const Icon(CupertinoIcons.person),
                                    onPressed: () {},
                                  )
                                : userAll.isolaUserMeta.userFriendOrders
                                        .contains(
                                            groupSettingModel.groupMemberUid3)
                                    ? CupertinoButton(
                                        child: 100.h >= 1100
                                            ? Icon(
                                                CupertinoIcons.clock_fill,
                                                size: 16.sp,
                                              )
                                            : const Icon(
                                                CupertinoIcons.clock_fill,
                                              ),
                                        onPressed: () {})
                                    : userAll.isolaUserMeta.userBlocked
                                            .contains(groupSettingModel
                                                .groupMemberUid3)
                                        ? CupertinoButton(
                                            child: 100.h >= 1100
                                                ? Icon(
                                                    CupertinoIcons
                                                        .exclamationmark_triangle,
                                                    color:
                                                        ColorConstant.redAlert,
                                                    size: 16.sp,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons
                                                        .exclamationmark_triangle,
                                                    color:
                                                        ColorConstant.redAlert,
                                                  ),
                                            onPressed: () {})
                                        : CupertinoButton(
                                            child: 100.h >= 1100
                                                ? Icon(
                                                    CupertinoIcons.plus,
                                                    size: 16.sp,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons.plus,
                                                  ),
                                            onPressed: () {
                                              addFriend(
                                                      groupSettingModel
                                                          .groupMemberUid3,
                                                      userAll)
                                                  .whenComplete(() {
                                                var friendOrderUpdate =
                                                    <dynamic>[];

                                                friendOrderUpdate.addAll(userAll
                                                    .isolaUserMeta.userFriends);

                                                friendOrderUpdate.add(
                                                    groupSettingModel
                                                        .groupMemberUid3);

                                                userAll.isolaUserMeta
                                                        .userFriendOrders =
                                                    friendOrderUpdate;

                                                setState(() {});
                                              });
                                            }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        100.h >= 1100
                            ? SizedBox(
                                width: 5.w,
                              )
                            : const SizedBox(),
                        CupertinoButton(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14.0)),
                                color: ColorConstant.groupSettingsButton2,
                              ),
                              height: 5.h,
                              width: 36.w,
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "asset/img/group_settings_exit_icon.png"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 1.5.w),
                                    child: Text(
                                      "Leave Group",
                                      style: StyleConstants
                                          .userChatMessageTextStyle,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () async {
//

                              CollectionReference chaosApply2Ref =
                                  FirebaseFirestore.instance
                                      .collection('groups');

                              await chaosApply2Ref
                                  .doc(groupSettingModel.groupNo)
                                  .get()
                                  .then((value) {
                                if (value['gChaosSearching']) {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            content: const Text(
                                                "You can't leave the group when you are searching chaos "),
                                            actions: [
                                              CupertinoButton(
                                                  child: const Text('Okey'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ));
                                } else {
                                  leaveGroup(groupSettingModel)
                                      .whenComplete(() {
                                    Future.delayed(
                                        const Duration(milliseconds: 3000), () {
                                      Navigator.pushReplacementNamed(
                                          context, navigationBar);
                                    });
                                  });
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const AnimatedLiquidCircularProgressIndicator());
                                }
                              });
                            }),
                        CupertinoButton(
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),
                                  color: ColorConstant.groupSettingsButton2,
                                ),
                                height: 5.h,
                                width: 36.w,
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          "asset/img/group_settings_info_icon.png"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 1.5.w),
                                      child: Text("Report Group",
                                          style: StyleConstants
                                              .userChatMessageTextStyle),
                                    )
                                  ],
                                )),
                            onPressed: () async {
                              //
                              CollectionReference chaosApply2Ref =
                                  FirebaseFirestore.instance
                                      .collection('groups');

                              await chaosApply2Ref
                                  .doc(groupSettingModel.groupNo)
                                  .get()
                                  .then((value) {
                                if (value['gChaosSearching']) {
                                  CollectionReference chaosApply2Ref =
                                      FirebaseFirestore.instance
                                          .collection('chaos_apply_pool_2');

                                  chaosApply2Ref
                                      .doc(groupSettingModel.groupNo)
                                      .get()
                                      .then((valueApply) {
                                    var gList = valueApply['groupMemberList']
                                        as List<dynamic>;
                                    if (gList.length == 3) {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
                                                content: const Text(
                                                    "You can't leave the group when you are searching chaos "),
                                                actions: [
                                                  CupertinoButton(
                                                      child: const Text('Okey'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              ));
                                    } else {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
                                                  content:
                                                      const Text('Stop Matching?'),
                                                  actions: [
                                                    CupertinoButton(
                                                        child: const Text('Yes'),
                                                        onPressed: () {
                                                          DocumentReference
                                                              stopMatchRef =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'chaos_stopper_pool')
                                                                  .doc();

                                                          stopMatchRef.set({
                                                            'orderNo':
                                                                stopMatchRef.id,
                                                            'groupNo':
                                                                groupSettingModel
                                                                    .groupNo
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          //chaos matching stop pool oluştur
                                                          //orayı checker eden bir şey
                                                          //
                                                        }),
                                                    CupertinoButton(
                                                        child:
                                                            const Text('No Go Back'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ]));
                                    }
                                  });
                                } else {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoActionSheet(
                                            title:
                                                const Text('Report & Block !'),
                                            message: const Text(
                                                'Please choose a operation, then you will leave this group '),
                                            actions: [
                                              CupertinoActionSheetAction(
                                                child: Text(groupSettingModel
                                                    .groupMemberName2),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          ReportSheet(
                                                            reporterUid:
                                                                groupSettingModel
                                                                    .userUid,
                                                            targetUid1:
                                                                groupSettingModel
                                                                    .groupMemberUid2,
                                                            targetUid2: "",
                                                            isAllGroup: false,
                                                            groupNo:
                                                                groupSettingModel
                                                                    .groupNo,
                                                            groupSettingModel:
                                                                groupSettingModel,
                                                          ));
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: Text(groupSettingModel
                                                    .groupMemberName3),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          ReportSheet(
                                                            reporterUid:
                                                                groupSettingModel
                                                                    .userUid,
                                                            targetUid1:
                                                                groupSettingModel
                                                                    .groupMemberUid3,
                                                            targetUid2: "",
                                                            isAllGroup: false,
                                                            groupNo:
                                                                groupSettingModel
                                                                    .groupNo,
                                                            groupSettingModel:
                                                                groupSettingModel,
                                                          ));
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: const Text(' All Group'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          ReportSheet(
                                                            reporterUid:
                                                                groupSettingModel
                                                                    .userUid,
                                                            targetUid1:
                                                                groupSettingModel
                                                                    .groupMemberUid2,
                                                            targetUid2:
                                                                groupSettingModel
                                                                    .groupMemberUid3,
                                                            isAllGroup: true,
                                                            groupNo:
                                                                groupSettingModel
                                                                    .groupNo,
                                                            groupSettingModel:
                                                                groupSettingModel,
                                                          ));
                                                },
                                              ),
                                            ],
                                          ));
                                }
                              });
                            }),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class CircleImageContainer extends StatelessWidget {
  Widget circleImage;

  CircleImageContainer({Key? key, required this.circleImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.all(Radius.circular(80.sp))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          decoration: BoxDecoration(
              color: ColorConstant.milkColor,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: BorderRadius.all(Radius.circular(80.sp))),
          child: circleImage,
        ),
      ),
    );
  }
}

class GroupMemberCardContainer extends StatelessWidget {
  Widget groupMembersCard;

  GroupMemberCardContainer({Key? key, required this.groupMembersCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 8.h,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.all(Radius.circular(15.sp))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          decoration: BoxDecoration(
              color: ColorConstant.milkColor,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              boxShadow: [
                BoxShadow(
                    color: ColorConstant.softBlack.withOpacity(0.3),
                    blurRadius: 3.0,
                    spreadRadius: 0.01,
                    offset: const Offset(0.0, 5.0))
              ]),
          child: groupMembersCard,
        ),
      ),
    );
  }
}
