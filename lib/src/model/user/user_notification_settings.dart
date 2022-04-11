// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotificationSettings {
  late bool chaos_messages;
  late bool group_messages;
  late bool likes;
  late bool new_matches;
  late bool system_notifications;
  late bool tokens;

  UserNotificationSettings(this.chaos_messages, this.group_messages, this.likes,
      this.new_matches, this.system_notifications, this.tokens);

  UserNotificationSettings.fromJson(Map<String, dynamic> json)
      : this(
          json["chaos_messages"] as bool,
          json["group_messages"] as bool,
          json["likes"] as bool,
          json["new_matches"] as bool,
          json["system_notifications"] as bool,
          json["tokens"] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'chaos_messages': chaos_messages,
      "group_messages": group_messages,
      "likes": likes,
      "new_matches": new_matches,
      "system_notifications": system_notifications,
      "tokens": tokens
    };
  }
}
