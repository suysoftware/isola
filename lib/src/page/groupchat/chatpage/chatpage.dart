// ignore_for_file: implementation_imports, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, duplicate_ignore, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_chaos/chat_chaos_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_normal/chat_normal_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_waiting/chat_waiting_widgets.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.user, required this.groupPreviewData})
      : super(key: key);
  final User? user;
  final GroupPreviewData groupPreviewData;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late int chatContValue;

  var initTraw = <String>[];

  bool isInfoEqual = false;
  bool isGrand = false;
  bool isGrandL1 = false;
  bool isGrandL2 = false;
  bool isGrandL3 = false;
  bool isGrandL4 = false;
  bool isGrandL5 = false;
  int isGrandSa = 0;
  int isGrandDa = 0;

  @override
  void initState() {
    super.initState();
    widget.groupPreviewData.userAll.userMeta.joinedGroupList[0] == "nothing"
        ? chatContValue = 0
        : chatContValue =
            widget.groupPreviewData.userAll.userMeta.joinedGroupList.length;

    initTraw.add("asset/img/settings_button.png");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("H: ${100.h}");
    print("W: ${100.w}");
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: ColorConstant.milkColor,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onDoubleTap: () {
                if (isGrandL3 != true) {
                  if (isGrandL2 == true) {
                    isGrand = true;
                  }
                  if (widget.groupPreviewData.userAll.userDisplay
                              .userBiography ==
                          GambitConstant.gambitProfile.userBiography &&
                      widget.groupPreviewData.userAll.userDisplay.userName ==
                          GambitConstant.gambitProfile.userName &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userInterest[0] ==
                          GambitConstant.gambitProfile.userInterest[0] &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userInterest[1] ==
                          GambitConstant.gambitProfile.userInterest[1] &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userInterest[2] ==
                          GambitConstant.gambitProfile.userInterest[2] &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userInterest[3] ==
                          GambitConstant.gambitProfile.userInterest[3] &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userUniversity ==
                          GambitConstant.gambitProfile.userUniversity &&
                      widget.groupPreviewData.userAll.userDisplay.userSex ==
                          GambitConstant.gambitProfile.userSex &&
                      widget.groupPreviewData.userAll.userDisplay
                              .userIsNonBinary ==
                          GambitConstant.gambitProfile.userIsNonBinary) {
                    isInfoEqual = true;
                    isGrandDa = 0;
                    isGrandSa = 0;
                    isGrandL1 = false;
                    isGrandL2 = false;
                    isGrandL3 = false;
                    isGrandL4 = false;
                    isGrandL5 = false;
                    print("infoequaltrue oldu");
                  } else {
                    isInfoEqual = false;
                    isGrandL1 = false;
                    isGrandL2 = false;
                    isGrandL3 = false;
                    isGrandL4 = false;
                    isGrandL5 = false;
                  }
                }
              },
              onTap: () {
                if (isGrandL3 != true) {
                  print("onTap");
                  print(isInfoEqual);
                  if (isInfoEqual == true) {
                    if (isGrandL1 != true) {
                      print(DateTime.now().hour);
                      isGrandSa = isGrandSa + 1;
                      print(isGrandSa);
                    } else {
                      isGrandDa = isGrandDa + 1;
                      print(isGrandDa);
                    }
                  }
                }
              },
              onLongPress: () {
                if (isGrandL3 != true) {
                  if (isInfoEqual == true) {
                    if (isGrandL1 != true) {
                      print("ff");
                      if (DateTime.now().hour == isGrandSa) {
                        print("level1 open");

                        isGrandL1 = true;
                      } else {
                        isGrandSa = 0;
                        isGrandL1 = false;
                        isGrandL2 = false;
                        isGrandL3 = false;
                        isGrandL4 = false;
                        isGrandL5 = false;
                      }
                    } else {
                      if (DateTime.now().minute == isGrandDa) {
                        print("level2 open");
                        setState(() {
                          isGrandL1 = true;
                          isGrandL2 = true;
                          isGrand = true;
                          isGrandSa = 0;
                          isGrandDa = 0;
                        });
                      } else {
                        isGrandDa = 0;
                        isGrandL1 = false;
                        isGrandL2 = false;
                        isGrandL3 = false;
                        isGrandL4 = false;
                        isGrandL5 = false;
                      }
                    }
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Chat"),
              ),
            ),
            trailing: Visibility(
              visible: isGrand,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onDoubleTap: () {
                    if (isGrandL1 == true &&
                        isGrandL2 == true &&
                        isGrandL3 == true &&
                        isGrandL4 == true) {
                      setState(() {
                        initTraw.shuffle();
                        isGrand = true;
                        isGrandL1 == true;
                        isGrandL2 == true;
                        isGrandL3 == true;
                        isGrandL4 == true;
                      });
                    }
                  },
                  onTap: () {
                    if (isGrandL4 != true) {
                      //  print(isGrandL3);
                      if (isGrandL3 != true) {
                        //      print(DateTime.now().hour);
                        isGrandDa = isGrandDa + 1;
                        print(isGrandDa);
                      } else {
                        isGrandSa = isGrandSa + 1;
                      }
                      print("iç");
                    }
                  },
                  onLongPress: () {
                    if (isGrandL1 == true &&
                        isGrandL2 == true &&
                        isGrandL3 == true &&
                        isGrandL4 == true) {
                      if (initTraw[0] ==
                          "asset/img/boring_files/white_lotus_tile.png") {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => const CupertinoAlertDialog(
                                content: Text("girdin")));
                      }
                    }

                    if (isGrandL3 != true) {
                      if (DateTime.now().minute == isGrandDa) {
                        print("level3 oppen");

                        isGrandL3 = true;
                      } else {
                        setState(() {
                          isGrandDa = 0;
                          isGrandL1 = false;
                          isGrandL2 = false;
                          isGrandL3 = false;
                          isGrandL4 = false;
                          isGrandL5 = false;
                        });
                      }
                    } else {
                      if (DateTime.now().hour == isGrandSa) {
                        print("level4 open");
                        setState(() {
                          isGrandL1 = true;
                          isGrandL2 = true;
                          isGrandL3 = true;
                          isGrandL4 = true;
                          isGrand = true;
                          initTraw.clear();
                          initTraw.add(
                              "asset/img/boring_files/chrysanthemum_tile.png");
                          initTraw
                              .add("asset/img/boring_files/fire_lily_tile.png");
                          initTraw.add("asset/img/boring_files/wheel_tile.png");
                          initTraw.add(
                              "asset/img/boring_files/white_lotus_tile.png");
                          initTraw.shuffle();
                        });
                      } else {
                        setState(() {
                          isGrandSa = 0;
                          isGrandL1 = false;
                          isGrandL2 = false;
                          isGrandL3 = false;
                          isGrandL4 = false;
                          isGrandL5 = false;
                        });
                      }
                    }
                  },
                  child: Image.asset(initTraw[0]),
                ),
              ),
            )),
        child: Container(
          color: ColorConstant.themeGrey,
          child: ListView.builder(
              itemCount: chatContValue,
              itemBuilder: (context, indeks) {
                var groupsItem = <Widget>[];
                // ignore: unused_local_variable

                widget.groupPreviewData.groupAlives.group1Alive == true;
                var item1 = widget
                                .groupPreviewData.groupAlives.group1Searching !=
                            true &&
                        widget.groupPreviewData.groupAlives.group1Alive == true
                    ? (widget.groupPreviewData.groupAlives.is1ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
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
                                crypto: widget.groupPreviewData.userAll.userMeta
                                    .joinedGroupList[0]),
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .userMeta.joinedGroupList[0],
                            userAll: widget.groupPreviewData.userAll,
                          ))
                    : const ChatGroupContWaiting();

                var item2 = widget.groupPreviewData.groupAlives.group2Searching != true &&
                        widget.groupPreviewData.groupAlives.group2Alive == true
                    ? (widget.groupPreviewData.groupAlives.is2ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
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
                                crypto: widget.groupPreviewData.userAll.userMeta
                                    .joinedGroupList[1]),
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .userMeta.joinedGroupList[1],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();
                var item3 = widget.groupPreviewData.groupAlives.group3Searching != true &&
                        widget.groupPreviewData.groupAlives.group3Alive == true
                    ? (widget.groupPreviewData.groupAlives.is3ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
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
                                crypto: widget.groupPreviewData.userAll.userMeta
                                    .joinedGroupList[2]),
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .userMeta.joinedGroupList[2],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();
                var item4 = widget.groupPreviewData.groupAlives.group4Searching != true &&
                        widget.groupPreviewData.groupAlives.group4Alive == true
                    ? (widget.groupPreviewData.groupAlives.is4ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
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
                                crypto: widget.groupPreviewData.userAll.userMeta
                                    .joinedGroupList[3]),
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .userMeta.joinedGroupList[3],
                            userAll: widget.groupPreviewData.userAll))
                    : const ChatGroupContWaiting();

                var item5 = widget.groupPreviewData.groupAlives.group5Searching != true &&
                        widget.groupPreviewData.groupAlives.group5Alive == true
                    ? (widget.groupPreviewData.groupAlives.is5ChaosAlive == true
                        ? ChaosGroupCont(
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
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
                                crypto: widget.groupPreviewData.userAll.userMeta
                                    .joinedGroupList[4]),
                            myUid: widget
                                .groupPreviewData.userAll.userDisplay.userUid,
                            chatGroupNo: widget.groupPreviewData.userAll
                                .userMeta.joinedGroupList[4],
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
             backgroundColor:ColorConstant.milkColor,
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
