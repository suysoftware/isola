import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> likeAddToPool(
    String feedNo, String uid, bool isLikeOrUnlike,String targetUid) async {
  DocumentReference likePoolRef =
      FirebaseFirestore.instance.collection('like_pool').doc();

  await likePoolRef.set({
    'like_or_unlike': isLikeOrUnlike,
    'target_feed_no': feedNo,
    'user_uid': uid,
    'target_uid':targetUid
  });
}
