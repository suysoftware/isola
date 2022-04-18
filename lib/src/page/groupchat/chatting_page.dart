// ignore_for_file: unused_local_variable, avoid_init_to_null, avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/current_chat_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/group/group_chat_message.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/attachment_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/attachment_message_baloon_right.dart';
import 'package:isola_app/src/page/groupchat/chat_image_picker.dart';
import 'package:isola_app/src/page/groupchat/system_message_balloon/system_message_balloon.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_message_balloon_right.dart';
import 'package:isola_app/src/page/groupchat/voice_message_balloon/voice_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/voice_message_balloon/voice_message_balloon_right.dart';
import 'package:isola_app/src/service/firebase/storage/explore_history.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_attachment_message.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_chaos_apply.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_voice_message.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../constants/style_constants.dart';
import '../../extensions/locale_keys.dart';

class ChatInteriorPage extends StatefulWidget {
  const ChatInteriorPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChatInteriorPageState createState() => _ChatInteriorPageState();
}

class _ChatInteriorPageState extends State<ChatInteriorPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController t1 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late String target1;
  late String target2;
  late bool isChaosSearching;

  late String _filePath;
  late AudioPlayer _audioPlayer;

  late FlutterAudioRecorder2 _audioRecorder;

  late GroupSettingModel groupSettingModelForTrawling;
  late int itemCountValue;
  late User user;
  late CollectionReference refChatInterior;
  late IsolaUserAll userAll;

//chaos button
  late AnimationController _animationControllerChaos;
  late AnimationController _animationControllerChaosStreaming;
  late AnimationController _animationControllerChaosSearching;

  late Animation<double> _chaosRotationAnimationValue;
  late Animation<double> _chaosRotationAnimationValueStreaming;
  late Animation<double> _chaosRotationAnimationValueSearching;

//mic
  late AnimationController _animationController;
  late Animation<double> _micTranslateTopValue;
  late Animation<double> _micTranslateRightValue;
  late Animation<double> _micTranslateLeftValue;
  late Animation<double> _micRotationFirst;
  late Animation<double> _micRotationSecond;
  late Animation<double> _micTranslateDownValue;

  late Animation<double> _micInsideTrashTranslateDown;

//trash
  late Animation<double> _trashContainerWithCoverTranslateTop;

  late Animation<double> _trashCoverRotationFirst;
  late Animation<double> _trashCoverTranslateLeft;
  late Animation<double> _trashCoverRotationSecond;
  late Animation<double> _trashCoverTranslateRight;

  late Animation<double> _trashContainerWithCoverTranslateDown;

  userMessageAdd(String gelenMesaj, bool isVoice, String voiceUrl,
      DocumentReference messageRef) {
    messageRef.set({
      'member_avatar_url': userAll.isolaUserDisplay.avatarUrl,
      'member_message': t1.text,
      'member_message_time': DateTime.now().toUtc(),
      'member_name': userAll.isolaUserDisplay.userName,
      'member_uid': userAll.isolaUserMeta.userUid,
      'member_message_isvoice': false,
      'member_message_voice_url': voiceUrl,
      'member_message_isattachment': false,
      'member_message_attachment_url': "",
      'member_message_isimage': false,
      'member_message_isvideo': false,
      'member_message_isdocument': false,
      'member_message_target_1_uid': target1,
      'member_message_target_2_uid': target2,
      'member_message_no': messageRef.id,
    });

    t1.clear();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) {
      setState(() {
        itemCountValue = itemCountValue + 20;
      });
      refreshController.loadComplete();
    }
  }

  File? file = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);
    File file = File(xfile!.path);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => ChatImagePicker(
              userAll: userAll,
              targetUid1: target1,
              targetUid2: target2,
              file: file,
              isChaos: false,
              targetUid3: "",
              targetUid4: "",
              targetUid5: "",
            ));
  }

  showFilePicker(FileType fileType) async {
    if (fileType == FileType.custom) {
      FilePickerResult? result2 = await FilePicker.platform.pickFiles(
          type: fileType, allowMultiple: false, allowedExtensions: ['pdf']);

      if (result2 != null) {
        String fileName = result2.files.first.name;

        await uploadAttachment(userAll, result2.paths.first.toString(),
            refChatInterior, false, false, true, target1, target2);

        // Upload file
      }
    } else {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: fileType, allowMultiple: false);

      if (result != null) {
        if (fileType == FileType.video) {
          await uploadAttachment(userAll, result.paths.first.toString(),
              refChatInterior, false, true, false, target1, target2);
        } else {
          await uploadAttachment(userAll, result.paths.first.toString(),
              refChatInterior, true, false, false, target1, target2);
        }

        // Upload file
      }
    }

    Navigator.pop(context);
  }

  Widget metinGirisAlani() {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SayacModel())],
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 0.0, 4.w, 3.h),
        child: Row(
          children: [
            Flexible(
              child: Consumer<SayacModel>(
                  builder: (context, sayacModelNesne, child) {
                return CupertinoTextField(
                    selectionHeightStyle: BoxHeightStyle.includeLineSpacingTop,
                    suffix: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.paperclip,
                            size: 100.h >= 1100 ? 10.sp : 15.sp),
                        onPressed: () {
                          showCupertinoModalPopup<void>(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                              cancelButton: CupertinoActionSheetAction(
                                child: Text(LocaleKeys.main_cancel.tr()),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              actions: <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.doc),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      const Text('Document')
                                    ],
                                  ),
                                  onPressed: () {
                                    showFilePicker(FileType.custom);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.photo),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      const Text('Photo')
                                    ],
                                  ),
                                  onPressed: () {
                                    chooseImage();
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.film),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                          'Video ${LocaleKeys.main_comingsoon.tr()}')
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }),
                    cursorWidth: 1.w,
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 4.0, 4.0),
                    decoration: BoxDecoration(
                        color: ColorConstant.milkColor,
                        border: Border.all(
                            width: 1.0,
                            color: ColorConstant.softGrey.withOpacity(0.3)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    controller: t1,
                    maxLines: null,
                    onChanged: (i) {
                      if (i != "") {
                        sayacModelNesne.micOffline();
                        sayacModelNesne.micCancelVisOff();
                      } else {
                        sayacModelNesne.micOnline();
                        sayacModelNesne.micCancelVisOff();
                      }
                    });
              }),
            ),
            Consumer<SayacModel>(
              builder: (context, sayacModelNesne, child) {
                double xPosition = 0.0;
                double yPosition = 0.0;
                double movingx = 0.0;
                double movingy = 0.0;
                return Column(
                  children: [
                    Visibility(
                        visible: sayacModelNesne.micCancelVisibility,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: sayacModelNesne.trashIconReader(),
                        )),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, _micTranslateTopValue.value)
                            ..translate(_micTranslateRightValue.value)
                            ..translate(_micTranslateLeftValue.value)
                            ..translate(0.0, _micTranslateDownValue.value)
                            ..translate(
                                0.0, _micInsideTrashTranslateDown.value),
                          child: Transform.rotate(
                              angle: _micRotationFirst.value,
                              child: Transform.rotate(
                                  angle: _micRotationSecond.value,
                                  child: child)),
                        );
                      },
                      child: GestureDetector(
                        onLongPress: () async {
                          await _startRecording();
                        },
                        onLongPressStart: (LongPressStartDetails) async {
                          if (sayacModelNesne.sendIcon.icon ==
                              CupertinoIcons.mic) {
                            //  mic starting
                            // mic recording

                            sayacModelNesne.micCancelVisOn();
                            xPosition = LongPressStartDetails.localPosition.dx;
                            yPosition = LongPressStartDetails.localPosition.dy;

                            sayacModelNesne.micRecording();
                          } else {
                            if (t1.text != "") {
                              DocumentReference docRef = refChatInterior.doc();
                              userMessageAdd(t1.text, false, "nothing", docRef);
                            }
                          }
                        },
                        onLongPressMoveUpdate: (LongPressMoveUpdateDetails) {
                          sayacModelNesne.yTransValueSetter(
                              LongPressMoveUpdateDetails.localPosition.dy);

                          if (yPosition - 70 >=
                              LongPressMoveUpdateDetails.localPosition.dy) {
                            sayacModelNesne.trashOnline();
                          } else {
                            sayacModelNesne.trashOffline();
                          }

                          if (movingy == yPosition) {}
                        },
                        onLongPressEnd: (LongPressEndDetails) async {
                          if (yPosition - 70 >=
                              LongPressEndDetails.localPosition.dy) {
                            await _audioRecorder.stop();

                            sayacModelNesne.micCancelVisOff();
                            sayacModelNesne.micRecordingToWaste();

                            sayacModelNesne.trashingStart();
                            _animationController
                                .forward()
                                .whenComplete(() async {
                              sayacModelNesne.trashingEnd();
                              sayacModelNesne.micOnline();
                              _animationController.reset();
                            });
                          } else {
                            if (sayacModelNesne.sendIcon.icon ==
                                CupertinoIcons.mic_circle_fill) {
                              await _audioRecorder.stop();

                              uploadVoice(userAll, _filePath, refChatInterior,
                                  target1, target2, "", "", "", false);

                              sayacModelNesne.micCancelVisOff();
                              sayacModelNesne.micOnline();
                            }
                          }
                        },
                        child: CupertinoButton(
                          onPressed: () {
                            //tapping

                            if (sayacModelNesne.sendIcon.icon ==
                                CupertinoIcons.add) {
                              DocumentReference docRef = refChatInterior.doc();
                              userMessageAdd(t1.text, false, "nothing", docRef);
                              sayacModelNesne.micOnline();
                            } else {
                              //mic starting
                            }
                          },
                          child: sayacModelNesne.iconReader(),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _trashContainerWithCoverTranslateTop,
                      builder: (context, child) {
                        return Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0,
                                  _trashContainerWithCoverTranslateTop.value)
                              ..translate(0.0,
                                  _trashContainerWithCoverTranslateDown.value),
                            child: child);
                      },
                      child: Visibility(
                        visible: sayacModelNesne.trashingComplate,
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _trashCoverRotationFirst,
                              builder: (context, child) {
                                return Transform(
                                  transform: Matrix4.identity()
                                    ..translate(_trashCoverTranslateLeft.value)
                                    ..translate(
                                        _trashCoverTranslateRight.value),
                                  child: Transform.rotate(
                                    angle: _trashCoverRotationSecond.value,
                                    child: Transform.rotate(
                                        angle: _trashCoverRotationFirst.value,
                                        child: child),
                                  ),
                                );
                              },
                              child: const Image(
                                image: AssetImage("asset/img/trash_cover.png"),
                                width: 40.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 1.5),
                              child: Image(
                                image: AssetImage(
                                  "asset/img/trash_container.png",
                                ),
                                width: 40.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    userAll = context.read<UserAllCubit>().state;

    isChaosSearching = false;
    itemCountValue = 20;
    _audioPlayer = AudioPlayer();

    user = auth.currentUser!;

    refChatInterior = context.read<ChatReferenceCubit>().state;

    groupSettingModelForTrawling = context.read<GroupSettingCubit>().state;

    context
        .read<CurrentChatCubit>()
        .currentChatChanger(groupSettingModelForTrawling.groupNo);

    itemCountValue =
        itemCountValue + groupSettingModelForTrawling.newNotiValueAmount;

    target1 = context.read<GroupSettingCubit>().state.groupMemberUid2;
    target2 = context.read<GroupSettingCubit>().state.groupMemberUid3;

    groupChaosSearchingInfoGetter(
            context.read<GroupSettingCubit>().state.groupNo)
        .then((value) => isChaosSearching = value)
        .whenComplete(() {
      if (isChaosSearching == true &&
          _animationControllerChaosSearching.isAnimating == false) {
        _animationControllerChaosSearching.repeat();
      }
    });

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1700), vsync: this);

    _animationControllerChaos = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _animationControllerChaosStreaming = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _animationControllerChaosSearching = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _micTranslateTopValue =
        Tween(begin: 0.0, end: -150.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    ))
          ..addListener(() {
            setState(() {});
          });

    _micRotationFirst = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.2),
    ))
      ..addListener(() {
        setState(() {});
      });

    _micTranslateRightValue =
        Tween(begin: 0.0, end: 13.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.1),
    ))
          ..addListener(() {
            setState(() {});
          });

    _micTranslateLeftValue =
        Tween(begin: 0.0, end: -13.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.1, 0.2),
    ))
          ..addListener(() {
            setState(() {});
          });

    _micRotationSecond = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.45),
    ))
      ..addListener(() {
        setState(() {});
      });

    _micTranslateDownValue =
        Tween(begin: 0.0, end: 170.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.45, 0.79, curve: Curves.easeInOut),
    ))
          ..addListener(() {
            setState(() {});
          });

    _micInsideTrashTranslateDown =
        Tween(begin: 0.0, end: 95.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.95, 1.00, curve: Curves.easeInOut),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashContainerWithCoverTranslateTop =
        Tween(begin: 60.0, end: -25.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.45, 0.6),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashCoverRotationFirst =
        Tween(begin: 0.0, end: -pi / 3).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.6,
        0.7,
      ),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashCoverTranslateLeft =
        Tween(begin: 0.0, end: -18.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.6,
        0.7,
      ),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashCoverRotationSecond =
        Tween(begin: 0.0, end: pi / 3).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.8,
        0.9,
      ),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashCoverTranslateRight =
        Tween(begin: 0.0, end: 18.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.8,
        0.9,
      ),
    ))
          ..addListener(() {
            setState(() {});
          });

    _trashContainerWithCoverTranslateDown =
        Tween(begin: 0.0, end: 95.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.95, 1.00, curve: Curves.easeInOut),
    ))
          ..addListener(() {
            setState(() {});
          });

    _chaosRotationAnimationValue =
        Tween(begin: 0.0, end: pi * 24).animate(CurvedAnimation(
      parent: _animationControllerChaos,
      curve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
    _chaosRotationAnimationValueStreaming =
        Tween(begin: 0.0, end: pi * 2).animate(CurvedAnimation(
      parent: _animationControllerChaosStreaming,
      curve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });

    _chaosRotationAnimationValueSearching =
        Tween(begin: 0.0, end: pi * 2).animate(CurvedAnimation(
      parent: _animationControllerChaosSearching,
      curve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    _animationControllerChaos.dispose();
    t1.dispose();
    _animationControllerChaosStreaming.dispose();
    _animationControllerChaosSearching.dispose();
    WidgetsBinding.instance!.removeObserver(this);

    //'chatting dispose çalıştı');

    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      //    "uygulamalar arası geçişte\nyukarıdan saati çekince\ndiger yukarıdan çekilen sürgü ile");

    }

    if (state == AppLifecycleState.paused) {
      // /7 print(" altta atıldı");
    }

    if (state == AppLifecycleState.resumed) {
      //   print("alta atıp geri gelince");
    }

    if (state == AppLifecycleState.detached) {
      //  print("detached");

      //işlemi cancel et !!!/// streamchanges
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyMiddle: false,
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: true,
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(groupSettingsPage);
            },
            child: Padding(
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () async {
                          if (isChaosSearching == true) {
                            DocumentReference pool2Ref = FirebaseFirestore
                                .instance
                                .collection('chaos_apply_pool_2')
                                .doc(groupSettingModelForTrawling.groupNo);

                            // ignore: prefer_typing_uninitialized_variables
                            var pool2Doc;

                            await pool2Ref.get().then(
                                (value) => pool2Doc = value['groupMemberList']);

                            var listDoc = pool2Doc as List<dynamic>;

                            if (listDoc
                                .contains(userAll.isolaUserMeta.userUid)) {
                              //iptal işlemi
                              if (_animationControllerChaosStreaming
                                      .isAnimating ==
                                  false) {
                                CollectionReference chaosApply2Ref =
                                    FirebaseFirestore.instance
                                        .collection('chaos_apply_pool_2');

                                await chaosApply2Ref
                                    .doc(groupSettingModelForTrawling.groupNo)
                                    .get()
                                    .then((value) {
                                  var gList =
                                      value['groupMemberList'] as List<dynamic>;

                                  if (gList.length < 3) {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                                content: Text(
                                                   LocaleKeys.main_stopmatching.tr()),
                                                actions: [
                                                  CupertinoButton(
                                                      child:  Text(LocaleKeys.main_yes.tr()),
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
                                                              groupSettingModelForTrawling
                                                                  .groupNo,
                                                        });
                                                        Navigator.pop(context);
                                                        //chaos matching stop pool oluştur
                                                        //orayı checker eden bir şey
                                                        //
                                                      }),
                                                  CupertinoButton(
                                                      child: Text(LocaleKeys
                                                          .main_nogoback
                                                          .tr()),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      })
                                                ]));
                                  } else {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                                content:  Text(
                                                    LocaleKeys.chat_allmemberaccept.tr()),
                                                actions: [
                                                  CupertinoButton(
                                                      child:  Text(LocaleKeys.chat_allmemberaccept.tr()),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      })
                                                ]));
                                  }
                                });
                              }
                            } else {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content:  Text(LocaleKeys.chat_joinchaos.tr()),
                                        actions: [
                                          CupertinoButton(
                                              child:  Text(LocaleKeys.main_yes.tr()),
                                              onPressed: () async {
                                                Navigator.pop(context);

                                                await groupChaosApply(
                                                    userAll
                                                        .isolaUserMeta.userUid,
                                                    groupSettingModelForTrawling
                                                        .groupNo);
                                              }),
                                          CupertinoButton(
                                              child:  Text(LocaleKeys.main_nogoback.tr()),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ));
                            }
                          } else {
                            if (_animationControllerChaosStreaming
                                .isAnimating) {
                              //  print('islem yapamazsın');
                            } else {
                              if (userAll.isolaUserMeta.userToken == 0) {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          content:
                                              Text(LocaleKeys.homepage_needtoken.tr()),
                                          actions: [
                                            CupertinoButton(
                                                child: Text(LocaleKeys.main_okay.tr()),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ));
                                //uyarı göster token yetersiz
                              } else {
                                if (_animationControllerChaos.isAnimating) {
                                  _animationControllerChaos.stop();
                                  _animationControllerChaos.reset();
                                } else {
                                  await _animationControllerChaos.forward();
                                }

                                if (_animationControllerChaos.isCompleted) {
                                  groupChaosApply(userAll.isolaUserMeta.userUid,
                                          groupSettingModelForTrawling.groupNo)
                                      .whenComplete(() {
                                    _animationControllerChaosStreaming.repeat();
                                  });
                                }
                              }
                            }
                          }
                        },
                        child: Transform.rotate(
                          angle: isChaosSearching == false
                              ? (_animationControllerChaos.isCompleted
                                  ? _chaosRotationAnimationValueStreaming.value
                                  : _chaosRotationAnimationValue.value)
                              : _chaosRotationAnimationValueSearching.value,
                          child: Image.asset("asset/img/chaos_button.png",
                              scale: 1.2),
                        )),
                  ),
                  /*  Align(
                    alignment: Alignment.center,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('groups')
                            .doc(groupSettingModelForTrawling.groupNo)
                            .withConverter<GroupsModel>(
                              fromFirestore: (snapshot, _) =>
                                  GroupsModel.fromJson(snapshot.data()!),
                              toFirestore: (message, _) => message.toJson(),
                            )
                            .snapshots(includeMetadataChanges: true),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            DocumentSnapshot groupData =
                                snapshot.requireData as DocumentSnapshot;

                 

                            if ( groupData['gChaosSearching'] == false) {
                              if (_animationControllerChaosSearching
                                  .isAnimating) {
                                print('calisti');
                            
                                _animationControllerChaosSearching.reset();
                               setState(() {
                                 
                               });
                              }
                            } else if ( groupData['gChaosSearching'] == true) {
                              if (_animationControllerChaosSearching
                                      .isAnimating ==
                                  false) {
                                _animationControllerChaosSearching.repeat();
                              }
                            }
                          }

                          return SizedBox();
                        }),
                  ),
                 
                 */
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 0.w),
                        child: CircleImageContainer(
                          circleImage: CircleAvatar(
                            radius: 13.sp,
                            backgroundColor: ColorConstant.milkColor,
                            child: ClipRRect(
                              borderRadius: 100.h <= 1100
                                  ? BorderRadius.circular(20.sp)
                                  : BorderRadius.circular(30.sp),
                              child: CachedNetworkImage(
                                imageUrl: groupSettingModelForTrawling
                                    .groupMemberAvatarUrl2,
                                errorWidget: (context, url, error) =>
                                    const Icon(CupertinoIcons.xmark_square),
                                cacheManager: CacheManager(Config(
                                  "cachedImageFiles",
                                  stalePeriod: const Duration(days: 3),
                                  //one week cache period
                                )),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: 100.h >= 1100
                            ? EdgeInsets.only(right: 4.w)
                            : EdgeInsets.only(right: 6.w),
                        child: CircleImageContainer(
                          circleImage: CircleAvatar(
                            radius: 13.sp,
                            backgroundColor: CupertinoColors.black,
                            child: ClipRRect(
                              borderRadius: 100.h <= 1100
                                  ? BorderRadius.circular(20.sp)
                                  : BorderRadius.circular(30.sp),
                              child: CachedNetworkImage(
                                imageUrl: groupSettingModelForTrawling
                                    .groupMemberAvatarUrl3,
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) =>
                                    const Icon(CupertinoIcons.xmark_square),
                                cacheManager: CacheManager(Config(
                                  "cachedImageFiles",
                                  stalePeriod: const Duration(days: 3),
                                  //one week cache period
                                )),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              color: ColorConstant.themeGrey,
              child: Column(
                children: [
                  Flexible(
                    child: StreamBuilder<QuerySnapshot<GroupChatMessage>>(
                        stream: refChatInterior
                            .orderBy("member_message_time", descending: true)
                            .limit(itemCountValue)
                            .withConverter<GroupChatMessage>(
                              fromFirestore: (snapshot, _) =>
                                  GroupChatMessage.fromJson(snapshot.data()!),
                              toFirestore: (message, _) => message.toJson(),
                            )
                            .snapshots(),
                        //    refChatInterior.limitToLast(itemCountValue).onValue,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                  animating: true, radius: 12.sp),
                            );
                          }

                          var seemingMessage = <String>[];

                          final data = snapshot.requireData;

                          for (var item in data.docs) {
                            seemingMessage.add(item.data().member_message_no);
                          }

                          exploreHistoryItemsSave(seemingMessage,
                              groupSettingModelForTrawling.groupNo);

                          exploreHistoryGetter(
                              groupSettingModelForTrawling.groupNo);

                          return data.docs.isEmpty
                              ? Column(
                                  children: const [],
                                )
                              : SmartRefresher(
                                  enablePullDown: false,
                                  enablePullUp: true,
                                  header: const ClassicHeader(),
                                  controller: refreshController,
                                  onLoading: _onLoading,
                                  child: ListView.builder(
                                      reverse: true,
                                      itemCount: data.size,
                                      itemBuilder: (context, indeksNumarasi) =>
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AllMessageBalloon(
                                                isMe: data.docs[indeksNumarasi]
                                                            .data()
                                                            .member_uid ==
                                                        userAll.isolaUserMeta
                                                            .userUid
                                                    ? true
                                                    : false,
                                                memberMessage: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message,
                                                memberAvatarUrl: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_avatar_url,
                                                memberMessageTime: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_time,
                                                memberName: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_name,
                                                memberUid: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_uid,
                                                memberMessageIsVoice: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_isVoice,
                                                memberMessageVoiceUrl: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_voice_url,
                                                memberIsAttachment: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_isAttachment,
                                                memberIsImage: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_isImage,
                                                memberIsVideo: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_isVideo,
                                                memberIsDocument: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_isDocument,
                                                memberAttachmentUrl: data
                                                    .docs[indeksNumarasi]
                                                    .data()
                                                    .member_message_attachment_url,
                                                userMeAvatarUrl: userAll
                                                    .isolaUserDisplay.avatarUrl,
                                                targetNumber: data.docs[
                                                                indeksNumarasi]
                                                            .data()
                                                            .member_uid ==
                                                        userAll.isolaUserMeta
                                                            .userUid
                                                    ? 0
                                                    : data.docs[indeksNumarasi]
                                                                .data()
                                                                .member_uid ==
                                                            target1
                                                        ? 1
                                                        : 2,
                                              ))),
                                );
                        }),
                  ),
                  metinGirisAlani(),
                ],
              )),
        ));
  }

  Future<void> _startRecording() async {
    // ignore: prefer_typing_uninitialized_variables
    late var hasRecordingPermission;
    await FlutterAudioRecorder2.hasPermissions
        .then((value) => hasRecordingPermission = value);

    if (hasRecordingPermission) {
      Directory directory = await getApplicationDocumentsDirectory();
      String filepath = directory.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.aac';

      _audioRecorder =
          FlutterAudioRecorder2(filepath, audioFormat: AudioFormat.AAC);
      await _audioRecorder.initialized;
      _audioRecorder.start();
      _filePath = filepath;
    } else {
      //    print("lütfen ses kayit icin izinleri acin");
    }
  }
}

var sizedBox = 100.h <= 1100
    ? const SizedBox()
    : SizedBox(
        width: 7.w,
      );

class AllMessageBalloon extends StatelessWidget {
  const AllMessageBalloon(
      {Key? key,
      required this.isMe,
      required this.memberMessage,
      required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid,
      required this.memberMessageIsVoice,
      required this.memberMessageVoiceUrl,
      required this.memberIsAttachment,
      required this.memberIsImage,
      required this.memberIsVideo,
      required this.memberIsDocument,
      required this.memberAttachmentUrl,
      required this.userMeAvatarUrl,
      required this.targetNumber})
      : super(key: key);

  final bool isMe;
  final String memberMessage;
  final String memberAvatarUrl;
  final Timestamp memberMessageTime;
  final String memberName;
  final String memberUid;
  final bool memberMessageIsVoice;
  final String memberMessageVoiceUrl;
  final bool memberIsAttachment;
  final bool memberIsImage;
  final bool memberIsVideo;
  final bool memberIsDocument;
  final String memberAttachmentUrl;
  final String userMeAvatarUrl;
  final int targetNumber;

  @override
  Widget build(BuildContext context) {
    late TextStyle targetTextStyle;

    switch (targetNumber) {
      case 0:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle1
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle1;
        break;
      case 1:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle1
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle1;
        break;
      case 2:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle2
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle2;
        break;

      default:
    }

    if (memberAttachmentUrl == "isola_system_message" &&
        memberName == "System Message") {
      return SystemMessageBalloon(
        memberMessage: memberMessage,
        memberMessageTime: memberMessageTime,
        memberAvatarUrl: memberAvatarUrl,
        memberName: memberName,
        memberUid: memberUid,
      );
    } else {
      return isMe == false
          ? (memberMessageIsVoice == true
              ? VoiceMessageBalloonLeft(
                  memberAvatarUrl: memberAvatarUrl,
                  memberMessageTime: memberMessageTime,
                  memberName: memberName,
                  memberUid: memberUid,
                  memberVoiceUrl: memberMessageVoiceUrl,
                  targetTextStyle: targetTextStyle,
                )
              : memberIsAttachment == true
                  ? AttachmentMessageBalloonLeft(
                      memberAttachmentUrl: memberAttachmentUrl,
                      memberAvatarUrl: memberAvatarUrl,
                      memberMessageTime: memberMessageTime,
                      memberName: memberName,
                      memberUid: memberUid,
                      memberMessageIsImage: memberIsImage,
                      memberMessageIsVideo: memberIsVideo,
                      memberMessageIsDocument: memberIsDocument,
                      targetTextStyle: targetTextStyle,
                    )
                  : TextMessageBalloonLeft(
                      memberMessage: memberMessage,
                      memberMessageTime: memberMessageTime,
                      memberAvatarUrl: memberAvatarUrl,
                      memberName: memberName,
                      memberUid: memberUid,
                      targetTextStyle: targetTextStyle,
                    ))
          : (memberMessageIsVoice == true
              //
              ? VoiceMessageBalloonRight(
                  memberAvatarUrl: userMeAvatarUrl,
                  memberMessageTime: memberMessageTime,
                  memberName: memberName,
                  memberUid: memberUid,
                  memberVoiceUrl: memberMessageVoiceUrl,
                )
              : memberIsAttachment == true
                  ? AttachmentMessageBalloonRight(
                      memberAttachmentUrl: memberAttachmentUrl,
                      memberAvatarUrl: userMeAvatarUrl,
                      memberMessageTime: memberMessageTime,
                      memberName: memberName,
                      memberUid: memberUid,
                      memberMessageIsImage: memberIsImage,
                      memberMessageIsVideo: memberIsVideo,
                      memberMessageIsDocument: memberIsDocument)
                  : TextMessageBalloonRight(
                      memberMessage: memberMessage,
                      memberMessageTime: memberMessageTime,
                      memberAvatarUrl: userMeAvatarUrl,
                      memberName: memberName,
                      memberUid: memberUid,
                    ));
    }
  }
}

// ignore: must_be_immutable
class CircleImageContainer extends StatelessWidget {
  Widget circleImage;

  CircleImageContainer({Key? key, required this.circleImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h >= 1100 ? 13.sp : 30.sp,
      width: 100.h >= 1100 ? 13.sp : 30.sp,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.all(Radius.circular(20.sp))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          decoration: BoxDecoration(
              color: ColorConstant.milkColor,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: BorderRadius.all(Radius.circular(20.sp))),
          child: circleImage,
        ),
      ),
    );
  }
}

class SayacModel extends ChangeNotifier {
  Icon sendIcon = Icon(
    CupertinoIcons.mic,
    size: 100.h >= 1100 ? 12.sp : 18.sp,
  );

  Icon trashIcon = const Icon(
    CupertinoIcons.trash,
    color: CupertinoColors.systemGrey,
  );

  void trashOffline() {
    trashIcon = const Icon(
      CupertinoIcons.trash,
      color: CupertinoColors.systemGrey,
    );
    notifyListeners();
  }

  void trashOnline() {
    trashIcon = const Icon(
      CupertinoIcons.trash,
      color: CupertinoColors.systemRed,
    );
    notifyListeners();
  }

  Icon trashIconReader() {
    return trashIcon;
  }

  double xTransvalue = 0.0;
  double yTransvalue = 0.0;

  xTransValueSetter(double xValue) {}
  double xTransValueReader() {
    return xTransvalue;
  }

  yTransValueSetter(double yValue) {}
  double yTransValueReader() {
    return yTransvalue;
  }

  bool micCancelVisibility = false;
  bool trashContVisibility = false;
  bool trashingComplate = false;

  bool micCancelVisReader() {
    return micCancelVisibility;
  }

  void micCancelVisOff() {
    micCancelVisibility = false;
  }

  void micCancelVisOn() {
    micCancelVisibility = true;
  }

  bool trashContVisReader() {
    return trashContVisibility;
  }

  void trashContVisOff() {
    trashContVisibility = false;
  }

  void trashContVisOn() {
    trashContVisibility = true;
  }

  bool trashingStatusReader() {
    return trashingComplate;
  }

  void trashingStart() {
    trashingComplate = true;
  }

  void trashingEnd() {
    trashingComplate = false;
  }

  Icon iconReader() {
    return sendIcon;
  }

  void micOffline() {
    sendIcon = Icon(
      CupertinoIcons.add,
      size: 100.h >= 1100 ? 12.sp : 18.sp,
    );
    notifyListeners();
  }

  void micOnline() {
    sendIcon = Icon(
      CupertinoIcons.mic,
      size: 100.h >= 1100 ? 12.sp : 18.sp,
    );
    notifyListeners();
  }

  void micRecording() {
    sendIcon = Icon(
      CupertinoIcons.mic_circle_fill,
      size: 100.h >= 1100 ? 28.sp : 35.sp,
    );
    notifyListeners();
  }

  void micRecordingToWaste() {
    sendIcon = Icon(
      CupertinoIcons.mic_circle_fill,
      size: 100.h >= 1100 ? 18.sp : 22.sp,
    );
    notifyListeners();
  }

  void micRecordingCancel() {
    sendIcon = Icon(
      CupertinoIcons.mic_off,
      size: 100.h >= 1100 ? 28.sp : 35.sp,
    );
    notifyListeners();
  }

  var sizedBox = 100.h <= 1100
      ? const SizedBox()
      : SizedBox(
          width: 7.w,
        );
}
