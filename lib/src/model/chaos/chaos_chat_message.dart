import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChaosChatMessage {
  late String member_avatar_url;
  late String member_message;
  late Timestamp member_message_time;
  late String member_name;
  late String member_uid;
  late bool member_message_isVoice;
  late String member_message_voice_url;
  late bool member_message_isAttachment;
  late String member_message_attachment_url;
  late bool member_message_isImage;
  late bool member_message_isVideo;
  late bool member_message_isDocument;
  late String message_target_1_uid;
  late String message_target_2_uid;
  late String message_target_3_uid;
  late String message_target_4_uid;
  late String message_target_5_uid;
  late String member_message_no;

  ChaosChatMessage(
      this.member_avatar_url,
      this.member_message,
      this.member_message_time,
      this.member_name,
      this.member_uid,
      this.member_message_isVoice,
      this.member_message_voice_url,
      this.member_message_isAttachment,
      this.member_message_attachment_url,
      this.member_message_isImage,
      this.member_message_isVideo,
      this.member_message_isDocument,
      this.message_target_1_uid,
      this.message_target_2_uid,
      this.message_target_3_uid,
      this.message_target_4_uid,
      this.message_target_5_uid,
      this.member_message_no);

  ChaosChatMessage.fromJson(Map<String, dynamic> json)
      : this(
          json["member_avatar_url"] as String,
          json["member_message"] as String,
          json["member_message_time"] as Timestamp,
          json["member_name"] as String,
          json["member_uid"] as String,
          json["member_message_isvoice"] as bool,
          json["member_message_voice_url"] as String,
          json["member_message_isattachment"] as bool,
          json["member_message_attachment_url"] as String,
          json["member_message_isimage"] as bool,
          json["member_message_isvideo"] as bool,
          json["member_message_isdocument"] as bool,
          json["member_message_target_1_uid"] as String,
          json["member_message_target_2_uid"] as String,
          json["member_message_target_3_uid"] as String,
          json["member_message_target_4_uid"] as String,
          json["member_message_target_5_uid"] as String,
          json["member_message_no"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'member_avatar_url': member_avatar_url,
      "member_message": member_message,
      "member_message_time": member_message_time,
      "member_name": member_name,
      "member_uid": member_uid,
      "member_message_isvoice": member_message_isVoice,
      "member_message_voice_url": member_message_voice_url,
      "member_message_isattachment": member_message_isAttachment,
      "member_message_attachment_url": member_message_attachment_url,
      "member_message_isimage": member_message_isImage,
      "member_message_isvideo": member_message_isVideo,
      "member_message_isdocument": member_message_isDocument,
      "member_message_target_1_uid": message_target_1_uid,
      "member_message_target_2_uid": message_target_2_uid,
      "member_message_target_3_uid": message_target_3_uid,
      "member_message_target_4_uid": message_target_4_uid,
      "member_message_target_5_uid": message_target_5_uid,
      "member_message_no": member_message_no
    };
  }
}
