// ignore_for_file: prefer_typing_uninitialized_variables, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/blocs/chaos_group_setting_cubit.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_is_chaos_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/group/group_chat_message.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/groupchat/chatpage/chatpage.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class ChaosGroupCont extends StatelessWidget {
  const ChaosGroupCont(
      {Key? key,
      required this.myUid,
      required this.notiValue,
      required this.ref,
      required this.chatGroupNo,
      required this.userAll})
      : super(key: key);

  final String myUid;
  final int notiValue;
   final Stream<QuerySnapshot> ref;
  final String chatGroupNo;
  final IsolaUserAll userAll;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    /* StreamBuilder<dynamic>(
        stream: ref.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var groupDatasAll = <GroupChatMessage>[];

            var groupDatasFriend1 = <GroupChatMessage>[];
            var groupDatasFriend2 = <GroupChatMessage>[];

            var groupDatasFriend3 = <GroupChatMessage>[];
            var groupDatasFriend4 = <GroupChatMessage>[];
            var groupDatasFriend5 = <GroupChatMessage>[];

            var chatFriendName1;
            var chatFriendName2;

            var chatFriendName3;
            var chatFriendName4;
            var chatFriendName5;

            var chatFriendAvatarUrl1;
            var chatFriendAvatarUrl2;

            var chatFriendAvatarUrl3;
            var chatFriendAvatarUrl4;
            var chatFriendAvatarUrl5;

            var chatFriendUid1;
            var chatFriendUid2;

            var chatFriendUid3;
            var chatFriendUid4;
            var chatFriendUid5;

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

              if (comingInfo.member_uid != myUid) {
                //friend1
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
                //friend2
                if (comingInfo.member_uid != chatFriendUid1 &&
                    groupDatasFriend2.isEmpty) {
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
                if (comingInfo.member_uid == chatFriendUid2 &&
                    groupDatasFriend2.isNotEmpty) {
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

                //friend 3
                if (comingInfo.member_uid != chatFriendUid1 &&
                    comingInfo.member_uid != chatFriendUid2 &&
                    groupDatasFriend3.isEmpty) {
                  chatFriendUid3 = comingInfo.member_uid;
                  chatFriendAvatarUrl3 = comingInfo.member_avatar_url;
                  chatFriendName3 = comingInfo.member_name;
                  var groupFriend3 = GroupChatMessage(
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
                  groupDatasFriend3.add(groupFriend3);
                }
                if (comingInfo.member_uid == chatFriendUid3 &&
                    groupDatasFriend3.isNotEmpty) {
                  var groupFriend3 = GroupChatMessage(
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
                  groupDatasFriend3.add(groupFriend3);
                }

                //friend4
                if (comingInfo.member_uid != chatFriendUid1 &&
                    comingInfo.member_uid != chatFriendUid2 &&
                    comingInfo.member_uid != chatFriendUid3 &&
                    groupDatasFriend4.isEmpty) {
                  chatFriendUid4 = comingInfo.member_uid;
                  chatFriendAvatarUrl4 = comingInfo.member_avatar_url;
                  chatFriendName4 = comingInfo.member_name;
                  var groupFriend4 = GroupChatMessage(
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
                  groupDatasFriend4.add(groupFriend4);
                }
                if (comingInfo.member_uid == chatFriendUid4 &&
                    groupDatasFriend4.isNotEmpty) {
                  var groupFriend4 = GroupChatMessage(
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
                  groupDatasFriend4.add(groupFriend4);
                }

                //friend5
                if (comingInfo.member_uid != chatFriendUid1 &&
                    comingInfo.member_uid != chatFriendUid2 &&
                    comingInfo.member_uid != chatFriendUid3 &&
                    comingInfo.member_uid != chatFriendUid4 &&
                    groupDatasFriend5.isEmpty) {
                  chatFriendUid5 = comingInfo.member_uid;
                  chatFriendAvatarUrl5 = comingInfo.member_avatar_url;
                  chatFriendName5 = comingInfo.member_name;
                  var groupFriend5 = GroupChatMessage(
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
                  groupDatasFriend5.add(groupFriend5);
                }
                if (comingInfo.member_uid == chatFriendUid5 &&
                    groupDatasFriend5.isNotEmpty) {
                  var groupFriend5 = GroupChatMessage(
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
                  groupDatasFriend5.add(groupFriend5);
                }
              }
            });

            groupDatasAll.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend1.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend2.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend3.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend4.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));
            groupDatasFriend5.sort((b, a) =>
                a.member_message_time.compareTo(b.member_message_time));

            var chaosGroupSetting = ChaosGroupSettingModel(
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
                userUid: userAll.isolaUserMeta.userUid,
                groupMemberName4: groupDatasFriend3.first.member_name,
                groupMemberAvatarUrl4:
                    groupDatasFriend3.first.member_avatar_url,
                groupMemberUid4: groupDatasFriend3.first.member_uid,
                groupMemberName5: groupDatasFriend4.first.member_name,
                groupMemberAvatarUrl5:
                    groupDatasFriend4.first.member_avatar_url,
                groupMemberUid5: groupDatasFriend4.first.member_uid,
                groupMemberName6: groupDatasFriend5.first.member_name,
                groupMemberAvatarUrl6:
                    groupDatasFriend5.first.member_avatar_url,
                groupMemberUid6: groupDatasFriend5.first.member_uid);

            context
                .read<ChaosGroupSettingCubit>()
                .chaosGroupSettingChanger(chaosGroupSetting);
            chatFriendName1 = groupDatasFriend1.first.member_name;
            chatFriendName2 = groupDatasFriend2.first.member_name;
            chatFriendName3 = groupDatasFriend3.first.member_name;
            chatFriendName4 = groupDatasFriend4.first.member_name;
            chatFriendName5 = groupDatasFriend5.first.member_name;
            chatFriendAvatarUrl1 = groupDatasFriend1.first.member_avatar_url;
            chatFriendAvatarUrl2 = groupDatasFriend2.first.member_avatar_url;
            chatFriendAvatarUrl3 = groupDatasFriend2.first.member_avatar_url;
            chatFriendAvatarUrl4 = groupDatasFriend2.first.member_avatar_url;
            chatFriendAvatarUrl5 = groupDatasFriend2.first.member_avatar_url;
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
                  child: ChaosChatGroupCard(
                    chatPicFirst: Image.network(
                      chatFriendAvatarUrl1,
                      fit: BoxFit.contain,
                    ),
                    chatPicSecond: Image.network(
                      chatFriendAvatarUrl2,
                      fit: BoxFit.cover,
                    ),
                    chatBoxText: chatLastMessage.length > 35
                        ? ("${chatLastMessage.toString().substring(0, 35)}...")
                        : chatLastMessage,
                    notiValue: notiValue,
                    chatBoxName:
                        "${chatFriendName1.toString().substring(0, 5)} & ${chatFriendName2.toString().substring(0, 5)} & ${chatFriendName3.toString().substring(0, 5)}& ${chatFriendName4.toString().substring(0, 5)}& ${chatFriendName5.toString().substring(0, 5)}",
                    isLocked: false,
                    chatGroupNo: chatGroupNo,
                    isImage: isImage,
                    isVideo: isVideo,
                    isDoc: isDoc,
                    chatPicForth: chatFriendAvatarUrl4,
                    chatPicThird: chatFriendAvatarUrl3,
                    chatPicFifth: chatFriendAvatarUrl5,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(animating: true, radius: 12.sp),
            );
          }
        });
 */
  }
}

class ChaosChatGroupCard extends StatelessWidget {
  const ChaosChatGroupCard(
      {Key? key,
      required this.chatPicFirst,
      required this.chatPicSecond,
      required this.chatPicThird,
      required this.chatPicForth,
      required this.chatPicFifth,
      required this.chatBoxText,
      required this.chatBoxName,
      required this.notiValue,
      required this.isLocked,
      required this.chatGroupNo,
      required this.isImage,
      required this.isVideo,
      required this.isDoc})
      : super(key: key);

  final Widget chatPicFirst;
  final Widget chatPicSecond;
  final Widget chatPicThird;
  final Widget chatPicForth;
  final Widget chatPicFifth;

  final String chatBoxText;
  final String chatBoxName;
  final int notiValue;
  final bool isLocked;
  final String chatGroupNo;
  final bool isImage;
  final bool isVideo;
  final bool isDoc;

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
          //buraya if konacak
          context.read<ChatReferenceCubit>().chatChaosGroupChanger(chatGroupNo);

          context.read<ChatIsChaosCubit>().chatIsChaosTrue();
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
                  leftPadding: 0,
                ),
                ImageChatClip(
                  imageItem: chatPicSecond,
                  leftPadding: 8,
                ),
                ImageChatClip(
                  imageItem: chatPicThird,
                  leftPadding: 8,
                ),
                ImageChatClip(
                  imageItem: chatPicForth,
                  leftPadding: 8,
                ),
                ImageChatClip(
                  imageItem: chatPicFifth,
                  leftPadding: 8,
                ),
                notiValue == 19999
                    ? const SizedBox()
                    : MessageNotificationMini(
                        notiValue: notiValue, leftPadding: 17),
                Padding(
                  padding: EdgeInsets.fromLTRB(26.w, 1.h, 2, 1.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ChatTextsLeft(
                        targetName: chatBoxName,
                        context: context,
                        targetText: chatBoxText == ""
                            ? (isImage == true
                                ? "Image Mesage"
                                : isVideo == true
                                    ? "Video Message"
                                    : isDoc == true
                                        ? "Document Message"
                                        : chatBoxText)
                            : chatBoxText,
                        rowLetterValue: 50,
                        letterTextStyle: 100.h >= 1100
                            ? StyleConstants.groupTabletCardTextStyle
                            : StyleConstants.groupCardTextStyle,
                        heightValue: 100.h <= 1100 ? 1.5 : 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
