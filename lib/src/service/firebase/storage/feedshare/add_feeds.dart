// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';



Future<void> addTextFeedToDatabase(String uid, String feedText,String userAvatarUrl,String userName) async {
  DocumentReference feedTextRef =
      FirebaseFirestore.instance.collection('text_feeds_pool').doc();

  await feedTextRef.set({
    'feed_text': feedText,
    'feed_date': DateTime.now().toUtc(),
    'user_uid': uid,
    'user_avatar_url':userAvatarUrl,
    'user_name':userName
  
  });

}
