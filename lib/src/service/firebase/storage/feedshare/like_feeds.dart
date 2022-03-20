import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> likeAddToPool(
    String feedNo, String userUid, bool isLikeOrUnlike,String targetUid) async {
  DocumentReference likePoolRef =
      FirebaseFirestore.instance.collection('like_pool').doc();

  await likePoolRef.set({
    'like_or_unlike': isLikeOrUnlike,
    'target_feed_no': feedNo,
    'user_uid': userUid,
    'target_uid':targetUid
  });
}
