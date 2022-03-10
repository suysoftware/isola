// ignore_for_file: implementation_imports, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/blocs/joined_list_cubit.dart';
import 'package:isola_app/src/blocs/user_display_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/service/firebase/storage/groups/add_friend.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_leave.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_leave_message.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

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
  late UserDisplay userDisplay;
  late var refChatInterior;
  @override
  void initState() {
    super.initState();

    userDisplay = context.read<UserDisplayCubit>().state;

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
                        child: Image.network(
                          groupSettingModel.groupMemberAvatarUrl2,
                          fit: BoxFit.cover,
                          height: 110.sp,
                          width: 110.sp,
                        )),
                  ))),
              Positioned(
                  top: 5.h,
                  right: 100.h <= 1100 ? 42.w : 32.w,
                  child: CircleImageContainer(
                      circleImage: CircleAvatar(
                    radius: 100.h <= 1100 ? 55.sp : 35.sp,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70.sp),
                        child: Image.network(
                          groupSettingModel.groupMemberAvatarUrl3,
                          fit: BoxFit.cover,
                          height: 110.sp,
                          width: 110.sp,
                        )),
                  ))),
              Positioned(
                  top: 100.h <= 700 ? 28.h : 25.h,
                  child: Text(
                      "${groupSettingModel.groupMemberName2} & ${groupSettingModel.groupMemberName3}",
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: Image.network(
                                      groupSettingModel.groupMemberAvatarUrl1,
                                      fit: BoxFit.cover,
                                      height: 35.sp,
                                      width: 35.sp,
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
                                //padding: EdgeInsets.fromLTRB(3.w, 1.h, 0.0, 1.h),
                                padding: EdgeInsets.only(left: 3.w),
                                child: CircleImageContainer(
                                    circleImage: CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: Image.network(
                                      groupSettingModel.groupMemberAvatarUrl2,
                                      fit: BoxFit.cover,
                                      height: 50.sp,
                                      width: 50.sp,
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
                            child: userDisplay.userFriends
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
                                              groupSettingModel.groupMemberUid2,
                                              userDisplay)
                                          .whenComplete(() {
                                        var friendUpdate = <dynamic>[];

                                        friendUpdate
                                            .addAll(userDisplay.userFriends);

                                        friendUpdate.add(
                                            groupSettingModel.groupMemberUid2);

                                        userDisplay.userFriends = friendUpdate;

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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.sp),
                                    child: Image.network(groupSettingModel
                                        .groupMemberAvatarUrl3),
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
                            child: userDisplay.userFriends
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
                                              groupSettingModel.groupMemberUid3,
                                              userDisplay)
                                          .whenComplete(() {
                                        ///burada sorun veriyor çünkü userfriend listesini ilk biryere aktarıp sonradan ona eklicez;
                                        var friendUpdate = <dynamic>[];

                                        friendUpdate
                                            .addAll(userDisplay.userFriends);

                                        friendUpdate.add(
                                            groupSettingModel.groupMemberUid3);

                                        userDisplay.userFriends = friendUpdate;

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
                            onPressed: () {
                              //buraya groupneedliste nothingi dğeiştirip kendi kodunu eklemeyi unutma
                              groupChaosSearchingInfoGetter(
                                      groupSettingModel.groupNo)
                                  .then((value) {
                                if (value == true) {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            content: Text(
                                                "You can't leave group when you are searching chaos"),
                                            actions: [
                                              CupertinoButton(
                                                  child: Text("okey"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ));
                                } else {
                                  groupLeaveMessage(
                                          groupSettingModel, refChatInterior)
                                      .whenComplete(() {
                                    groupLeave(
                                            groupSettingModel.groupNo,
                                            groupSettingModel.userUid,
                                            joinedList)
                                        .whenComplete(() {
                                      Navigator.pushReplacementNamed(
                                          context, navigationBar);
                                    });
                                  });
                                }
                              });

                              //    print(groupSettingModel.groupNo);
                              //  print(
                              //    "buraya gruptan çıkma işlemi yapılacak o sebeple groupno getiriyorum");
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
                            onPressed: () {}),
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
