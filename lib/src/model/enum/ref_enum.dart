// ignore_for_file: constant_identifier_names

import 'package:firebase_database/firebase_database.dart';

enum RefEnum {
  Userdisplay,
  Useravatar,
  Createuser,
  Usermeta,
  Userlikehistory,
  Searchfeeds,
  Searchfeedsget,
  Feedsdelete,
  Userexploredata,
  Likelist,
  LikeIt,
  LikeSave,
  LikeGet,
  Feedno,
  Usertextfeeds,
  Basereadfeeds,
  Basetargetreadfeeds,
  Timelineaddfeeds,
  Timelinereadfeeds,
  Groupdisplay,
  Groupdisplaytarget,
  Groupmeta,
  Groupmetatarget,
  Groupchatlist,
  Chaosgroupchatlist,
  Groupchatmembers,
  Usermetagrouplist,
  Feedreports,
  Groupschaos,
  Groupschaospreview,
  Chaosgroupchat,
  Chaosgroupdisplay,
  Chaosgroupmeta,
  Chaosfirstgroupmembers,
  Chaossecondgroupmembers,
  Feedtofeedtext,
  Feedcomesfromfeedtext,
  Sponsoredroad
}

DatabaseReference refGetter(
    {required RefEnum enum2,
    required String targetUid,
    required String userUid,
    required String crypto}) {
  switch (enum2) {
    case RefEnum.Userdisplay:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(targetUid)
            .child("user_display");
      }
    case RefEnum.Useravatar:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_display")
            .child("user_avatar_url");
      }
    case RefEnum.Createuser:
      {
        return FirebaseDatabase.instance.ref().child("users").child(targetUid);
      }

    case RefEnum.Usermeta:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_meta");
      }
    case RefEnum.Userlikehistory:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_like_history");
      }

    case RefEnum.Feedsdelete:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("text_feeds")
            .child(userUid)
            .child(crypto);
      }
    case RefEnum.Searchfeeds:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("image_feeds")
            .child(crypto);
      }
    case RefEnum.Searchfeedsget:
      {
        return FirebaseDatabase.instance.ref().child("image_feeds");
      }

    case RefEnum.Userexploredata:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_explore_data");
      }
    case RefEnum.Likelist:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("text_feeds")
            .child(targetUid)
            .child(crypto)
            .child("like_list");
      }
    case RefEnum.LikeIt:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("text_feeds")
            .child(targetUid)
            .child(crypto)
            .child("like_value");
      }
    case RefEnum.LikeSave:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_like_history")
            .child(crypto);
      }
    case RefEnum.LikeGet:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_like_history");
      }
    case RefEnum.Feedno:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("feeds")
            .child(targetUid)
            .child("feed_meta")
            .child(crypto)
            .child("feed_no");
      }
    case RefEnum.Usertextfeeds:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_text_feeds");
      }

    case RefEnum.Basereadfeeds:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("text_feeds")
            .child(userUid);
      }
    case RefEnum.Basetargetreadfeeds:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("text_feeds")
            .child(targetUid);
      }
    case RefEnum.Timelineaddfeeds:
      {
        return FirebaseDatabase.instance.ref().child("feeds").child(crypto);
      }
    case RefEnum.Timelinereadfeeds:
      {
        return FirebaseDatabase.instance.ref().child("feeds");
      }
    case RefEnum.Groupdisplay:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_display");
      }
    case RefEnum.Groupdisplaytarget:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_display")
            .child(crypto);
      }
    case RefEnum.Groupmeta:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_meta");
      }
    case RefEnum.Groupmetatarget:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_meta")
            .child(crypto);
      }
    case RefEnum.Groupchatlist:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_chat")
            .child(crypto)
            .child("group_chats_list");
      }
    case RefEnum.Chaosgroupchatlist:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_chat")
            .child(crypto)
            .child("chaos_group_chats_list");
      }
    case RefEnum.Groupchatmembers:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_chat")
            .child(crypto)
            .child("group_members");
      }

    case RefEnum.Usermetagrouplist:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userUid)
            .child("user_meta")
            .child("joined_group_list");
      }
    case RefEnum.Feedreports:
      {
        return FirebaseDatabase.instance.ref().child("feed_reports");
      }
    case RefEnum.Groupschaos:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_chaos")
            .child(crypto);
      }
    case RefEnum.Groupschaospreview:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("groups")
            .child("groups_chaos");
      }

    case RefEnum.Chaosgroupchat:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_chat");
      }

    case RefEnum.Chaosgroupdisplay:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_display");
      }

    case RefEnum.Chaosgroupmeta:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_meta");
      }

    case RefEnum.Chaosfirstgroupmembers:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_chat")
            .child(crypto)
            .child("chaos_group_members")
            .child("chaos_first_group_members");
      }
    case RefEnum.Chaossecondgroupmembers:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("chaos_groups")
            .child("chaos_groups_chat")
            .child(crypto)
            .child("chaos_group_members")
            .child("chaos_second_group_members");
      }
    case RefEnum.Feedtofeedtext:
      {
        return FirebaseDatabase.instance.ref().child("text_feeds").child(userUid);
      }
    case RefEnum.Feedcomesfromfeedtext:
      {
        return FirebaseDatabase.instance.ref().child("text_feeds");
      }
    case RefEnum.Sponsoredroad:
      {
        return FirebaseDatabase.instance
            .ref()
            .child("settings")
            .child("sponsored_settings")
            .child(crypto)
            .child("Timeline");
      }
  }
}
