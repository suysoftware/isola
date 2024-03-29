// ignore_for_file: implementation_imports, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, duplicate_ignore, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/group/groups_model.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_chaos/chat_chaos_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_normal/chat_normal_widgets.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chat_waiting/chat_waiting_widgets.dart';
import 'package:isola_app/src/widget/text_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/group_merge_cubit.dart';

class ChatPage extends StatefulWidget {
  ChatPage(
      {Key? key,
      required this.user,
      required this.groupMergeData,
      required this.messaging})
      : super(key: key);
  final User? user;
  final GroupMergeData groupMergeData;
  FirebaseMessaging messaging;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late bool needSearchingContainer;

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
    return BlocBuilder<GroupMergeCubit, GroupMergeData>(
        builder: (context, groupMerge) {
      return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: ColorConstant.milkColor,
            automaticallyImplyLeading: false,
          ),
          child: groupMerge.userAll.isolaUserMeta.joinedGroupList.first ==
                      'nothing' &&
                  groupMerge.userAll.isolaUserMeta.userIsSearching == false
              ? (Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("asset/img/chat_warning_icon.png"),
                      Text(
                        LocaleKeys.main_youdidntjoingroup.tr(),
                        style: const TextStyle(color: ColorConstant.softBlack),
                      ),
                    ],
                  ),
                ))
              : Container(
                  color: ColorConstant.themeGrey,
                  child: ListView.builder(
                      itemCount: groupMerge
                              .userAll.isolaUserMeta.userIsSearching
                          ?
                          //TRUE SEARCHING
                          (groupMerge.userAll.isolaUserMeta.joinedGroupList
                                      .first ==
                                  'nothing'
                              ? groupMerge
                                  .userAll.isolaUserMeta.joinedGroupList.length
                              : groupMerge.userAll.isolaUserMeta.joinedGroupList
                                      .length +
                                  1)
                          :
                          //FALSE SEARCHIONG
                          (groupMerge.userAll.isolaUserMeta.joinedGroupList
                                      .first ==
                                  'nothing'
                              ? 0
                              : groupMerge.userAll.isolaUserMeta.joinedGroupList
                                  .length),
                      itemBuilder: (context, indeks) {
                        if (groupMerge
                                .userAll.isolaUserMeta.joinedGroupList[0] ==
                            "nothing") {
                          if (groupMerge
                              .userAll.isolaUserMeta.userIsSearching) {
                            needSearchingContainer = true;
                          } else {
                            needSearchingContainer = false;
                          }
                        } else {
                          if (groupMerge
                              .userAll.isolaUserMeta.userIsSearching) {
                            needSearchingContainer = true;

                            //  groupMergeData.userAll.isolaUserMeta.joinedGroupList.length + 1;
                          } else {
                            needSearchingContainer = false;

                            //groupMergeData.userAll.isolaUserMeta.joinedGroupList.length;
                          }
                        }

                        var groupsItem = <Widget>[];

                        var itemWaiting = const ChatGroupContWaiting();
                        // ignore: unused_local_variable

                        for (var groupData
                            in groupMerge.groupsModel as List<GroupsModel>) {
                          if (groupData.groupChaosIsActive) {
                            final Stream<QuerySnapshot> _chaosStream =
                                FirebaseFirestore.instance
                                    .collection('chaos_groups_chat')
                                    .doc(groupData.groupChaosNo)
                                    .collection('chat_data')
                                    .snapshots();

                            var chaosCont = ChaosGroupCont(
                              myUid: groupMerge.userAll.isolaUserMeta.userUid,
                              chatGroupNo: groupData.groupChaosNo,
                              userAll: groupMerge.userAll,
                              groupMergeData: groupMerge,
                            );

                            groupsItem.add(chaosCont);
                          } else {
                            var groupCont = ChatGroupCont(
                              myUid: groupMerge.userAll.isolaUserMeta.userUid,
                              chatGroupNo: groupData.groupNo,
                              userAll: groupMerge.userAll,
                              groupMergeData: groupMerge,
                            );

                            groupsItem.add(groupCont);
                          }
                        }
                        if (groupMerge.userAll.isolaUserMeta.userIsSearching) {
                          needSearchingContainer = true;
                          groupsItem.add(itemWaiting);
                        } else {
                          needSearchingContainer = false;
                        }
                        /*if (needSearchingContainer == true) {
                          groupsItem.add(itemWaiting);
                        }*/

                        return Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [groupsItem[indeks]],
                          ),
                        );
                      }),
                ));
    });
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
