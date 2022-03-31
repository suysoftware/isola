import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/blocs/group_is_chaos_cubit.dart';
import 'package:isola_app/src/blocs/group_setting_cubit.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/chaos/chaos_group_meta.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/group/group_chaos.dart';
import 'package:isola_app/src/model/group/group_chat_message.dart';
import 'package:isola_app/src/model/group/group_preview_data.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/attachment_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/attachment_message_baloon_right.dart';
import 'package:isola_app/src/page/groupchat/chat_image_picker.dart';
import 'package:isola_app/src/page/groupchat/system_message_balloon/system_message_balloon.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_message_balloon_right.dart';
import 'package:isola_app/src/page/groupchat/voice_message_balloon/voice_message_balloon_left.dart';
import 'package:isola_app/src/page/groupchat/voice_message_balloon/voice_message_balloon_right.dart';
import 'package:isola_app/src/service/firebase/storage/chaos/chaos_group_finder.dart';
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
import 'package:uuid/uuid.dart';

import '../../../../blocs/chaos_group_setting_cubit.dart';
import '../../../../model/chaos/chaos_chat_message.dart';
import '../../../../model/chaos/chaos_group_setting_model.dart';

class ChaosChatInteriorPage extends StatefulWidget {
  const ChaosChatInteriorPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChaosChatInteriorPageState createState() => _ChaosChatInteriorPageState();
}

class _ChaosChatInteriorPageState extends State<ChaosChatInteriorPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController t1 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // late Stream<QueryDocumentSnapshot> groupDocumentStream;

  DateFormat dFormat = DateFormat("HH:mm:ss");
  late String target1;
  late String target2;
  late String target3;
  late String target4;
  late String target5;
  late bool isChaosSearching;
  bool extensionButtonActive = false;

  late String _filePath;
  late AudioPlayer _audioPlayer;

  late FlutterAudioRecorder2 _audioRecorder;

  late ChaosGroupSettingModel groupSettingModelForTrawling;
  late int itemCountValue;
  late User user;
  late CollectionReference refChatInterior;
  late IsolaUserAll userAll;

  CountDownController chaosTimerController = CountDownController();

//chaos button

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
      'member_message_target_3_uid': target3,
      'member_message_target_4_uid': target4,
      'member_message_target_5_uid': target5,
      'member_message_no': messageRef.id,
    });

    t1.clear();
  }

  void _onLoading() async {
    print("onloading");
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) {
      setState(() {
        itemCountValue = itemCountValue + 20;

        //_onRefresh();
      });
      refreshController.loadComplete();
    }
  }

  File? file = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 100,
    );
    File file = File(xfile!.path);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => ChatImagePicker(
              userAll: userAll,
              targetUid1: target1,
              targetUid2: target2,
              file: file,
              isChaos: true,
              targetUid4: target4,
              targetUid3: target3,
              targetUid5: target5,
            ));
    //setState(() {});
  }

  showFilePicker(FileType fileType) async {
    if (fileType == FileType.custom) {
      FilePickerResult? result2 = await FilePicker.platform.pickFiles(
          type: fileType, allowMultiple: false, allowedExtensions: ['pdf']);

      if (result2 != null) {
        String fileName = result2.files.first.name;
        print(fileName);
        print(result2.paths);
        await uploadAttachmentToChaos(
            userAll,
            result2.paths.first.toString(),
            refChatInterior,
            false,
            false,
            true,
            target1,
            target2,
            target3,
            target4,
            target5);

        // Upload file
      }
    } else {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: fileType, allowMultiple: false);

      if (result != null) {
        String fileName = result.files.first.name;
        print(fileName);
        print(result.paths);

        if (fileType == FileType.video) {
          await uploadAttachmentToChaos(
              userAll,
              result.paths.first.toString(),
              refChatInterior,
              false,
              true,
              false,
              target1,
              target2,
              target3,
              target4,
              target5);
        } else {
          await uploadAttachmentToChaos(
              userAll,
              result.paths.first.toString(),
              refChatInterior,
              true,
              false,
              false,
              target1,
              target2,
              target3,
              target4,
              target5);
        }

        // Upload file
      }
    }

    // chatBloc.dispatch(SendAttachmentEvent(chat.chatId, file, fileType));
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
                          print("ATTACHMENT");

                          showCupertinoModalPopup<void>(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                              cancelButton: CupertinoActionSheetAction(
                                child: const Text('Cancel'),
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
                                    /*
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) => ChatImagePicker(
                                            userDisplay: userDisplay,
                                            targetUid1: target1,
                                            targetUid2: target2));*/
                                    /*
                                    showFilePicker(
                                      FileType.image,
                                    );*/
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.film),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      const Text('Video (Coming Soon)')
                                    ],
                                  ),
                                  onPressed: () {
                                    /*
                                    showFilePicker(
                                      FileType.video,
                                      
                                    );*/
                                  },
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
                            print("mic basıldı");
                            print("kayıt alınıyor");

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

                            //sayac model nesneyi çöplük büyüme animasyonunda kullan
                            //burada animasyon oynat visibitliy animasyonda

                          } else {
                            sayacModelNesne.trashOffline();
                          }

                          //    print(LongPressMoveUpdateDetails.localPosition.dx);
                          //  print(LongPressMoveUpdateDetails.localPosition.dy);

                          if (movingy == yPosition) {}
                        },
                        onLongPressEnd: (LongPressEndDetails) async {
                          if (yPosition - 70 >=
                              LongPressEndDetails.localPosition.dy) {
                            print("agabuyuk");
                            //dikkat
                            await _audioRecorder.stop();
                            print("ses kaydı çöpe atıldı");
                            sayacModelNesne.micCancelVisOff();
                            sayacModelNesne.micRecordingToWaste();

                            sayacModelNesne.trashingStart();
                            _animationController
                                .forward()
                                .whenComplete(() async {
                              //dikkat

                              sayacModelNesne.trashingEnd();
                              sayacModelNesne.micOnline();
                              _animationController.reset();
                            });

                            //sayac model nesneyi çöplük büyüme animasyonunda kullan
                            //burada animasyon oynat visibitliy animasyonda

                          } else {
                            if (sayacModelNesne.sendIcon.icon ==
                                CupertinoIcons.mic_circle_fill) {
                              await _audioRecorder.stop();

                              uploadVoice(
                                  userAll,
                                  _filePath,
                                  refChatInterior,
                                  target1,
                                  target2,
                                  target3,
                                  target4,
                                  target5,
                                  true);
                              //buraya kural koy eğer 1 snaiyeyi geçtiyse yüklesin
                              print(
                                  "kayıt veritabanına yükleniyor ve gönderiliyor");
                              sayacModelNesne.micCancelVisOff();
                              sayacModelNesne.micOnline();
                            }
                          }
                          print("end oldumu");
                        },
                        child: CupertinoButton(
                          onPressed: () {
                            print("basti");

                            if (sayacModelNesne.sendIcon.icon ==
                                CupertinoIcons.add) {
                              DocumentReference docRef = refChatInterior.doc();
                              userMessageAdd(t1.text, false, "nothing", docRef);
                              sayacModelNesne.micOnline();
                            } else {
                              print("mikrofonbaşladı");
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

    //isChaosSearching = false;
    itemCountValue = 20;
    _audioPlayer = AudioPlayer();

    user = auth.currentUser!;

    refChatInterior = context.read<ChatReferenceCubit>().state;

    groupSettingModelForTrawling = context.read<ChaosGroupSettingCubit>().state;

    /* groupDocumentStream = FirebaseFirestore.instance
        .collection('chaos_groups_chat')
        .doc(groupSettingModelForTrawling.groupNo);*/

    /*FirebaseFirestore.instance
        .collection('chaos_groups_chat')
        .doc(groupSettingModelForTrawling.groupNo);*/
    //   .snapshots(includeMetadataChanges: true);
    // print(groupSettingModelForTrawling.groupNo);

    target1 = context.read<ChaosGroupSettingCubit>().state.groupMemberUid2;
    target2 = context.read<ChaosGroupSettingCubit>().state.groupMemberUid3;
    target3 = context.read<ChaosGroupSettingCubit>().state.groupMemberUid4;
    target4 = context.read<ChaosGroupSettingCubit>().state.groupMemberUid5;
    target5 = context.read<ChaosGroupSettingCubit>().state.groupMemberUid6;

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1700), vsync: this);

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
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();

    t1.dispose();

    WidgetsBinding.instance!.removeObserver(this);
    // print("sfafsa");

    super.dispose();
  }

/*
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      print(
          "uygulamalar arası geçişte\nyukarıdan saati çekince\ndiger yukarıdan çekilen sürgü ile");
    }

    if (state == AppLifecycleState.paused) {
      print(" altta atıldı");
    }

    if (state == AppLifecycleState.resumed) {
      print("alta atıp geri gelince");
    }

    if (state == AppLifecycleState.detached) {
      print("detached");

      //işlemi cancel et !!!/// streamchanges
    }
    super.didChangeAppLifecycleState(state);
  }
*/
  @override
  Widget build(BuildContext context) {
    DateFormat dFormat = DateFormat("HH:mm");

    /*  groupDocumentStream.forEach((element) {
                print(element);
                print(element['created_time']);
              //  print(DateTime.fromMicrosecondsSinceEpoch(
                //    element['created_time']));
                print(
                    '${dFormat.format(DateTime.fromMicrosecondsSinceEpoch(element['created_time'].microsecondsSinceEpoch.toInt(), isUtc: false))}');
              });*/

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyMiddle: false,
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: true,
          //eğer stream yapılıyorsa önce uyarı ver //streamingchanges

          trailing: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chaos_groups_chat')
                        .doc(groupSettingModelForTrawling.groupNo)
                        .withConverter<ChaosGroupMeta>(
                          fromFirestore: (snapshot, _) =>
                              ChaosGroupMeta.fromJson(snapshot.data()!),
                          toFirestore: (message, _) => message.toJson(),
                        )
                        .snapshots(includeMetadataChanges: true),

                    /*groupDocumentStream
                          .withConverter<ChaosChatMessage>(
                            fromFirestore: (snapshot, _) =>
                                ChaosChatMessage.fromJson(snapshot.data()!),
                            toFirestore: (message, _) => message.toJson(),
                          )
                          .snapshots(includeMetadataChanges: true),*/
                    builder: (BuildContext context,
                            snapshots) // (context, snapshots)
                        {
                      if (snapshots.hasData) {
                        DocumentSnapshot ds =
                            snapshots.requireData as DocumentSnapshot;

                        /* print(ds['created_time']);
                          print(ds['created_time']);
                          print(ds['created_time']);
                          print(ds['created_time']);
                          print(ds['created_time']);
                          
                          print(DateTime.fromMicrosecondsSinceEpoch(
                              ds['created_time'].microsecondsSinceEpoch.toInt(),
                              isUtc: false));
                          print(DateTime.fromMicrosecondsSinceEpoch(
                              ds['finish_time'].microsecondsSinceEpoch.toInt(),
                              isUtc: false));
                          print(DateTime.fromMicrosecondsSinceEpoch(
                              ds['finish_with_bonus_time']
                                  .microsecondsSinceEpoch
                                  .toInt(),
                              isUtc: false));*/

                        DateTime dTime = DateTime.now();

                        /*DateTime.fromMicrosecondsSinceEpoch(
                              ds['created_time'].microsecondsSinceEpoch.toInt(),
                              isUtc: false);*/
                        DateTime dTimeFinish =
                            DateTime.fromMicrosecondsSinceEpoch(
                                ds['finish_time']
                                    .microsecondsSinceEpoch
                                    .toInt(),
                                isUtc: false);
                        DateTime dTimeWithBonus =
                            DateTime.fromMicrosecondsSinceEpoch(
                                ds['finish_with_bonus_time']
                                    .microsecondsSinceEpoch
                                    .toInt(),
                                isUtc: false);

                        print(dTimeFinish.difference(dTime).inSeconds);
                        print(dTimeWithBonus.difference(dTime).inSeconds);

                        int chaosTime;

                        chaosTime = ds['time_bonus'] == true
                            ? dTimeWithBonus.difference(dTime).inSeconds.toInt()
                            : dTimeFinish.difference(dTime).inSeconds.toInt();
                        bool isBonus = ds['time_bonus'];

                        if (ds['time_bonus'] &&
                            extensionButtonActive == false) {
                          print('SSS');
                          print('SSS');
                          print('SSS');
                          print('SSS');
                          print('SSS');
                          print('SSS');

                          extensionButtonActive = true;
                        }
                        /* print(dTime);
                            print(dTime);
                              print(dTime);
                                print(dTime);
                                  print(dTime);
                                    print(dTime);*/
                        // print('${dFormat.format()}');
                        //  print(ss.chaosIsComplete);

                        return GestureDetector(
                          onTap: () {
                            if (userAll.isolaUserMeta.userToken > 0 &&
                                isBonus != true &&
                                extensionButtonActive == false) {
                              DocumentReference extenRef = FirebaseFirestore
                                  .instance
                                  .collection('chaos_extensions_pool')
                                  .doc();

                              extenRef.set({
                                'extension_no': extenRef.id,
                                'benefactor_uid': userAll.isolaUserMeta.userUid,
                                'chaos_group_no':
                                    groupSettingModelForTrawling.groupNo,
                                'extension_time': DateTime.now().toUtc(),
                                'benefactor_name':
                                    userAll.isolaUserDisplay.userName,
                                'benefactor_avatar_url':
                                    userAll.isolaUserDisplay.avatarUrl,
                                'chaos_member_1_uid': target1,
                                'chaos_member_2_uid': target2,
                                'chaos_member_3_uid': target3,
                                'chaos_member_4_uid': target4,
                                'chaos_member_5_uid': target5,
                              });

                              extensionButtonActive = true;

                              //uzatma talebi gönder

                            } else {
                              print('sikintii');
                              print(isBonus);
                              print(extensionButtonActive);
                              print(userAll.isolaUserMeta.userToken);
                            }
                          },
                          child: CircularCountDownTimer(
                            controller: chaosTimerController,
                            duration: chaosTime,

                            /*  duration: ds['time_bonus'] == true
                                  ? dTimeWithBonus.difference(dTime).inSeconds.toInt()
                                  : dTimeFinish.difference(dTime).inSeconds.toInt(),*/
                            //   initialDuration: 50,
                            textFormat: CountdownTextFormat.MM_SS,
                            width: 30.sp,
                            height: 30.sp,
                            ringColor: isBonus == true
                                ? Colors.yellow[300]!
                                : Colors.grey[300]!,
                            //ringGradient: ColorConstant.isolaTriumGradient,
                            fillColor: isBonus == true
                                ? Colors.redAccent
                                : Colors.purpleAccent[100]!,
                            // fillGradient: ColorConstant.isolaMainGradient,
                            backgroundColor: isBonus == true
                                ? Colors.orange[300]!
                                : Colors.purple[500],
                            // backgroundGradient: ColorConstant.isolaMainGradient,
                            strokeWidth: 5.0,
                            strokeCap: StrokeCap.round,
                            textStyle: 100.h > 1100
                                ? StyleConstants.userTabletChatMessageTextStyle
                                : StyleConstants.userChatMessageTextStyle,

                            isReverse: true,

                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              print('Countdown Started');
                            },
                            onComplete: () {
                              print('Countdown Ended');
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CupertinoActivityIndicator(
                              animating: true, radius: 12.sp),
                        );
                      }
                    }),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Time Bonus',
                      style: StyleConstants.isolaTokenTextStyle,
                    ),
                  ),
                  SizedBox(
                      width: 25.sp,
                      height: 25.sp,
                      child: Image.asset('asset/img/isola_token.png')),
                ],
              ),
            )
          ]),

/*
          trailing: GestureDetector(
            onTap: () {
              //eğer stream yapılıyorsa önce uyarı ver //streamingchanges
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(groupSettingsPage);
              //  Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.zero,
              child: Stack(children: [
                /*buraya düşen süre yapılacak açılış tarihi 
                      ile datetime karşılaştırarak ama if verilecek
                      if bonus açıksa with bonus ile hesaplayacak
                  */


              ]),
            ),
          ),
      */
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
                    child: StreamBuilder<QuerySnapshot<ChaosChatMessage>>(
                        stream: refChatInterior
                            .orderBy("member_message_time", descending: true)
                            .limit(itemCountValue)
                            .withConverter<ChaosChatMessage>(
                              fromFirestore: (snapshot, _) =>
                                  ChaosChatMessage.fromJson(snapshot.data()!),
                              toFirestore: (message, _) => message.toJson(),
                            )
                            .snapshots(),
                        //    refChatInterior.limitToLast(itemCountValue).onValue,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CupertinoActivityIndicator(
                                  animating: true, radius: 12.sp),
                            );

                          //   var chatMessageDatas = <AllMessageBalloon>[];

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
                                  // onRefresh: _onLoading,
                                  onLoading: _onLoading,
                                  child: ListView.builder(
                                      reverse: true,
                                      //itemCount: chatMessageDatas.length,
                                      //   itemCount: data.size<itemCountValue?data.size:itemCountValue,
                                      itemCount: data.size,
                                      itemBuilder: (context, indeksNumarasi) =>
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              // child: chatMessageDatas[
                                              //   indeksNumarasi],
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
                                                        : data.docs[indeksNumarasi]
                                                                    .data()
                                                                    .member_uid ==
                                                                target2
                                                            ? 2
                                                            : data.docs[indeksNumarasi]
                                                                        .data()
                                                                        .member_uid ==
                                                                    target3
                                                                ? 3
                                                                : data.docs[indeksNumarasi]
                                                                            .data()
                                                                            .member_uid ==
                                                                        target4
                                                                    ? 4
                                                                    : 5,
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
      print("lütfen ses kayit icin izinleri acin");
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
      case 3:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle3
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle3;
        break;
      case 4:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle4
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle4;
        break;
      case 5:
        100.h <= 1100
            ? targetTextStyle = StyleConstants.chatNameTextStyle5
            : targetTextStyle = StyleConstants.chatTabletNameTextStyle5;
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
                  targetTextStyle: targetTextStyle)
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
                      targetTextStyle: targetTextStyle)
                  : TextMessageBalloonLeft(
                      memberMessage: memberMessage,
                      memberMessageTime: memberMessageTime,
                      memberAvatarUrl: memberAvatarUrl,
                      memberName: memberName,
                      memberUid: memberUid,
                      targetTextStyle: targetTextStyle))
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
/*

class CircleImageContainer extends StatelessWidget {
  Widget circleImage;

  CircleImageContainer({Key? key, required this.circleImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoPageScaffold(
                                    navigationBar: const CupertinoNavigationBar(
                                      automaticallyImplyLeading: true,
                                    ),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: CachedNetworkImage(
                                        imageUrl: memberAttachmentUrl,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Icon(CupertinoIcons.xmark_square),
                                        cacheManager: CacheManager(Config(
                                          "cachedImageFiles",
                                          stalePeriod: const Duration(days: 3),
                                          //one week cache period
                                        )),
                                      ),
                                    )))),
      child: Container(
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
      ),
    );
  }
}*/

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
