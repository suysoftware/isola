// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, implementation_imports

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/blocs/chaos_group_setting_cubit.dart';
import 'package:isola_app/src/blocs/chat_message_targets_cubit.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_is_chaos_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/group/group_chat_message.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chatpage.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/hive_models/user_hive.dart';

class ChatGroupCont extends StatelessWidget {
  const ChatGroupCont(
      {Key? key,
      required this.myUid,

      // required this.ref,
      required this.chatGroupNo,
      required this.userAll,
      required this.groupMergeData})
      : super(key: key);

  final String myUid;

  //final Stream<QuerySnapshot> ref;
  final String chatGroupNo;
  final IsolaUserAll userAll;
  final GroupMergeData groupMergeData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups_chat')
            .doc(chatGroupNo)
            .collection('chat_data')
            .orderBy('member_message_time', descending: true)
            .withConverter<GroupChatMessage>(
              fromFirestore: (snapshot, _) =>
                  GroupChatMessage.fromJson(snapshot.data()!),
              toFirestore: (message, _) => message.toJson(),
            )
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            //   var groupDatasAll = <GroupChatMessage>[];
            var groupDatasFriend1 = <GroupChatMessage>[];
            var groupDatasFriend2 = <GroupChatMessage>[];
            var chatFriendName1;
            var chatFriendName2;

            var chatFriendAvatarUrl1;
            var chatFriendAvatarUrl2;
            var chatFriendUid1;
            var chatFriendUid2;

            int notiValue = 0;

            for (var comingInfo in snapshots.data!.docs) {
              if (groupMergeData.exploreData
                      .contains(comingInfo["member_message_no"]) ==
                  false) {
                notiValue = notiValue + 1;
              }

              if (comingInfo["member_uid"] != myUid &&
                  comingInfo["member_name"] != "System Message") {
                if (comingInfo["member_uid"] == chatFriendUid1 &&
                    groupDatasFriend1.isNotEmpty) {
                  var groupFriend1 = GroupChatMessage(
                    comingInfo["member_avatar_url"],
                    comingInfo["member_message"],
                    comingInfo["member_message_time"],
                    comingInfo["member_name"],
                    comingInfo["member_uid"],
                    comingInfo["member_message_isvoice"],
                    comingInfo["member_message_voice_url"],
                    comingInfo["member_message_isattachment"],
                    comingInfo["member_message_attachment_url"],
                    comingInfo["member_message_isimage"],
                    comingInfo["member_message_isvideo"],
                    comingInfo["member_message_isdocument"],
                    comingInfo["member_message_target_1_uid"],
                    comingInfo["member_message_target_2_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend1.add(groupFriend1);
                }
                if (groupDatasFriend1.isEmpty) {
                  chatFriendUid1 = comingInfo["member_uid"];
                  chatFriendName1 = comingInfo["member_name"];
                  chatFriendAvatarUrl1 = comingInfo["member_avatar_url"];
                  var groupFriend1 = GroupChatMessage(
                    comingInfo["member_avatar_url"],
                    comingInfo["member_message"],
                    comingInfo["member_message_time"],
                    comingInfo["member_name"],
                    comingInfo["member_uid"],
                    comingInfo["member_message_isvoice"],
                    comingInfo["member_message_voice_url"],
                    comingInfo["member_message_isattachment"],
                    comingInfo["member_message_attachment_url"],
                    comingInfo["member_message_isimage"],
                    comingInfo["member_message_isvideo"],
                    comingInfo["member_message_isdocument"],
                    comingInfo["member_message_target_1_uid"],
                    comingInfo["member_message_target_2_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend1.add(groupFriend1);
                }

                if (comingInfo["member_uid"] != chatFriendUid1) {
                  chatFriendUid2 = comingInfo["member_uid"];
                  chatFriendAvatarUrl2 = comingInfo["member_avatar_url"];
                  chatFriendName2 = comingInfo["member_name"];
                  var groupFriend2 = GroupChatMessage(
                    comingInfo["member_avatar_url"],
                    comingInfo["member_message"],
                    comingInfo["member_message_time"],
                    comingInfo["member_name"],
                    comingInfo["member_uid"],
                    comingInfo["member_message_isvoice"],
                    comingInfo["member_message_voice_url"],
                    comingInfo["member_message_isattachment"],
                    comingInfo["member_message_attachment_url"],
                    comingInfo["member_message_isimage"],
                    comingInfo["member_message_isvideo"],
                    comingInfo["member_message_isdocument"],
                    comingInfo["member_message_target_1_uid"],
                    comingInfo["member_message_target_2_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend2.add(groupFriend2);
                }
              }
            }
            groupDatasFriend1.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend2.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));

            var groupSetting = GroupSettingModel(
                groupMemberAvatarUrl1: userAll.isolaUserDisplay.avatarUrl,
                groupMemberAvatarUrl2:
                    groupDatasFriend1.first.member_avatar_url,
                groupMemberAvatarUrl3:
                    groupDatasFriend2.first.member_avatar_url,
                groupMemberName1: userAll.isolaUserDisplay.userName,
                groupMemberName2: groupDatasFriend1.first.member_name,
                groupMemberName3: groupDatasFriend2.first.member_name,
                groupMemberUid2: groupDatasFriend1.first.member_uid,
                groupMemberUid3: groupDatasFriend2.first.member_uid,
                groupNo: chatGroupNo,
                userUid: userAll.isolaUserMeta.userUid);

            DocumentSnapshot ds = snapshots.data!.docs[0];
            var chatLastMessage = ds["member_message"];
            var isImage = ds["member_message_isimage"];
            var isVideo = ds["member_message_isvideo"];
            var isDoc = ds["member_message_isdocument"];
            var isVoice = ds["member_message_isvoice"];

            //      context.read<GroupSettingCubit>().groupSettingChanger(groupSetting);
            chatFriendName1 = groupDatasFriend1.first.member_name;
            chatFriendName2 = groupDatasFriend2.first.member_name;
            chatFriendAvatarUrl1 = groupDatasFriend1.first.member_avatar_url;
            chatFriendAvatarUrl2 = groupDatasFriend2.first.member_avatar_url;
            chatLastMessage = chatLastMessage;
            isImage = isImage;
            isVideo = isVideo;
            isDoc = isDoc;
            //   var chatLastMessage = "";
/*
            var isImage = false;
            var isVideo = false;
            var isDoc = false;
            var isVoice = false;*/

            return Container(
              decoration: BoxDecoration(
                  gradient: ColorConstant.isolaMainGradient,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                      color: ColorConstant.milkColor,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: ChatGroupCard(
                      chatPicFirst: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl1,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Icon(CupertinoIcons.xmark_square),
                      ),
                      chatPicSecond: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl2,
                        fit: BoxFit.cover,
                      ),
                      chatBoxText: chatLastMessage,
                      notiValue: notiValue,
                      chatBoxName:
                          "${chatFriendName1.toString().substring(0, 6)} & ${chatFriendName2.toString().substring(0, 6)}",
                      isLocked: false,
                      chatGroupNo: chatGroupNo,
                      isImage: isImage,
                      isVideo: isVideo,
                      isDoc: isDoc,
                      isVoice: isVoice,
                      groupSettingModel: groupSetting,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(animating: true, radius: 12.sp),
            );
          }
/*
            var comingMessage = GroupChatMessage(
              items2['member_avatar_url'],
              items2["member_message"],
              items2["member_message_time"],
              items2["member_name"],
              items2["member_uid"],
              items2["member_message_isvoice"],
              items2["member_message_voice_url"],
              items2["member_message_isattachment"],
              items2["member_message_attachment_url"],
              items2["member_message_isimage"],
              items2["member_message_isvideo"],
              items2["member_message_isdocument"],
              items2["member_message_target_1_uid"],
              items2["member_message_target_2_uid"],
            );
            groupDatasAll.add(comingInfo);
            var chatFriendName1;
            var chatFriendName2;
            var chatFriendAvatarUrl1;
            var chatFriendAvatarUrl2;
            var chatFriendUid1;
            var chatFriendUid2;
            var chatLastMessage;
            var isImage;
            var isVideo;
            var isDoc;

            var gettingChatInfo = event.data.snapshot.value as Map;
            gettingChatInfo.forEach((key, value) {
              var comingInfo = GroupChatMessage.fromJson(value);
              var groupChatItem = GroupChatMessage(
                  comingInfo.member_avatar_url,
                  comingInfo.member_message,
                  comingInfo.member_message_time,
                  comingInfo.member_name,
                  comingInfo.member_uid,
                  comingInfo.member_message_isVoice,
                  comingInfo.member_message_voice_url,
                  comingInfo.member_message_isAttachment,
                  comingInfo.member_message_attachment_url,
                  comingInfo.member_message_isImage,
                  comingInfo.member_message_isVideo,
                  comingInfo.member_message_isDocument,
                  comingInfo.message_target_1_uid,
                  comingInfo.message_target_2_uid);
              groupDatasAll.add(groupChatItem);

              //groupDatasAll.sort((b, a) =>
              //  a.member_message_time.compareTo(b.member_message_time));

              if (comingInfo.member_uid != myUid&&comingInfo.member_name!="System Message") {
                if (comingInfo.member_uid == chatFriendUid1 &&
                    groupDatasFriend1.isNotEmpty) {
                  var groupFriend1 = GroupChatMessage(
                      comingInfo.member_avatar_url,
                      comingInfo.member_message,
                      comingInfo.member_message_time,
                      comingInfo.member_name,
                      comingInfo.member_uid,
                      comingInfo.member_message_isVoice,
                      comingInfo.member_message_voice_url,
                      comingInfo.member_message_isAttachment,
                      comingInfo.member_message_attachment_url,
                      comingInfo.member_message_isImage,
                      comingInfo.member_message_isVideo,
                      comingInfo.member_message_isDocument,
                      comingInfo.message_target_1_uid,
                      comingInfo.message_target_2_uid);
                  groupDatasFriend1.add(groupFriend1);
                }
                if (groupDatasFriend1.isEmpty) {
                  chatFriendUid1 = comingInfo.member_uid;
                  chatFriendName1 = comingInfo.member_name;
                  chatFriendAvatarUrl1 = comingInfo.member_avatar_url;
                  var groupFriend1 = GroupChatMessage(
                      comingInfo.member_avatar_url,
                      comingInfo.member_message,
                      comingInfo.member_message_time,
                      comingInfo.member_name,
                      comingInfo.member_uid,
                      comingInfo.member_message_isVoice,
                      comingInfo.member_message_voice_url,
                      comingInfo.member_message_isAttachment,
                      comingInfo.member_message_attachment_url,
                      comingInfo.member_message_isImage,
                      comingInfo.member_message_isVideo,
                      comingInfo.member_message_isDocument,
                      comingInfo.message_target_1_uid,
                      comingInfo.message_target_2_uid);
                  groupDatasFriend1.add(groupFriend1);
                }

                if (comingInfo.member_uid != chatFriendUid1) {
                  chatFriendUid2 = comingInfo.member_uid;
                  chatFriendAvatarUrl2 = comingInfo.member_avatar_url;
                  chatFriendName2 = comingInfo.member_name;
                  var groupFriend2 = GroupChatMessage(
                      comingInfo.member_avatar_url,
                      comingInfo.member_message,
                      comingInfo.member_message_time,
                      comingInfo.member_name,
                      comingInfo.member_uid,
                      comingInfo.member_message_isVoice,
                      comingInfo.member_message_voice_url,
                      comingInfo.member_message_isAttachment,
                      comingInfo.member_message_attachment_url,
                      comingInfo.member_message_isImage,
                      comingInfo.member_message_isVideo,
                      comingInfo.member_message_isDocument,
                      comingInfo.message_target_1_uid,
                      comingInfo.message_target_2_uid);
                  groupDatasFriend2.add(groupFriend2);
                }
              }
            });

            groupDatasAll.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend1.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend2.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));

            var groupSetting = GroupSettingModel(
                groupMemberAvatarUrl1: userAll.isolaUserDisplay.avatarUrl,
                groupMemberAvatarUrl2:
                    groupDatasFriend1.first.member_avatar_url,
                groupMemberAvatarUrl3:
                    groupDatasFriend2.first.member_avatar_url,
                groupMemberName1: userAll.isolaUserDisplay.userName,
                groupMemberName2: groupDatasFriend1.first.member_name,
                groupMemberName3: groupDatasFriend2.first.member_name,
                groupMemberUid2: groupDatasFriend1.first.member_uid,
                groupMemberUid3: groupDatasFriend2.first.member_uid,
                groupNo: chatGroupNo,
                userUid: userAll.isolaUserMeta.userUid);

            context.read<GroupSettingCubit>().groupSettingChanger(groupSetting);
            chatFriendName1 = groupDatasFriend1.first.member_name;
            chatFriendName2 = groupDatasFriend2.first.member_name;
            chatFriendAvatarUrl1 = groupDatasFriend1.first.member_avatar_url;
            chatFriendAvatarUrl2 = groupDatasFriend2.first.member_avatar_url;
            chatLastMessage = groupDatasAll.first.member_message;
            isImage = groupDatasAll.first.member_message_isImage;
            isVideo = groupDatasAll.first.member_message_isVideo;
            isDoc = groupDatasAll.first.member_message_isDocument;
            return Container(
              decoration: BoxDecoration(
                  gradient: ColorConstant.isolaMainGradient,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: Container(
         
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                      color: ColorConstant.milkColor,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: ChatGroupCard(
                      chatPicFirst: CachedNetworkImage(
                        chatFriendAvatarUrl1,
                        fit: BoxFit.cover,
                      
                      ),
                      chatPicSecond: CachedNetworkImage(
                        chatFriendAvatarUrl2,
                        fit: BoxFit.cover,
                      ),
                      chatBoxText: groupDatasAll.first.message_target_1_uid !=
                              "firstmessage"
                          ? chatLastMessage.length > 35
                              ? ("${chatLastMessage.toString().substring(0, 34)}...")
                              : chatLastMessage
                          : "",
                      notiValue: notiValue,
                      chatBoxName:
                          "${chatFriendName1.toString().substring(0, 6)} & ${chatFriendName2.toString().substring(0, 6)}",
                      isLocked: false,
                      chatGroupNo: chatGroupNo,
                      isImage: isImage,
                      isVideo: isVideo,
                      isDoc: isDoc,
                    ),
                  ),
                ),
              ),
            );


          } else {
            return Center(
              child: CupertinoActivityIndicator(animating: true, radius: 12.sp),
            );
          }
          */
        });
  }
}

class ChatGroupCard extends StatelessWidget {
  const ChatGroupCard(
      {Key? key,
      required this.chatPicFirst,
      required this.chatPicSecond,
      required this.chatBoxText,
      required this.chatBoxName,
      required this.notiValue,
      required this.isLocked,
      required this.chatGroupNo,
      required this.isImage,
      required this.isVideo,
      required this.isDoc,
      required this.isVoice,
      required this.groupSettingModel})
      : super(key: key);

  final Widget chatPicFirst;
  final Widget chatPicSecond;

  final String chatBoxText;
  final String chatBoxName;
  final int notiValue;
  final bool isLocked;
  final String chatGroupNo;
  final bool isImage;
  final bool isVideo;
  final bool isDoc;
  final bool isVoice;
  final GroupSettingModel groupSettingModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLocked == true) {
          showCupertinoDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    content: const Text("You have to wait"),
                    actions: [
                      CupertinoButton(
                          child: const Text("Okey"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ));
        } else {
          String meUid = context.read<GroupSettingCubit>().state.userUid;

          String target1 =
              context.read<GroupSettingCubit>().state.groupMemberUid2;
          String target2 =
              context.read<GroupSettingCubit>().state.groupMemberUid3;
          //buraya if konacak
          context.read<ChatReferenceCubit>().chatGroupChanger(chatGroupNo);

          context
              .read<GroupSettingCubit>()
              .groupSettingChanger(groupSettingModel);
          context.read<ChatMessageTargetsCubit>().chatMessageTargetsChanger(
              meUid: meUid, target1: target1, target2: target2);

          context.read<ChatIsChaosCubit>().chatIsChaosFalse();

          Navigator.of(context, rootNavigator: true)
              .pushNamed(chatInteriorPage);
        }
      },
      child: Card(
        elevation: 0.0,
        color: ColorConstant.transparentColor,
        child: Row(
          children: [
            Stack(
              children: [
                ImageChatClip(
                  imageItem: chatPicFirst,
                  leftPadding: 2,
                ),
                ImageChatClip(
                  imageItem: chatPicSecond,
                  leftPadding: 8,
                ),
                notiValue == 19999
                    ? const SizedBox()
                    : MessageNotificationMini(
                        notiValue: notiValue, leftPadding: 17),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 1.3.h, 2, 0.h),
                  child: ChatTextsLeft(
                      targetName: chatBoxName,
                      context: context,
                      targetText:
                          chatBoxText.contains("Leave From Chat") != true
                              ? (chatBoxText == ""
                                  ? (isImage == true
                                      ? "Image Mesage"
                                      : isVideo == true
                                          ? "Video Message"
                                          : isDoc == true
                                              ? "Document Message"
                                              : isVoice == true
                                                  ? "Voice Message"
                                                  : chatBoxText)
                                  : chatBoxText)
                              : "",
                      rowLetterValue: 40,
                      letterTextStyle: 100.h >= 1100
                          ? StyleConstants.groupTabletCardTextStyle
                          : StyleConstants.groupCardTextStyle,
                      heightValue: 100.h <= 1100 ? 1.0 : 1.0),
                ),
                SizedBox(
                  width: 23.w,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: 100.h >= 700
                        ? (100.h >= 1100
                            ? const Text(
                                "_________________________________________________________________________________________________________________",
                                style: TextStyle(
                                    color: ColorConstant.transparentColor),
                              )
                            : const Text(
                                "_________________________________________",
                                style: TextStyle(
                                    color: ColorConstant.transparentColor),
                              ))
                        : const Text(
                            "________________________________________",
                            style: TextStyle(
                                color: ColorConstant.transparentColor),
                          )),
                Positioned(
                  top: -12.0,
                  right: -16.0,
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
                          builder: (context) => CupertinoAlertDialog(
                                content: const Text("dasdadsadsa"),
                                actions: [
                                  CupertinoButton(
                                      child: const Text(
                                        "Report Group",
                                        style: TextStyle(
                                            color: CupertinoColors.systemRed),
                                      ),
                                      onPressed: () {}),
                                  CupertinoButton(
                                      child: const Text("Back"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              ))),
                ),
                /*
                Positioned(
                  top: -7.0,
                  right: 2.0,
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
                          builder: (context) => CupertinoAlertDialog(
                                content: const Text("dasdadsadsa"),
                                actions: [
                                  CupertinoButton(
                                      child: const Text(
                                        "Leave Group",
                                        style: TextStyle(
                                            color:
                                                CupertinoColors.systemRed),
                                      ),
                                      onPressed: () {}),
                                  CupertinoButton(
                                      child: const Text("Back"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              ))),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
