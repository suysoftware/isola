import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addImageFeedToDatabase(String uid, String userAvatarUrl,
    String userName, String imageFeedUrl) async {
  DocumentReference feedImageRef =
      FirebaseFirestore.instance.collection('image_feeds_pool').doc();

  await feedImageRef.set({
    'feed_image': imageFeedUrl,
    'feed_date': DateTime.now().toUtc(),
    'user_uid': uid,
    'user_avatar_url': userAvatarUrl,
    'user_name': userName
  });
}
