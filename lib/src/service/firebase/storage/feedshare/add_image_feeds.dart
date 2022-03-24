import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addImageFeedToDatabase(String uid, String userAvatarUrl,
    String userName, String imageFeedUrl,String userUniversity,bool feedIsActivity) async {

Random random = new Random();
int randomNumber = random.nextInt(1000); 

  DocumentReference feedImageRef =
      FirebaseFirestore.instance.collection('image_feeds_pool').doc();

  await feedImageRef.set({
    'feed_image': imageFeedUrl,
    'feed_date': DateTime.now().add(Duration(minutes: randomNumber)).toUtc(),
    'user_uid': uid,
    'user_avatar_url': userAvatarUrl,
    'user_name': userName,
    'user_university':userUniversity,
    'feed_is_activity':feedIsActivity
  });
}
