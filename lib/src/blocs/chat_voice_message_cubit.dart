import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/group/group_chat_voice.dart';
import 'package:sizer/sizer.dart';

class ChatVoiceMessageCubit extends Cubit<GroupChatVoice> {
  // ignore: prefer_typing_uninitialized_variables
  var groupChatVoice;
  ChatVoiceMessageCubit({required this.groupChatVoice}) : super(groupChatVoice);

  double iconSize = 100.h >= 700 ? (100.h <= 1100 ? 18.sp : 11.sp) : 14.sp;

  Icon voiceIconReader(String itemUrl) {
    if (itemUrl == state.itemUrl) {
      return state.icon;
    } else {
      return Icon(
        CupertinoIcons.play_arrow_solid,
        size: iconSize,
      );
    }
  }

  Duration voiceDurationReader(String itemUrl) {
    if (itemUrl == state.itemUrl) {
      return state.duration;
    } else {
      return const Duration();
    }
  }

  void durationUpper(itemUrl) {
    Duration upDuration =
        Duration(milliseconds: state.duration.inMilliseconds + 200);
    var groupChatVoice = GroupChatVoice(state.icon, upDuration, itemUrl);

    emit(groupChatVoice);
  }

  void playing(Duration duration, String itemUrl) {
    var groupChatVoicePlaying = GroupChatVoice(
        Icon(
          CupertinoIcons.pause,
          size: iconSize,
        ),
        duration,
        itemUrl);
    emit(groupChatVoicePlaying);
  }

  void pause(Duration duration, String itemUrl) {
    var groupChatVoicePlaying = GroupChatVoice(
        Icon(
          CupertinoIcons.play,
          size: iconSize,
        ),
        duration,
        itemUrl);
    emit(groupChatVoicePlaying);
  }

  void resume(Duration duration, String itemUrl) {
    var groupChatVoicePlaying = GroupChatVoice(
        Icon(
          CupertinoIcons.pause,
          size: iconSize,
        ),
        duration,
        itemUrl);
    emit(groupChatVoicePlaying);
  }

  void replay(Duration duration, String itemUrl) {
    var groupChatVoicePlaying = GroupChatVoice(
        Icon(
          CupertinoIcons.arrow_clockwise_circle_fill,
          size: iconSize,
        ),
        duration,
        itemUrl);

    emit(groupChatVoicePlaying);
  }

  void loading(Duration duration, String itemUrl) {
    var groupChatVoicePlaying = GroupChatVoice(
        Icon(
          CupertinoIcons.arrow_counterclockwise,
          size: iconSize,
        ),
        duration,
        itemUrl);

    emit(groupChatVoicePlaying);
  }
}
