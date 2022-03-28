// ignore_for_file: implementation_imports, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, duplicate_ignore, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/group/groups_model.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_chaos/chat_chaos_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_normal/chat_normal_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_waiting/chat_waiting_widgets.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../model/hive_models/user_hive.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key, required this.user, required this.groupMergeDataComing})
      : super(key: key);
  final User? user;
  final GroupMergeData groupMergeDataComing;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late int chatContValue;
  late bool needSearchingContainer;
  late var groupMergeData;

  @override
  void initState() {
    super.initState();

    groupMergeData = widget.groupMergeDataComing.groupsModel;

    if (widget.groupMergeDataComing.userAll.isolaUserMeta.joinedGroupList[0] ==
        "nothing") {
      if (widget.groupMergeDataComing.userAll.isolaUserMeta.userIsSearching) {
        needSearchingContainer = true;
        chatContValue = 1;
      } else {
        needSearchingContainer = false;
        chatContValue = 0;
      }
    } else {
      if (widget.groupMergeDataComing.userAll.isolaUserMeta.userIsSearching) {
        needSearchingContainer = true;
        chatContValue = widget.groupMergeDataComing.userAll.isolaUserMeta
                .joinedGroupList.length +
            1;
      } else {
        needSearchingContainer = false;
        chatContValue = widget
            .groupMergeDataComing.userAll.isolaUserMeta.joinedGroupList.length;
      }
    }

    /*

    widget.groupPreviewData.userAll.isolaUserMeta.joinedGroupList[0] ==
            "nothing"
        ? chatContValue = 0
        : (chatContValue = widget
            .groupPreviewData.userAll.isolaUserMeta.joinedGroupList.length);

    initTraw.add("asset/img/settings_button.png");*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  print("H: ${100.h}");
    // print("W: ${100.w}");

    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: false,
        ),
        child: chatContValue < 1 &&
                widget.groupMergeDataComing.userAll.isolaUserMeta
                        .userIsSearching ==
                    false
            ? (Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("asset/img/chat_warning_icon.png"),
                    const Text(
                      "You didnt join group",
                      style: TextStyle(color: ColorConstant.softBlack),
                    ),
                  ],
                ),
              ))
            : Container(
                color: ColorConstant.themeGrey,
                child: ListView.builder(
                    itemCount: chatContValue,
                    itemBuilder: (context, indeks) {
                      var groupsItem = <Widget>[];

                      var itemWaiting = const ChatGroupContWaiting();
                      // ignore: unused_local_variable

                      for (var groupData
                          in groupMergeData as List<GroupsModel>) {
                        if (groupData.groupChaosIsActive) {
                          //  print("1 kere döndü");

                          final Stream<QuerySnapshot> _chaosStream =
                              FirebaseFirestore.instance
                                  .collection('chaos_groups_chat')
                                  .doc(groupData.groupChaosNo)
                                  .collection('chat_data')
                                  .snapshots();

                          /*  CollectionReference chaosRef = FirebaseFirestore.instance
                        .collection('chaos_groups_chat')
                        .doc(groupData.groupChaosNo)
                        .collection('chat_data');*/
                          var chaosCont = ChaosGroupCont(
                              myUid: widget.groupMergeDataComing.userAll
                                  .isolaUserMeta.userUid,
                              notiValue: 2,
                              ref: _chaosStream,
                              chatGroupNo: groupData.groupChaosNo,
                              userAll: widget.groupMergeDataComing.userAll);

                          groupsItem.add(chaosCont);
                        } else {
                          /* CollectionReference chatRef = FirebaseFirestore.instance
                        .collection('groups_chat')
                        .doc(groupData.groupNo)
                        .collection('chat_data');*/
                          var groupCont = ChatGroupCont(
                            myUid: widget.groupMergeDataComing.userAll
                                .isolaUserMeta.userUid,
                            chatGroupNo: groupData.groupNo,
                            userAll: widget.groupMergeDataComing.userAll,
                            groupMergeData: widget.groupMergeDataComing,
                          );

                          groupsItem.add(groupCont);
                        }
                      }

/*
                widget.groupPreviewData.groupAlives.group1Alive == true;
                var item1 = widget
                                .groupPreviewData.groupAlives.group1Searching !=
                            true &&
                        widget.groupPreviewData.groupAlives.group1Alive == true
                    ? (widget.groupPreviewData.groupAlives.is1ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            notiValue: 2,
                            ref:
                                refGetter(
                                    enum2: RefEnum.Chaosgroupchatlist,
                                    targetUid: "",
                                    userUid: "",
                                    crypto:
                                        widget.groupPreviewData.groupAlives
                                            .chaos1GroupNo),
                            chatGroupNo: widget
                                .groupPreviewData.groupAlives.chaos1GroupNo,
                            userAll: widget.groupPreviewData.userAll)
                        : ChatGroupCont(
                            notiValue: 2,
                            ref: refGetter(
                                enum2: RefEnum.Groupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.userAll
                                    .isolaUserMeta.joinedGroupList[0]),
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .isolaUserMeta.joinedGroupList[0],
                            userAll: widget.groupPreviewData.userAll,
                          ))
                    : const ChatGroupContWaiting();

                var item2 = widget.groupPreviewData.groupAlives.group2Searching != true &&
                        widget.groupPreviewData.groupAlives.group2Alive == true
                    ? (widget.groupPreviewData.groupAlives.is2ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            notiValue: 2,
                            ref: refGetter(
                                enum2: RefEnum.Chaosgroupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.groupAlives
                                    .chaos2GroupNo),
                            chatGroupNo: widget
                                .groupPreviewData.groupAlives.chaos2GroupNo,
                            userAll: widget.groupPreviewData.userAll)
                        : ChatGroupCont(
                            notiValue: 1,
                            ref: refGetter(
                                enum2: RefEnum.Groupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.userAll
                                    .isolaUserMeta.joinedGroupList[1]),
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            chatGroupNo:
                                widget.groupPreviewData.userAll.isolaUserMeta.joinedGroupList[1],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();
                var item3 = widget.groupPreviewData.groupAlives.group3Searching != true &&
                        widget.groupPreviewData.groupAlives.group3Alive == true
                    ? (widget.groupPreviewData.groupAlives.is3ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            notiValue: 2,
                            ref: refGetter(
                                enum2: RefEnum.Chaosgroupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.groupAlives
                                    .chaos3GroupNo),
                            chatGroupNo: widget
                                .groupPreviewData.groupAlives.chaos3GroupNo,
                            userAll: widget.groupPreviewData.userAll)
                        : ChatGroupCont(
                            notiValue: 4,
                            ref: refGetter(
                                enum2: RefEnum.Groupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.userAll
                                    .isolaUserMeta.joinedGroupList[2]),
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            chatGroupNo:
                                widget.groupPreviewData.userAll.isolaUserMeta.joinedGroupList[2],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();
                var item4 = widget.groupPreviewData.groupAlives.group4Searching != true &&
                        widget.groupPreviewData.groupAlives.group4Alive == true
                    ? (widget.groupPreviewData.groupAlives.is4ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            notiValue: 2,
                            ref: refGetter(
                                enum2: RefEnum.Chaosgroupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.groupAlives
                                    .chaos4GroupNo),
                            chatGroupNo: widget
                                .groupPreviewData.groupAlives.chaos4GroupNo,
                            userAll: widget.groupPreviewData.userAll)
                        : ChatGroupCont(
                            notiValue: 4,
                            ref: refGetter(
                                enum2: RefEnum.Groupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.userAll
                                    .isolaUserMeta.joinedGroupList[3]),
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            chatGroupNo:
                                widget.groupPreviewData.userAll.isolaUserMeta.joinedGroupList[3],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();

                var item5 = widget.groupPreviewData.groupAlives.group5Searching != true &&
                        widget.groupPreviewData.groupAlives.group5Alive == true
                    ? (widget.groupPreviewData.groupAlives.is5ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            notiValue: 2,
                            ref: refGetter(
                                enum2: RefEnum.Chaosgroupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.groupAlives
                                    .chaos5GroupNo),
                            chatGroupNo: widget
                                .groupPreviewData.groupAlives.chaos5GroupNo,
                            userAll: widget.groupPreviewData.userAll)
                        : ChatGroupCont(
                            notiValue: 4,
                            ref: refGetter(
                                enum2: RefEnum.Groupchatlist,
                                targetUid: "",
                                userUid: "",
                                crypto: widget.groupPreviewData.userAll
                                    .isolaUserMeta.joinedGroupList[4]),
                            myUid: widget
                                .groupPreviewData.userAll.isolaUserMeta.userUid,
                            chatGroupNo:
                                widget.groupPreviewData.userAll.isolaUserMeta.joinedGroupList[4],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();

                if (widget.groupPreviewData.groupAlives.group1Alive == true) {
                  groupsItem.add(item1);
                }
                if (widget.groupPreviewData.groupAlives.group2Alive == true) {
                  groupsItem.add(item2);
                }
                if (widget.groupPreviewData.groupAlives.group3Alive == true) {
                  groupsItem.add(item3);
                }
                if (widget.groupPreviewData.groupAlives.group4Alive == true) {
                  groupsItem.add(item4);
                }
                if (widget.groupPreviewData.groupAlives.group5Alive == true) {
                  groupsItem.add(item5);
                }
*/
                      if (needSearchingContainer == true) {
                        groupsItem.add(itemWaiting);
                      }
                      // print("fashjjhbfsa");
                      return Padding(
                        padding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [groupsItem[indeks]],
                        ),
                      );
                    }),
              ));
  }
}

class ImageChatClip extends StatelessWidget {
  final Widget imageItem;
  final int leftPadding;

  const ImageChatClip(
      {Key? key, required this.imageItem, required this.leftPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.7.h,
      left: leftPadding.w,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorConstant.milkColor.withOpacity(0.03), width: 2.0),
            /*
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: Offset.zero,
                  color: ColorConstant.softBlack.withOpacity(0.15))
            ],*/
            color: ColorConstant.milkColor.withOpacity(0.05),
            borderRadius: BorderRadius.all(Radius.circular(35.sp))),
        child: CircleAvatar(
          radius: 15.sp,
          backgroundColor: ColorConstant.milkColor,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(35.sp), child: imageItem),
        ),
      ),
    );
  }
}

class MessageNotificationMini extends StatelessWidget {
  final int notiValue;
  final int leftPadding;

  const MessageNotificationMini(
      {Key? key, required this.notiValue, required this.leftPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: leftPadding.w,
      child: Container(
        decoration: BoxDecoration(
            gradient: ColorConstant.isolaMainGradient,
            border: Border.all(color: ColorConstant.milkColor, width: 1.0),
            /*
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: Offset.zero,
                  color: ColorConstant.softBlack.withOpacity(0.25))
            ],*/

            color: ColorConstant.milkColor,
            borderRadius: BorderRadius.all(Radius.circular(20.h))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.h),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              " $notiValue ",
              style: StyleConstants.softMilkTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatTextsLeft extends StatelessWidget {
  String targetName;
  String targetText;
  int rowLetterValue;
  TextStyle letterTextStyle;
  double heightValue;
  ChatTextsLeft(
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
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
          child: Text(
            targetName,
            style: 100.h >= 1100
                ? StyleConstants.softDarkTabletTextStyle
                : StyleConstants.softDarkTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(2.w, 0.8.h, 2.w, 0.h),
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
