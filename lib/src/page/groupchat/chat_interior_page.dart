// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable, unnecessary_null_comparison, must_be_immutable

import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
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
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_attachment_message.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_voice_message.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class ChatInteriorPage extends StatefulWidget {
  const ChatInteriorPage({
    Key? key,
  }) : super(key: key);

/*
   const ChatInteriorPage(
      {Key? key, required this.userDisplay, required this.groupNo})
      : super(key: key);
  final UserDisplay userDisplay;
  final String groupNo;
  */

  @override
  _ChatInteriorPageState createState() => _ChatInteriorPageState();
}

class _ChatInteriorPageState extends State<ChatInteriorPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController t1 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late Reference references;
  late String target1;
  late String target2;
  late bool chaosGroupCancel;
  late bool isChaosSearching;

  late String _filePath;
  late AudioPlayer _audioPlayer;

  late FlutterAudioRecorder2 _audioRecorder;

  late GroupSettingModel groupSettingModelForTrawling;
  late int itemCountValue;
  late User user;
  late var refChatInterior;
  late var refUserMeta;
  late var refGroupChaos;
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

  userMessageAdd(String gelenMesaj, bool isVoice, String voiceUrl) {
    var firstMessage = HashMap<String, dynamic>();
    firstMessage["member_avatar_url"] = userAll.isolaUserDisplay.avatarUrl;
    firstMessage["member_message"] = t1.text;
    firstMessage["member_message_time"] = ServerValue.timestamp;
    firstMessage["member_name"] = userAll.isolaUserDisplay.userName;
    firstMessage["member_uid"] = userAll.isolaUserMeta.userUid;
    firstMessage["member_message_isvoice"] = false;
    firstMessage["member_message_voice_url"] = voiceUrl;
    firstMessage["member_message_isattachment"] = false;
    firstMessage["member_message_attachment_url"] = "";
    firstMessage["member_message_isimage"] = false;
    firstMessage["member_message_isvideo"] = false;
    firstMessage["member_message_isdocument"] = false;
    firstMessage["member_message_target_1_uid"] = target1;
    firstMessage["member_message_target_2_uid"] = target2;

    refChatInterior.push().set(firstMessage);

    t1.clear();

    // setState(() {
    //    AllMessageBalloon mesajNesnesi = AllMessageBalloon(isMe: true,theMessage: gelenMesaj);
    //    userMesajListesi.insert(0, mesajNesnesi);
    //   t1.clear();
    // });
  }

  void listenToChaosAlive() async {
    Stream<DatabaseEvent> streamAlive =
        refGroupChaos.child("chaos_is_alive").onValue;

    streamAlive.listen((event) {
      if (event.snapshot.value == true) {
        _animationControllerChaosSearching.stop();

        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  content: Text("Chaos will start soon"),
                  actions: [
                    CupertinoButton(
                        child: Text("Go"),
                        onPressed: () {
                          Navigator.pushNamed(context, navigationBar);
                        })
                  ],
                ));
      }
    });
  }

  void listenToChaosActive() async {
    //Stream<DatabaseEvent> streamActive =
    //  refGroupChaos.child("chaos_is_alive").onValue;

    Query chaosNoQuery = refGroupChaos.child("chaos_no");
    DataSnapshot snap = await chaosNoQuery.get();
    if (snap.value != null) {
      var refChaosDisplay = refGetter(
          enum2: RefEnum.Chaosgroupdisplay,
          targetUid: " ",
          userUid: "",
          crypto: "");
      var refChaosActive =
          refChaosDisplay.child(snap.value as String).child("group_is_active");

      Stream<DatabaseEvent> streamActive = refChaosActive.onValue;

      streamActive.listen((event) {
        if (event.snapshot.value == true) {
          // _animationControllerChaosSearching.stop();

          refGroupChaos
              .child("chaos_is_searching")
              .set(false)
              .whenComplete(() {
                      refGroupChaos.child("chaos_is_alive").set(true);
              });
    
        }
      });
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    print("onrefresh");
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      print("111");

      itemCountValue = 20;
    });

    refreshController.refreshCompleted();
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
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 5,
    );
    File file = File(xfile!.path);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => ChatImagePicker(
              userAll: userAll,
              targetUid1: target1,
              targetUid2: target2,
              file: file,
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
        await uploadAttachment(userAll, result2.paths.first.toString(),
            refChatInterior, false, false, true, target1, target2);

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
          await uploadAttachment(userAll, result.paths.first.toString(),
              refChatInterior, false, true, false, target1, target2);
        } else {
          await uploadAttachment(userAll, result.paths.first.toString(),
              refChatInterior, true, false, false, target1, target2);
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
                              userMessageAdd(t1.text, false, "nothing");
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

                              uploadVoice(userAll, _filePath,
                                  refChatInterior, target1, target2);
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
                              userMessageAdd(t1.text, false, "nothing");
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

    itemCountValue = 20;
    _audioPlayer = AudioPlayer();
    isChaosSearching = false;
    user = auth.currentUser!;
    chaosGroupCancel = false;
    userAll = context.read<UserAllCubit>().state;

    refChatInterior = context.read<ChatReferenceCubit>().state;

    refUserMeta = refGetter(
        enum2: RefEnum.Usermeta,
        targetUid: "",
        userUid: userAll.isolaUserMeta.userUid,
        crypto: "");

    groupSettingModelForTrawling = context.read<GroupSettingCubit>().state;

    target1 = context.read<GroupSettingCubit>().state.groupMemberUid2;
    target2 = context.read<GroupSettingCubit>().state.groupMemberUid3;
    //refChatInterior = refGetter(
    //     enum2: RefEnum.Groupchatlist,
    //     targetUid: "",
    //     userUid: "",
    //  crypto: null);
    refGroupChaos = refGetter(
        enum2: RefEnum.Groupschaos,
        targetUid: "",
        userUid: "",
        crypto: context.read<GroupSettingCubit>().state.groupNo);

   

    groupChaosSearchingInfoGetter(
            context.read<GroupSettingCubit>().state.groupNo)
        .then((value) => isChaosSearching = value)
        .whenComplete(() {
      if (isChaosSearching == true &&
          _animationControllerChaosSearching.isAnimating == false) {
        _animationControllerChaosSearching.repeat();
         listenToChaosAlive();
    listenToChaosActive();


      }
    });

    Query chaosIsSearchingQuery = refGroupChaos.child("chaos_is_searching");

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
    print("sfafsa");

    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyMiddle: false,
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: true,
          //eğer stream yapılıyorsa önce uyarı ver //streamingchanges

          trailing: GestureDetector(
            onTap: () {
              //eğer stream yapılıyorsa önce uyarı ver //streamingchanges
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(groupSettingsPage);
              //  Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  /*buraya düşen süre yapılacak açılış tarihi 
                      ile datetime karşılaştırarak ama if verilecek
                      if bonus açıksa with bonus ile hesaplayacak
                  */

                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(

                        //groupNo print(context.read<GroupSettingCubit>().state.groupNo.toString());

                        //groupNo gerekli
                        onTap: () async {
                          if (isChaosSearching == true) {
                            print("hala search ediyor");
                            setState(() {
                              isChaosSearching = isChaosSearching;
                              if (_animationControllerChaosSearching
                                      .isAnimating ==
                                  false) {
                                _animationControllerChaosSearching.repeat();
                              } else {
                                print(
                                    "zaten search animasyonu çalışıyor kanka");
                              }
                            });
                          } else {
                            if (_animationControllerChaosStreaming
                                .isAnimating) {
                              print("işlem yapamazsın");
                            } else {
                              Query tokenQuery =
                                  refUserMeta.child("user_token");
                              DataSnapshot snap = await tokenQuery.get();
                              print(snap.value);
                              if (snap.value as int > 0) {
                                Query member_1Apply =
                                    refGroupChaos.child("member_1_apply");

                                print("coin var aga");
                                DataSnapshot snapMember1 =
                                    await member_1Apply.get();

                                if (snapMember1.value == false) {
                                  // snapMember i true yap
                                  //diğer üyelere mesaj gönderebilir

                                  print("snapMember1 false");

                                  if (_animationControllerChaos.isAnimating) {
                                    _animationControllerChaos.stop();
                                    _animationControllerChaos.reset();
                                  } else {
                                    await _animationControllerChaos.forward();
                                  }

                                  ///(/////)

                                  if (_animationControllerChaos.isCompleted) {
                                    refGroupChaos
                                        .child("member_1_apply")
                                        .set(true)
                                        .whenComplete(() async {
                                      //token valuesunu düşür
                                      bool member1Apply = true;
                                      bool member2Apply = false;
                                      bool member3Apply = false;
                                      print("baslaa");
                                      _animationControllerChaosStreaming
                                          .repeat();

                                      Stream<DatabaseEvent> streamCanceled =
                                          refGroupChaos
                                              .child("chaos_is_canceled")
                                              .onValue;
                                      Stream<DatabaseEvent> streamAlive =
                                          refGroupChaos
                                              .child("chaos_is_alive")
                                              .onValue;
                                      Stream<DatabaseEvent> streamMember1 =
                                          refGroupChaos
                                              .child("member_1_apply")
                                              .onValue;
                                      Stream<DatabaseEvent> streamMember2 =
                                          refGroupChaos
                                              .child("member_2_apply")
                                              .onValue;
                                      Stream<DatabaseEvent> streamMember3 =
                                          refGroupChaos
                                              .child("member_3_apply")
                                              .onValue;

                                      streamMember1.listen((event) {
                                        print(
                                            "MEMBER1 ${event.snapshot.value}");
                                        if (event.snapshot.value == false) {
                                          member1Apply = false;
                                        }
                                      });

                                      streamMember2.listen((event) {
                                        print(
                                            "MEMBER2 ${event.snapshot.value}");
                                        if (event.snapshot.value == true) {
                                          member2Apply = true;
                                        }
                                      });
                                      streamAlive.listen((event) {
                                        if (event.snapshot.value == true) {
                                          _animationControllerChaosSearching
                                              .stop();

                                          refGroupChaos
                                              .child("chaos_is_searching")
                                              .set(false);

                                          showCupertinoDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoAlertDialog(
                                                    content: Text(
                                                        "Chaos will start soon"),
                                                    actions: [
                                                      CupertinoButton(
                                                          child: Text("Go"),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                navigationBar);
                                                          })
                                                    ],
                                                  ));
                                        }
                                      });

                                      streamCanceled.listen((event) {
                                        print(
                                            "CANCELED ${event.snapshot.value}");
                                        if (event.snapshot.value == true) {
                                          print("iptal et");
                                          chaosGroupCancel = true;

                                          //token valuesunu geri al
                                          //animasyonu durdur
                                          //animasyon iptal edildi diye mesaj yolla
                                          _animationControllerChaosStreaming
                                              .stop();

                                          refGroupChaos
                                              .child("member_1_apply")
                                              .set(false)
                                              .whenComplete(() {
                                            refGroupChaos
                                                .child("chaos_is_canceled")
                                                .set(false)
                                                .whenComplete(() {
                                              showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          CupertinoAlertDialog(
                                                            title: Text(
                                                                "Matching was canceled"),
                                                            actions: [
                                                              CupertinoButton(
                                                                  child: Text(
                                                                      "Go HomePage"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        navigationBar);
                                                                  })
                                                            ],
                                                          ));
                                            });
                                          });
                                        }
                                      });

                                      streamMember3.listen((event) {
                                        print(
                                            "MEMBER3 ${event.snapshot.value}");
                                        if (event.snapshot.value == true) {
                                          member3Apply = true;

                                          if (member1Apply == true &&
                                              member2Apply == true &&
                                              member3Apply == true &&
                                              chaosGroupCancel == false) {
                                            _animationControllerChaosStreaming
                                                .stop();

                                            //bu silincek
                                            /*
                                            refGroupChaos
                                                .child("chaos_is_searching")
                                                .set(true);*/
                                            late bool myChaosSexOption;
                                            if (userAll.isolaUserDisplay.userSex == true) {
                                              myChaosSexOption = false;
                                            } else {
                                              myChaosSexOption = true;
                                            }

                                            var chaosItem = GroupChaos(
                                                "",
                                                false,
                                                10,
                                                true,
                                                true,
                                                true,
                                                myChaosSexOption,
                                                userAll.isolaUserDisplay.userIsNonBinary,
                                                userAll.isolaUserMeta.userIsValid,
                                                false,
                                                true);

                                            findChaosGroup(
                                                chaosItem,
                                                context
                                                    .read<GroupSettingCubit>()
                                                    .state);

                                            /*

                                            setState(() {
                                              isChaosSearching = true;
                                              _animationControllerChaosSearching
                                                  .repeat();
                                            });
*/
                                            //chaos find işlemi başlat
                                            //eğer bulursa

                                          }
                                        }
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 30000), () {
                                        if (_animationControllerChaosStreaming
                                            .isAnimating) {
                                          if (chaosGroupCancel == true ||
                                              member1Apply == false ||
                                              member2Apply == false ||
                                              member3Apply == false) {
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");
                                            print("İPTALLLLL");

                                            refGroupChaos
                                                .child("member_1_apply")
                                                .set(false)
                                                .whenComplete(() {
                                              if (chaosGroupCancel == true) {
                                                refGroupChaos
                                                    .child("chaos_is_canceled")
                                                    .set(false)
                                                    .whenComplete(() {
                                                  showCupertinoDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          CupertinoAlertDialog(
                                                            title: Text(
                                                                "Matching was canceled"),
                                                            actions: [
                                                              CupertinoButton(
                                                                  child: Text(
                                                                      "Go HomePage"),
                                                                  onPressed:
                                                                      () {
                                                                    _animationControllerChaosStreaming
                                                                        .stop();
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        navigationBar);
                                                                  })
                                                            ],
                                                          ));
                                                });
                                              } else {
                                                showCupertinoDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CupertinoAlertDialog(
                                                          title: Text(
                                                              "Matching was canceled"),
                                                          actions: [
                                                            CupertinoButton(
                                                                child: Text(
                                                                    "Go HomePage"),
                                                                onPressed: () {
                                                                  Navigator.pushReplacementNamed(
                                                                      context,
                                                                      navigationBar);
                                                                })
                                                          ],
                                                        ));
                                              }
                                            });

                                            //token valuesunu tekrardan yükselt

                                            //30 saniye geçti
                                            //diğer kişiler yanıt vermedi veya cancel etti
                                            //animasyon durdu mesajı yayınlat
                                            //kaç kişi yanıt vermedi yaz

                                          }
                                        }
                                      });

                                      //
                                      ///burada diğer kişilere bildirim atabiliriz..
                                      ///ve streame başlarız
                                      ///
                                      ///stream _controller
                                      ///eğer stream 3 true olursa ve canceled false olursa grubu açsın 30 saniye içinde
                                      ///stream functionu ekle buraya
                                      ///chaos groupfinder aç
                                      ///
                                    });
                                  } else {
                                    print("iptal etti");
                                  }

                                  //////////

                                } else {
                                  //eşleşmeyi başkası başlatmış
                                  Query queryChaosIsCanceled =
                                      await refGroupChaos
                                          .child("chaos_is_canceled");
                                  DataSnapshot snapChaosIsCanceled =
                                      await queryChaosIsCanceled.get();

                                  if (snapChaosIsCanceled.value == false) {
                                    if (_animationControllerChaos.isAnimating) {
                                      _animationControllerChaos.stop();
                                      _animationControllerChaos.reset();
                                    } else {
                                      await _animationControllerChaos.forward();
                                    }

                                    Query memberApply =
                                        refGroupChaos.child("member_2_apply");

                                    DataSnapshot snapMember2 =
                                        await memberApply.get();

                                    if (_animationControllerChaos.isCompleted) {
                                      if (snapMember2.value == false) {
                                        //bunuda member 2 apply ı onayla
                                        refGroupChaos
                                            .child("member_2_apply")
                                            .set(true)
                                            .whenComplete(() {
                                          _animationControllerChaosStreaming
                                              .repeat();
                                        });

                                        //token valuesunu düşür

                                        //burada animasyonu başlat ve member 3 ü ve canceled ı dinlemeye başla

                                        Stream<DatabaseEvent> streamMember1 =
                                            refGroupChaos
                                                .child("member_1_apply")
                                                .onValue;
                                        Stream<DatabaseEvent> streamCanceled =
                                            refGroupChaos
                                                .child("chaos_is_canceled")
                                                .onValue;
                                        Stream<DatabaseEvent> streamSearching =
                                            refGroupChaos
                                                .child("chaos_is_searching")
                                                .onValue;

                                        Stream<DatabaseEvent>
                                            streamChaosIsAlive = refGroupChaos
                                                .child("chaos_is_alive")
                                                .onValue;

                                        streamMember1.listen((event) {
                                          if (event.snapshot.value == false) {
                                            refGroupChaos
                                                .child("member_2_apply")
                                                .set(false)
                                                .whenComplete(() {
                                              showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          CupertinoAlertDialog(
                                                            title: Text(
                                                                "Matching was canceled"),
                                                            actions: [
                                                              CupertinoButton(
                                                                  child: Text(
                                                                      "Go HomePage"),
                                                                  onPressed:
                                                                      () {
                                                                    _animationControllerChaosStreaming
                                                                        .clearListeners();
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        navigationBar);
                                                                  })
                                                            ],
                                                          ));
                                            });
                                          }
                                        });

                                        streamCanceled.listen((event) {
                                          print(
                                              "CANCELED ${event.snapshot.value}");
                                          if (event.snapshot.value == true) {
                                            print("iptal et");
                                            chaosGroupCancel = true;
                                            //iptal et ve animasyonu durdur
                                            //token valuesunu yükselt
                                            showCupertinoDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        CupertinoAlertDialog(
                                                          title: Text(
                                                              "Matching was canceled"),
                                                          actions: [
                                                            CupertinoButton(
                                                                child: Text(
                                                                    "Go HomePage"),
                                                                onPressed: () {
                                                                  Navigator.pushReplacementNamed(
                                                                      context,
                                                                      navigationBar);
                                                                })
                                                          ],
                                                        ));
                                          }
                                        });

                                        streamChaosIsAlive.listen((event) {
                                          print(
                                              "Chaos Is Alive ${event.snapshot.value}");
                                          if (event.snapshot.value == true) {
                                            //
                                            //searching animasyonu başlat
                                            //alive sorgula
                                            //chaos finder başlatıldı
                                            //animasyonu dispose ettimi bak
                                            //chaos başlatıldı animasyonu yap ve yönlendir başka sayfaya
                                            _animationControllerChaosSearching
                                                .stop();
                                            showCupertinoDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CupertinoAlertDialog(
                                                      content: Text(
                                                          "Chaos will start soon"),
                                                      actions: [
                                                        CupertinoButton(
                                                            child: Text("Go"),
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  navigationBar);
                                                            })
                                                      ],
                                                    ));
                                          }
                                        });

                                        streamSearching.listen((event) {
                                          if (event.snapshot.value == true) {
                                            _animationControllerChaosStreaming
                                                .stop();
                                            _animationControllerChaosStreaming
                                                .reset();
                                            _animationControllerChaosSearching
                                                .repeat();
                                          }
                                        });
                                      } else {
                                        //member 2 onaylı
                                        //member 3 ü onayla ve diğer chaos ayarlarını yap

                                        if (_animationControllerChaos
                                            .isAnimating) {
                                          _animationControllerChaos.stop();
                                          _animationControllerChaos.reset();
                                        } else {
                                          await _animationControllerChaos
                                              .forward();
                                        }
                                        if (_animationControllerChaos
                                            .isCompleted) {
                                          refGroupChaos
                                              .child("member_3_apply")
                                              .set(true);

                                          Stream<DatabaseEvent>
                                              streamChaosIsAlive = refGroupChaos
                                                  .child("chaos_is_alive")
                                                  .onValue;

                                          Stream<DatabaseEvent> streamCanceled =
                                              refGroupChaos
                                                  .child("chaos_is_canceled")
                                                  .onValue;

                                          streamChaosIsAlive.listen((event) {
                                            print(
                                                "Chaos Is Alive ${event.snapshot.value}");
                                            if (event.snapshot.value == true) {
                                              showCupertinoDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CupertinoAlertDialog(
                                                        content: Text(
                                                            "Chaos will start soon"),
                                                        actions: [
                                                          CupertinoButton(
                                                              child: Text("Go"),
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    navigationBar);
                                                              })
                                                        ],
                                                      ));
                                              //chaos başlatıldı
                                              //animasyonu dispose ettimi bak
                                              //chaos başlatıldı animasyonu yap ve yönlendir başka sayfaya

                                            }
                                          });

                                          streamCanceled.listen((event) {
                                            print(
                                                "CANCELED ${event.snapshot.value}");
                                            if (event.snapshot.value == true) {
                                              print("iptal et");
                                              chaosGroupCancel = true;
                                              //iptal et ve animasyonu durdur
                                              //token valuesunu yükselt
                                              showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          CupertinoAlertDialog(
                                                            title: Text(
                                                                "Matching was canceled"),
                                                            actions: [
                                                              CupertinoButton(
                                                                  child: Text(
                                                                      "Go HomePage"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        navigationBar);
                                                                  })
                                                            ],
                                                          ));
                                            }
                                          });

                                          //animasyonu başlat arama animasyonunu
                                          //is valid i stream etmeye başla
                                          //bu yapıldığında ilk basan kişi stream ediyor ve sonucu görecek
                                        } else {
                                          print("iptal etti");
                                        }
                                      }
                                    } else {
                                      print("iptal etti");
                                    }
                                  } else {
                                    //chaos u birisi reddetmiş

                                    //test için

                                  }
                                }
                                //eğer member_1_

                                print("diğer kullanıcılara bildirim gönder");
                              } else {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: Text("You need coin"),
                                          actions: [
                                            CupertinoButton(
                                                child: Text("Watch Ads"),
                                                onPressed: () {
                                                  print("reklam izledi");
                                                  //token yükselt

                                                  print(
                                                      "izleme bitince coin kazandı");
                                                }),
                                            CupertinoButton(
                                                child: Text("No thanks"),
                                                onPressed: () {
                                                  print(
                                                      "izlemedi ve geri döndü");

                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ));
                              }
                            }
/*
                        
                         

                       
                         */

                            ////////////////////////

                            /*
                          final DateTime timeStamp =
                              DateTime.fromMillisecondsSinceEpoch(
                                  1645076199242);

                          int baslangic = 1645076199242;
                          int son = 1645076199242 + 1200000;
                          int bonuslu = 1645076199242 + 1200000 + 600000;

                          final DateTime timeStampBaslangic =
                              DateTime.fromMillisecondsSinceEpoch(baslangic);

                          final DateTime timeStampSon =
                              DateTime.fromMillisecondsSinceEpoch(son);

                          final DateTime timeStampBonuslu =
                              DateTime.fromMillisecondsSinceEpoch(bonuslu);

                          print(bonuslu - baslangic);

                          var ornekTime = DateTime.fromMillisecondsSinceEpoch(
                              bonuslu - baslangic);

                          //       print(
                          //     timeStampBonuslu.difference(timeStampBaslangic).);

                          //  print(DateTime.now().isAfter(timeStampBaslangic));
                          //print(DateTime.now().isBefore(timeStampSon));
                          //print(DateTime.now().isBefore(timeStampBonuslu));

                          var dd = <dynamic>[];

                          var feedMeta = HashMap<String, dynamic>();

                          feedMeta["feed_time"] = ServerValue.timestamp;
                          feedMeta["feed_date"] = "";
                          feedMeta["feed_no"] = "";
                          feedMeta["feed_image_url"] = "";
                          feedMeta["feed_text"] = "";
                          feedMeta["feed_is_image"] = false;
                          feedMeta["user_activities"] =
                              userDisplay.userActivities;
                          feedMeta["user_interest"] = userDisplay.userInterest;
                          feedMeta["like_list"] = dd;
                          feedMeta["like_value"] = 0;
                          feedMeta["user_friends"] = userDisplay.userFriends;
                          feedMeta["user_blocked"] = userDisplay.userBlocked;
                          feedMeta["user_uid"] = "";
                          feedMeta["user_name"] = userDisplay.userName;
                          feedMeta["user_biography"] =
                              userDisplay.userBiography;
                          feedMeta["user_avatar_url"] = userDisplay.avatarUrl;
                          feedMeta["user_university"] =
                              userDisplay.userUniversity;
                          feedMeta["user_sex"] = userDisplay.userSex;
                          feedMeta["user_is_online"] = userDisplay.userIsOnline;
                          feedMeta["user_is_valid"] = userDisplay.userIsValid;
                          feedMeta["user_is_non_binary"] =
                              userDisplay.userIsNonBinary;

                          var expRef = FirebaseDatabase.instance
                              .ref()
                              .child("example")
                              .child("examplechild");
                          expRef.set(feedMeta);
/*
                          int baslangic = 1645076199242;
                          int son = 1645076199242 + 1200000;
                          int bonuslu = 1645076199242 + 1200000 + 600000;

                          readTimestamp(1645076199242);
                          readTimestamp(1645076199242 + 1200000);
                          readTimestamp(1645076199242 + 1200000 + 600000);
                          print("//");
                          print(DateTime.now());
                          print(DateTime.now().day);

                          print("//*");
                          DateTime.fromMillisecondsSinceEpoch(1645076199242);
                          print("*//");
                          */
                          /*
                          if (_animationControllerChaos.isCompleted) {
                            _animationControllerChaos.reset();
                            _animationControllerChaos.forward();
                          } else {
                            _animationControllerChaos.forward();
                          }
                          */*/
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
                              child: Image.network(groupSettingModelForTrawling
                                  .groupMemberAvatarUrl2),
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
                              child: Image.network(
                                groupSettingModelForTrawling
                                    .groupMemberAvatarUrl3,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        )),
                  ),

                  /*
                  Padding(
                    padding: 100.h >= 1100
                        ? EdgeInsets.only(right: 4.w)
                        : EdgeInsets.only(right: 6.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleImageContainer(
                        circleImage: CircleAvatar(
                          radius: 13.sp,
                          backgroundColor: CupertinoColors.systemYellow,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.sp),
                            child: Image.network(groupSettingModelForTrawling
                                .groupMemberAvatarUrl3),
                          ),
                        ),
                      ),
                    ),
                  ),*/
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
                    child: StreamBuilder<dynamic>(
                        stream:
                            refChatInterior.limitToLast(itemCountValue).onValue,
                        builder: (context, event) {
                          if (event.hasData) {
                            var chatMessageDatas = <AllMessageBalloon>[];
                            var gettingChatMessage =
                                event.data.snapshot.value as Map;

                            if (gettingChatMessage != null) {
                              gettingChatMessage.forEach((key, value) {
                                var comingMessage =
                                    GroupChatMessage.fromJson(value);
                                if (context.read<ChatIsChaosCubit>().state ==
                                    true) {
                                  if (comingMessage.member_name ==
                                          "System Message" &&
                                      comingMessage
                                              .member_message_attachment_url ==
                                          "isola_system_message") {
                                    var msgBlnLeft = AllMessageBalloon(
                                      isMe: false,
                                      memberMessage:
                                          comingMessage.member_message,
                                      memberMessageTime:
                                          comingMessage.member_message_time,
                                      memberAvatarUrl:
                                          comingMessage.member_avatar_url,
                                      memberName: comingMessage.member_name,
                                      memberUid: comingMessage.member_uid,
                                      memberMessageIsVoice:
                                          comingMessage.member_message_isVoice,
                                      memberMessageVoiceUrl: comingMessage
                                          .member_message_voice_url,
                                      memberIsAttachment: comingMessage
                                          .member_message_isAttachment,
                                      memberIsImage:
                                          comingMessage.member_message_isImage,
                                      memberIsVideo:
                                          comingMessage.member_message_isVideo,
                                      memberIsDocument: comingMessage
                                          .member_message_isDocument,
                                      memberAttachmentUrl: comingMessage
                                          .member_message_attachment_url,
                                    );
                                    chatMessageDatas.add(msgBlnLeft);
                                  } else {
                                    if (comingMessage.member_uid == user.uid) {
                                      if (comingMessage
                                              .member_message_isVoice !=
                                          true) {
                                        var msgBlnRight = AllMessageBalloon(
                                          isMe: true,
                                          memberMessage:
                                              comingMessage.member_message,
                                          memberMessageTime:
                                              comingMessage.member_message_time,
                                          memberAvatarUrl:
                                              comingMessage.member_avatar_url,
                                          memberName: comingMessage.member_name,
                                          memberUid: comingMessage.member_uid,
                                          memberMessageIsVoice: comingMessage
                                              .member_message_isVoice,
                                          memberMessageVoiceUrl: comingMessage
                                              .member_message_voice_url,
                                          memberIsAttachment: comingMessage
                                              .member_message_isAttachment,
                                          memberIsImage: comingMessage
                                              .member_message_isImage,
                                          memberIsVideo: comingMessage
                                              .member_message_isVideo,
                                          memberIsDocument: comingMessage
                                              .member_message_isDocument,
                                          memberAttachmentUrl: comingMessage
                                              .member_message_attachment_url,
                                        );
                                        chatMessageDatas.add(msgBlnRight);
                                      } else {
                                        var msgBlnRightWithVoice =
                                            AllMessageBalloon(
                                          isMe: true,
                                          memberMessage:
                                              comingMessage.member_message,
                                          memberMessageTime:
                                              comingMessage.member_message_time,
                                          memberAvatarUrl:
                                              comingMessage.member_avatar_url,
                                          memberName: comingMessage.member_name,
                                          memberUid: comingMessage.member_uid,
                                          memberMessageIsVoice: comingMessage
                                              .member_message_isVoice,
                                          memberMessageVoiceUrl: comingMessage
                                              .member_message_voice_url,
                                          memberIsAttachment: comingMessage
                                              .member_message_isAttachment,
                                          memberIsImage: comingMessage
                                              .member_message_isImage,
                                          memberIsVideo: comingMessage
                                              .member_message_isVideo,
                                          memberIsDocument: comingMessage
                                              .member_message_isDocument,
                                          memberAttachmentUrl: comingMessage
                                              .member_message_attachment_url,
                                        );

                                        chatMessageDatas
                                            .add(msgBlnRightWithVoice);
                                      }
                                    } else {
                                      if (comingMessage
                                              .member_message_isVoice !=
                                          true) {
                                        var msgBlnLeft = AllMessageBalloon(
                                          isMe: false,
                                          memberMessage:
                                              comingMessage.member_message,
                                          memberMessageTime:
                                              comingMessage.member_message_time,
                                          memberAvatarUrl:
                                              comingMessage.member_avatar_url,
                                          memberName: comingMessage.member_name,
                                          memberUid: comingMessage.member_uid,
                                          memberMessageIsVoice: comingMessage
                                              .member_message_isVoice,
                                          memberMessageVoiceUrl: comingMessage
                                              .member_message_voice_url,
                                          memberIsAttachment: comingMessage
                                              .member_message_isAttachment,
                                          memberIsImage: comingMessage
                                              .member_message_isImage,
                                          memberIsVideo: comingMessage
                                              .member_message_isVideo,
                                          memberIsDocument: comingMessage
                                              .member_message_isDocument,
                                          memberAttachmentUrl: comingMessage
                                              .member_message_attachment_url,
                                        );
                                        chatMessageDatas.add(msgBlnLeft);
                                      } else {
                                        var msgBlnLeftWithVoiceMessage =
                                            AllMessageBalloon(
                                          isMe: false,
                                          memberMessage:
                                              comingMessage.member_message,
                                          memberMessageTime:
                                              comingMessage.member_message_time,
                                          memberAvatarUrl:
                                              comingMessage.member_avatar_url,
                                          memberName: comingMessage.member_name,
                                          memberUid: comingMessage.member_uid,
                                          memberMessageIsVoice: comingMessage
                                              .member_message_isVoice,
                                          memberMessageVoiceUrl: comingMessage
                                              .member_message_voice_url,
                                          memberIsAttachment: comingMessage
                                              .member_message_isAttachment,
                                          memberIsImage: comingMessage
                                              .member_message_isImage,
                                          memberIsVideo: comingMessage
                                              .member_message_isVideo,
                                          memberIsDocument: comingMessage
                                              .member_message_isDocument,
                                          memberAttachmentUrl: comingMessage
                                              .member_message_attachment_url,
                                        );
                                        chatMessageDatas
                                            .add(msgBlnLeftWithVoiceMessage);
                                      }
                                    }
                                  }
                                } else {
                                  if (comingMessage.member_uid == user.uid ||
                                      comingMessage.message_target_1_uid ==
                                          user.uid ||
                                      comingMessage.message_target_2_uid ==
                                          user.uid) {
                                    if (comingMessage.message_target_1_uid !=
                                            "firstmessage" &&
                                        comingMessage.message_target_2_uid !=
                                            "firstmessage") {
                                      if (comingMessage.member_uid ==
                                          user.uid) {
                                        if (comingMessage
                                                .member_message_isVoice !=
                                            true) {
                                          var msgBlnRight = AllMessageBalloon(
                                            isMe: true,
                                            memberMessage:
                                                comingMessage.member_message,
                                            memberMessageTime: comingMessage
                                                .member_message_time,
                                            memberAvatarUrl:
                                                comingMessage.member_avatar_url,
                                            memberName:
                                                comingMessage.member_name,
                                            memberUid: comingMessage.member_uid,
                                            memberMessageIsVoice: comingMessage
                                                .member_message_isVoice,
                                            memberMessageVoiceUrl: comingMessage
                                                .member_message_voice_url,
                                            memberIsAttachment: comingMessage
                                                .member_message_isAttachment,
                                            memberIsImage: comingMessage
                                                .member_message_isImage,
                                            memberIsVideo: comingMessage
                                                .member_message_isVideo,
                                            memberIsDocument: comingMessage
                                                .member_message_isDocument,
                                            memberAttachmentUrl: comingMessage
                                                .member_message_attachment_url,
                                          );
                                          chatMessageDatas.add(msgBlnRight);
                                        } else {
                                          var msgBlnRightWithVoice =
                                              AllMessageBalloon(
                                            isMe: true,
                                            memberMessage:
                                                comingMessage.member_message,
                                            memberMessageTime: comingMessage
                                                .member_message_time,
                                            memberAvatarUrl:
                                                comingMessage.member_avatar_url,
                                            memberName:
                                                comingMessage.member_name,
                                            memberUid: comingMessage.member_uid,
                                            memberMessageIsVoice: comingMessage
                                                .member_message_isVoice,
                                            memberMessageVoiceUrl: comingMessage
                                                .member_message_voice_url,
                                            memberIsAttachment: comingMessage
                                                .member_message_isAttachment,
                                            memberIsImage: comingMessage
                                                .member_message_isImage,
                                            memberIsVideo: comingMessage
                                                .member_message_isVideo,
                                            memberIsDocument: comingMessage
                                                .member_message_isDocument,
                                            memberAttachmentUrl: comingMessage
                                                .member_message_attachment_url,
                                          );

                                          chatMessageDatas
                                              .add(msgBlnRightWithVoice);
                                        }
                                      } else {
                                        if (comingMessage
                                                .member_message_isVoice !=
                                            true) {
                                          var msgBlnLeft = AllMessageBalloon(
                                            isMe: false,
                                            memberMessage:
                                                comingMessage.member_message,
                                            memberMessageTime: comingMessage
                                                .member_message_time,
                                            memberAvatarUrl:
                                                comingMessage.member_avatar_url,
                                            memberName:
                                                comingMessage.member_name,
                                            memberUid: comingMessage.member_uid,
                                            memberMessageIsVoice: comingMessage
                                                .member_message_isVoice,
                                            memberMessageVoiceUrl: comingMessage
                                                .member_message_voice_url,
                                            memberIsAttachment: comingMessage
                                                .member_message_isAttachment,
                                            memberIsImage: comingMessage
                                                .member_message_isImage,
                                            memberIsVideo: comingMessage
                                                .member_message_isVideo,
                                            memberIsDocument: comingMessage
                                                .member_message_isDocument,
                                            memberAttachmentUrl: comingMessage
                                                .member_message_attachment_url,
                                          );
                                          chatMessageDatas.add(msgBlnLeft);
                                        } else {
                                          var msgBlnLeftWithVoiceMessage =
                                              AllMessageBalloon(
                                            isMe: false,
                                            memberMessage:
                                                comingMessage.member_message,
                                            memberMessageTime: comingMessage
                                                .member_message_time,
                                            memberAvatarUrl:
                                                comingMessage.member_avatar_url,
                                            memberName:
                                                comingMessage.member_name,
                                            memberUid: comingMessage.member_uid,
                                            memberMessageIsVoice: comingMessage
                                                .member_message_isVoice,
                                            memberMessageVoiceUrl: comingMessage
                                                .member_message_voice_url,
                                            memberIsAttachment: comingMessage
                                                .member_message_isAttachment,
                                            memberIsImage: comingMessage
                                                .member_message_isImage,
                                            memberIsVideo: comingMessage
                                                .member_message_isVideo,
                                            memberIsDocument: comingMessage
                                                .member_message_isDocument,
                                            memberAttachmentUrl: comingMessage
                                                .member_message_attachment_url,
                                          );
                                          chatMessageDatas
                                              .add(msgBlnLeftWithVoiceMessage);
                                        }
                                      }
                                    }
                                  }
                                }
                              });
                            }
                            chatMessageDatas.sort((b, a) => a.memberMessageTime
                                .compareTo(b.memberMessageTime));

                            return chatMessageDatas.isEmpty
                                ? Column(
                                    children: const [],
                                  )
                                : SmartRefresher(
                                    enablePullUp: true,
                                    header: const ClassicHeader(),
                                    controller: refreshController,
                                    onRefresh: _onRefresh,
                                    onLoading: _onLoading,
                                    child: ListView.builder(
                                        reverse: true,
                                        itemCount: chatMessageDatas.length,
                                        itemBuilder:
                                            (context, indeksNumarasi) =>
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: chatMessageDatas[
                                                      indeksNumarasi],
                                                )),
                                  );
                          } else {
                            return Center(
                              child: CupertinoActivityIndicator(
                                  animating: true, radius: 12.sp),
                            );
                          }
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
      required this.memberAttachmentUrl})
      : super(key: key);

  final bool isMe;
  final String memberMessage;
  final String memberAvatarUrl;
  final int memberMessageTime;
  final String memberName;
  final String memberUid;
  final bool memberMessageIsVoice;
  final String memberMessageVoiceUrl;
  final bool memberIsAttachment;
  final bool memberIsImage;
  final bool memberIsVideo;
  final bool memberIsDocument;
  final String memberAttachmentUrl;

  @override
  Widget build(BuildContext context) {
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
                    )
                  : TextMessageBalloonLeft(
                      memberMessage: memberMessage,
                      memberMessageTime: memberMessageTime,
                      memberAvatarUrl: memberAvatarUrl,
                      memberName: memberName,
                      memberUid: memberUid,
                    ))
          : (memberMessageIsVoice == true
              ? VoiceMessageBalloonRight(
                  memberAvatarUrl: memberAvatarUrl,
                  memberMessageTime: memberMessageTime,
                  memberName: memberName,
                  memberUid: memberUid,
                  memberVoiceUrl: memberMessageVoiceUrl,
                )
              : memberIsAttachment == true
                  ? AttachmentMessageBalloonRight(
                      memberAttachmentUrl: memberAttachmentUrl,
                      memberAvatarUrl: memberAvatarUrl,
                      memberMessageTime: memberMessageTime,
                      memberName: memberName,
                      memberUid: memberUid,
                      memberMessageIsImage: memberIsImage,
                      memberMessageIsVideo: memberIsVideo,
                      memberMessageIsDocument: memberIsDocument)
                  : TextMessageBalloonRight(
                      memberMessage: memberMessage,
                      memberMessageTime: memberMessageTime,
                      memberAvatarUrl: memberAvatarUrl,
                      memberName: memberName,
                      memberUid: memberUid,
                    ));
    }
  }
}

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
}
