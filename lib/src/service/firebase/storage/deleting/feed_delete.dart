import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> textFeedDelete(String targetFeed, String userUid) async {
  try {
    DocumentReference textFeedDeleteRef =
        FirebaseFirestore.instance.collection('text_feed_delete_pool').doc();

    textFeedDeleteRef.set({
      'orderNo': textFeedDeleteRef.id,
      'targetFeed': targetFeed,
      'userUid': userUid
    });
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}

Future<void> imageFeedDelete(String targetFeed, String userUid) async {
  try {
    DocumentReference imageFeedDeleteRef =
        FirebaseFirestore.instance.collection('image_feed_delete_pool').doc();

    imageFeedDeleteRef.set({
      'orderNo': imageFeedDeleteRef.id,
      'targetFeed': targetFeed,
      'userUid': userUid
    });
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
