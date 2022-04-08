// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, avoid_print

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/blocs/chat_voice_message_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/group/group_chat_voice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

double fontVoiceTextSize = 100.h <= 1100 ? 8.sp : 6.sp;
double thumbRadius = 100.h <= 1100 ? 5.sp : 3.sp;
double voicePadding = 100.h <= 1100 ? 6.w : 4.5.w;
double playerWidth = 100.h <= 1100 ? 50.w : 55.w;

class VoiceChatContLeft extends StatelessWidget {
  String memberVoiceUrl;
  String memberName;
  Timestamp messageTime;
  VoiceChatContLeft(
      {Key? key, required this.memberVoiceUrl, required this.memberName,required this.messageTime})
      : super(key: key);
  var playIcon = const Icon(CupertinoIcons.play_arrow_solid);
  var pauseIcon = const Icon(CupertinoIcons.pause);
  var resumeIcon = const Icon(CupertinoIcons.play);
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
         DateFormat dFormat = DateFormat("HH:mm");

    double contHeight = 100.h <= 1100 ? 2 : 1;
    double topRight = (contHeight * 2 + 6.5) * 3;
    double bottomRight = (contHeight * 2 + 6.5) * 3;
    double bottomLeft = (contHeight + 8) * 3;
    return BlocBuilder<ChatVoiceMessageCubit, GroupChatVoice>(
        builder: (context, groupChatType) {
      return Container(
        width: 70.w,
        height: 100.h <= 1100 ? (contHeight * 2 + 4).h : (contHeight * 2 + 4).h,
        decoration: BoxDecoration(
            gradient: ColorConstant.isolaMainGradient,
            border: Border.all(color: ColorConstant.transparentColor),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
              bottomLeft: Radius.circular(bottomLeft),
            )),
        child: Padding(
            padding: const EdgeInsets.all(0.5),
            child: Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  color: ColorConstant.messageBoxGrey,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(topRight),
                    bottomRight: Radius.circular(bottomRight),
                    bottomLeft: Radius.circular(bottomLeft),
                  )),
              child: FutureBuilder<int>(
                  future: _audioPlayer.getDuration(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text("Voice Error !");
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Container(
                          padding: const EdgeInsets.all(1.0),
                          child: Consumer<ChatVoiceMessageCubit>(
                              builder: (context, voiceStatus, child) {
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CupertinoButton(
                                    child: voiceStatus
                                        .voiceIconReader(memberVoiceUrl),
                                    onPressed: () async {
                                      final url = memberVoiceUrl;

                                      if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          playIcon.icon) {
                                        //  await _audioPlayer.resume();
                                        voiceStatus.playing(
                                            duration, memberVoiceUrl);

                                        await _audioPlayer.play(url);
                                      } else if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          pauseIcon.icon) {
                                        voiceStatus.pause(
                                            duration, memberVoiceUrl);

                                        await _audioPlayer.pause();
                                      } else if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          resumeIcon) {
                                        voiceStatus.resume(
                                            Duration(
                                                seconds: position.inSeconds),
                                            memberVoiceUrl);
                                        await _audioPlayer.resume();
                                      } else {
                                        voiceStatus.loading(
                                            duration, memberVoiceUrl);
                                        //animasyonu başlat

                                        await _audioPlayer.play(url);
                                        voiceStatus.playing(
                                            duration, memberVoiceUrl);
                                      }

                                      _audioPlayer.onDurationChanged
                                          .listen((Duration d) {
                                        //    voiceStatus
                                        //    .playing(d, memberVoiceUrl);

                                        duration = duration;
                                      });
                                      _audioPlayer.onAudioPositionChanged
                                          .listen((Duration p) {
                                        //  voiceStatus
                                        //      .playing(p, memberVoiceUrl);
                                        voiceStatus
                                            .durationUpper(memberVoiceUrl);
                                        position = p;
                                      });

                                      _audioPlayer.onPlayerCompletion
                                          .listen((event) {
                                        voiceStatus.replay(
                                            const Duration(), memberVoiceUrl);

                                        duration = const Duration();
                                        position = const Duration();
                                      });
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 5.w, 0.3.h),
                                    child: Text(
'11:30'                         ,             style: 100.h <= 1100
                                          ? StyleConstants.chatTimeTextStyleLeft
                                          : StyleConstants
                                              .chatTabletTimeTextStyleLeft,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: playerWidth,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: voicePadding),
                                      child: ProgressBar(
                                        thumbRadius: thumbRadius,
                                        barHeight: 3.0,
                                        timeLabelTextStyle: TextStyle(
                                            fontSize: fontVoiceTextSize,
                                            color: ColorConstant.softBlack),
                                        timeLabelLocation:
                                            TimeLabelLocation.sides,
                                        progress: Duration(
                                            seconds: position.inSeconds),
                                        total: snapshot.hasData
                                            ? Duration(
                                                milliseconds:
                                                    snapshot.requireData)
                                            : const Duration(milliseconds: 10),
                                        onSeek: (duration) {
                                          _audioPlayer.seek(duration);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        return Container(
                          padding: const EdgeInsets.all(1.0),
                          child: Consumer<ChatVoiceMessageCubit>(
                              builder: (context, voiceStatus, child) {
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CupertinoButton(
                                    child: voiceStatus
                                        .voiceIconReader(memberVoiceUrl),
                                    onPressed: () async {
                                      final url = memberVoiceUrl;

                                      if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          playIcon.icon) {
                                      //  print("abidik");
                                        //  await _audioPlayer.resume();
                                        voiceStatus.playing(
                                            duration, memberVoiceUrl);
                                        await _audioPlayer.play(url);
                                      } else if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          pauseIcon.icon) {
                                        voiceStatus.pause(
                                            duration, memberVoiceUrl);
                                        await _audioPlayer.pause();
                                      } else if (voiceStatus
                                              .voiceIconReader(memberVoiceUrl)
                                              .icon ==
                                          resumeIcon.icon) {
                                      //  print("resume girdi");
                                        voiceStatus.resume(
                                            Duration(
                                                seconds: position.inSeconds),
                                            memberVoiceUrl);
                                        await _audioPlayer.resume();
                                      } else {
                                      //  print("gubidik");
                                        voiceStatus.loading(
                                            duration, memberVoiceUrl);
                                        //animasyonu başlat

                                        await _audioPlayer.play(url);
                                        voiceStatus.playing(
                                            duration, memberVoiceUrl);
                                      }

                                      _audioPlayer.onDurationChanged
                                          .listen((Duration d) {
                                        //    voiceStatus
                                        //    .playing(d, memberVoiceUrl);

                                        duration = duration;
                                      });
                                      _audioPlayer.onAudioPositionChanged
                                          .listen((Duration p) {
                                        //  voiceStatus
                                        //      .playing(p, memberVoiceUrl);
                                        voiceStatus
                                            .durationUpper(memberVoiceUrl);
                                        position = p;
                                      });

                                      _audioPlayer.onPlayerCompletion
                                          .listen((event) {
                                        voiceStatus.replay(
                                            const Duration(), memberVoiceUrl);

                                        duration = const Duration();
                                        position = const Duration();
                                      });
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 5.w, 0.3.h),
                                    child: Text(
                  '${dFormat.format(DateTime.fromMicrosecondsSinceEpoch(messageTime.microsecondsSinceEpoch.toInt(), isUtc: false))}',
                                      style: 100.h <= 1100
                                          ? StyleConstants.chatTimeTextStyleLeft
                                          : StyleConstants
                                              .chatTabletTimeTextStyleLeft,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: voicePadding),
                                    child: SizedBox(
                                      width: playerWidth,
                                      child: ProgressBar(
                                        thumbRadius: thumbRadius,
                                        barHeight: 3.0,
                                        timeLabelTextStyle: TextStyle(
                                            fontSize: fontVoiceTextSize,
                                            color: ColorConstant.softBlack),
                                        timeLabelLocation:
                                            TimeLabelLocation.sides,
                                        progress: Duration(
                                            seconds: position.inSeconds),
                                        total: snapshot.hasData
                                            ? Duration(
                                                milliseconds:
                                                    snapshot.requireData)
                                            : const Duration(milliseconds: 10),
                                        onSeek: (duration) {
                                          _audioPlayer.seek(duration);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        );
                    }
                  }),
            )),
      );
    });
  }
}
