// ignore_for_file: prefer_typing_uninitialized_variables, implementation_imports, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/blocs/chaos_group_setting_cubit.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_is_chaos_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../blocs/chaos_chat_message_target.dart';
import '../../../../extensions/locale_keys.dart';
import '../../../../model/chaos/chaos_chat_message.dart';
import '../../../../model/chaos/chaos_group_setting_model.dart';
import '../../../../model/group/group_preview_data.dart';

class ChaosGroupCont extends StatelessWidget {
  const ChaosGroupCont(
      {Key? key,
      required this.myUid,
      required this.chatGroupNo,
      required this.userAll,
      required this.groupMergeData})
      : super(key: key);

  final String myUid;
  final String chatGroupNo;
  final IsolaUserAll userAll;
  final GroupMergeData groupMergeData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chaos_groups_chat')
            .doc(chatGroupNo)
            .collection('chat_data')
            .orderBy('member_message_time', descending: true)
            .withConverter<ChaosChatMessage>(
              fromFirestore: (snapshot, _) =>
                  ChaosChatMessage.fromJson(snapshot.data()!),
              toFirestore: (message, _) => message.toJson(),
            )
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            var groupDatasFriend1 = <ChaosChatMessage>[];
            var groupDatasFriend2 = <ChaosChatMessage>[];
            var groupDatasFriend3 = <ChaosChatMessage>[];
            var groupDatasFriend4 = <ChaosChatMessage>[];
            var groupDatasFriend5 = <ChaosChatMessage>[];

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
                  var groupFriend1 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend1.add(groupFriend1);
                }
                if (groupDatasFriend1.isEmpty) {
                  chatFriendUid1 = comingInfo["member_uid"];
                  chatFriendName1 = comingInfo["member_name"];
                  chatFriendAvatarUrl1 = comingInfo["member_avatar_url"];
                  var groupFriend1 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend1.add(groupFriend1);
                }

                if (comingInfo["member_uid"] == chatFriendUid2 &&
                    groupDatasFriend2.isNotEmpty) {
                  var groupFriend2 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend2.add(groupFriend2);
                }
                if (groupDatasFriend2.isEmpty &&
                    comingInfo["member_uid"] != chatFriendUid1) {
                  chatFriendUid2 = comingInfo["member_uid"];
                  chatFriendName2 = comingInfo["member_name"];
                  chatFriendAvatarUrl2 = comingInfo["member_avatar_url"];
                  var groupFriend2 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend2.add(groupFriend2);
                }

                if (comingInfo["member_uid"] == chatFriendUid3 &&
                    groupDatasFriend3.isNotEmpty) {
                  var groupFriend3 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend3.add(groupFriend3);
                }
                if (groupDatasFriend3.isEmpty &&
                    comingInfo["member_uid"] != chatFriendUid1 &&
                    comingInfo["member_uid"] != chatFriendUid2) {
                  chatFriendUid3 = comingInfo["member_uid"];
                  chatFriendName3 = comingInfo["member_name"];
                  chatFriendAvatarUrl3 = comingInfo["member_avatar_url"];
                  var groupFriend3 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend3.add(groupFriend3);
                }

                if (comingInfo["member_uid"] == chatFriendUid4 &&
                    groupDatasFriend4.isNotEmpty) {
                  var groupFriend4 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend4.add(groupFriend4);
                }
                if (groupDatasFriend4.isEmpty &&
                    comingInfo["member_uid"] != chatFriendUid1 &&
                    comingInfo["member_uid"] != chatFriendUid2 &&
                    comingInfo["member_uid"] != chatFriendUid3) {
                  chatFriendUid4 = comingInfo["member_uid"];
                  chatFriendName4 = comingInfo["member_name"];
                  chatFriendAvatarUrl4 = comingInfo["member_avatar_url"];
                  var groupFriend4 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend4.add(groupFriend4);
                }

                if (comingInfo["member_uid"] == chatFriendUid5 &&
                    groupDatasFriend5.isNotEmpty) {
                  var groupFriend5 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend5.add(groupFriend5);
                }
                if (groupDatasFriend5.isEmpty &&
                    comingInfo["member_uid"] != chatFriendUid1 &&
                    comingInfo["member_uid"] != chatFriendUid2 &&
                    comingInfo["member_uid"] != chatFriendUid3 &&
                    comingInfo["member_uid"] != chatFriendUid4) {
                  chatFriendUid5 = comingInfo["member_uid"];
                  chatFriendName5 = comingInfo["member_name"];
                  chatFriendAvatarUrl5 = comingInfo["member_avatar_url"];
                  var groupFriend5 = ChaosChatMessage(
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
                    comingInfo["member_message_target_3_uid"],
                    comingInfo["member_message_target_4_uid"],
                    comingInfo["member_message_target_5_uid"],
                    comingInfo["member_message_no"],
                  );
                  groupDatasFriend5.add(groupFriend5);
                }
              }
            }
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

            var groupSetting = ChaosGroupSettingModel(
                groupMemberAvatarUrl1: userAll.isolaUserDisplay.avatarUrl,
                groupMemberAvatarUrl2:
                    groupDatasFriend1.first.member_avatar_url,
                groupMemberAvatarUrl3:
                    groupDatasFriend2.first.member_avatar_url,
                groupMemberAvatarUrl4:
                    groupDatasFriend3.first.member_avatar_url,
                groupMemberAvatarUrl5:
                    groupDatasFriend4.first.member_avatar_url,
                groupMemberAvatarUrl6:
                    groupDatasFriend5.first.member_avatar_url,
                groupMemberName1: userAll.isolaUserDisplay.userName,
                groupMemberName2: groupDatasFriend1.first.member_name,
                groupMemberName3: groupDatasFriend2.first.member_name,
                groupMemberName4: groupDatasFriend3.first.member_name,
                groupMemberName5: groupDatasFriend4.first.member_name,
                groupMemberName6: groupDatasFriend5.first.member_name,
                groupMemberUid2: groupDatasFriend1.first.member_uid,
                groupMemberUid3: groupDatasFriend2.first.member_uid,
                groupMemberUid4: groupDatasFriend3.first.member_uid,
                groupMemberUid5: groupDatasFriend4.first.member_uid,
                groupMemberUid6: groupDatasFriend5.first.member_uid,
                groupNo: chatGroupNo,
                userUid: userAll.isolaUserMeta.userUid);

            DocumentSnapshot ds = snapshots.data!.docs[0];
            var chatLastMessage = ds["member_message"];
            var isImage = ds["member_message_isimage"];
            var isVideo = ds["member_message_isvideo"];
            var isDoc = ds["member_message_isdocument"];
            var isVoice = ds["member_message_isvoice"];

            chatFriendName1 = groupDatasFriend1.first.member_name;
            chatFriendName2 = groupDatasFriend2.first.member_name;
            chatFriendName3 = groupDatasFriend3.first.member_name;
            chatFriendName4 = groupDatasFriend4.first.member_name;
            chatFriendName5 = groupDatasFriend5.first.member_name;
            chatFriendAvatarUrl1 = groupDatasFriend1.first.member_avatar_url;
            chatFriendAvatarUrl2 = groupDatasFriend2.first.member_avatar_url;
            chatFriendAvatarUrl3 = groupDatasFriend3.first.member_avatar_url;
            chatFriendAvatarUrl4 = groupDatasFriend4.first.member_avatar_url;
            chatFriendAvatarUrl5 = groupDatasFriend5.first.member_avatar_url;
            chatLastMessage = chatLastMessage;
            isImage = isImage;
            isVideo = isVideo;
            isDoc = isDoc;

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
                    child: ChaosChatGroupCard(
                      chatPicMe: CachedNetworkImage(
                        imageUrl: userAll.isolaUserDisplay.avatarUrl,
                        errorWidget: (context, url, error) =>
                            const Icon(CupertinoIcons.xmark_square),
                      ),
                      chatPicFirst: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl1,
                        errorWidget: (context, url, error) =>
                            const Icon(CupertinoIcons.xmark_square),
                      ),
                      chatPicSecond: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl2,
                        cacheManager: CacheManager(Config(
                          "cachedImageFiles",
                          stalePeriod: const Duration(days: 3),
                          //one week cache period
                        )),
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
                      chatPicThird: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl3,
                        cacheManager: CacheManager(Config(
                          "cachedImageFiles",
                          stalePeriod: const Duration(days: 3),
                          //one week cache period
                        )),
                      ),
                      chatPicForth: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl4,
                        cacheManager: CacheManager(Config(
                          "cachedImageFiles",
                          stalePeriod: const Duration(days: 3),
                          //one week cache period
                        )),
                      ),
                      chatPicFifth: CachedNetworkImage(
                        imageUrl: chatFriendAvatarUrl5,
                        cacheManager: CacheManager(Config(
                          "cachedImageFiles",
                          stalePeriod: const Duration(days: 3),
                          //one week cache period
                        )),
                      ),
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
        });
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
      required this.isVoice,
      required this.isDoc,
      required this.groupSettingModel,
      required this.chatPicMe})
      : super(key: key);
  final Widget chatPicMe;
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
  final bool isVoice;
  final bool isDoc;
  final ChaosGroupSettingModel groupSettingModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLocked == true) {
          showCupertinoDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    content:  Text(LocaleKeys.main_youhavetowait.tr()),
                    actions: [
                      CupertinoButton(
                          child:  Text(LocaleKeys.main_okay.tr()),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ));
        } else {
          context
              .read<ChatReferenceCubit>()
              .chatChaosGroupChanger(chatGroupNo, true);

          context.read<ChatIsChaosCubit>().chatIsChaosTrue();

          context
              .read<ChaosGroupSettingCubit>()
              .chaosGroupSettingChanger(groupSettingModel);

          String target1 = groupSettingModel.groupMemberUid2;
          String target2 = groupSettingModel.groupMemberUid3;
          String target3 = groupSettingModel.groupMemberUid4;
          String target4 = groupSettingModel.groupMemberUid5;
          String target5 = groupSettingModel.groupMemberUid6;
          String myUid = groupSettingModel.userUid;

          context
              .read<ChaosChatMessageTargetsCubit>()
              .chatMessageTargetsChanger(
                  meUid: myUid,
                  target1: target1,
                  target2: target2,
                  target3: target3,
                  target4: target4,
                  target5: target5);

          Navigator.of(context, rootNavigator: true)
              .pushNamed(chaosChatInteriorPage);
        }
      },
      child: Card(
        elevation: 0.0,
        color: ColorConstant.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageChatChaosClip(imageItem: chatPicMe, leftPadding: 0),
            ImageChatChaosClip(
              imageItem: chatPicFirst,
              leftPadding: 0,
            ),
            ImageChatChaosClip(
              imageItem: chatPicSecond,
              leftPadding: 0,
            ),
            ChatTextsChaos(
                targetName: 'CHAOS',
                context: context,
                targetText: 'X',
                rowLetterValue: 50,
                letterTextStyle: 100.h >= 1100
                    ? StyleConstants.groupTabletCardTextStyle
                    : StyleConstants.groupCardTextStyle,
                heightValue: 100.h <= 1100 ? 1.5 : 1),
            ImageChatChaosClip(
              imageItem: chatPicThird,
              leftPadding: 0,
            ),
            ImageChatChaosClip(
              imageItem: chatPicForth,
              leftPadding: 0,
            ),
            ImageChatChaosClip(
              imageItem: chatPicFifth,
              leftPadding: 0,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
// ignore: must_be_immutable
class ChatTextsChaos extends StatelessWidget {
  String targetName;
  String targetText;
  int rowLetterValue;
  TextStyle letterTextStyle;
  double heightValue;
  ChatTextsChaos(
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
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
          child: Text(
            targetName,
            style: 100.h >= 1100
                ? StyleConstants.softDarkTabletTextStyle
                : StyleConstants.softDarkTextStyle,
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(24.0, 2.h, 0, 3.5.h),
            child: Center(
                child: Text(
              'X',
              style: TextStyle(fontSize: 15.sp),
            ))),
      ],
    );
  }
}

class ImageChatChaosClip extends StatelessWidget {
  final Widget imageItem;
  final int leftPadding;

  const ImageChatChaosClip(
      {Key? key, required this.imageItem, required this.leftPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
