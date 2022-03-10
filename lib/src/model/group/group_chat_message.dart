// ignore_for_file: non_constant_identifier_names

class GroupChatMessage {
  late String member_avatar_url;
  late String member_message;
  late int member_message_time;
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
  

  GroupChatMessage(
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
      this.member_message_isDocument,this.message_target_1_uid,this.message_target_2_uid);

  factory GroupChatMessage.fromJson(Map<dynamic, dynamic> json) {
    return GroupChatMessage(
      json["member_avatar_url"] as String,
      json["member_message"] as String,
      json["member_message_time"] as int,
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
    );
  }
}
