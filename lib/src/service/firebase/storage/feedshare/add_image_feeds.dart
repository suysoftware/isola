import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addImageFeedToDatabase(
    {required String uid,
    required String userAvatarUrl,
    required String userName,
    required String imageFeedUrl,
    required String userUniversity,
    required bool feedIsActivity}) async {

  DocumentReference feedImageRef =
      FirebaseFirestore.instance.collection('image_feeds_pool').doc();

  await feedImageRef.set({
    'feed_image': imageFeedUrl,
    'feed_date': DateTime.now().toUtc(),
    'user_uid': uid,
    'user_avatar_url': userAvatarUrl,
    'user_name': userName,
    'user_university': userUniversity,
    'feed_is_activity': feedIsActivity,
  });
}
