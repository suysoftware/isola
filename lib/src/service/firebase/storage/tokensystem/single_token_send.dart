import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> singleTokenSend(
    String userUid, String targetUid, String targetFeedNo) async {
  DocumentReference tokenPoolRef =
      FirebaseFirestore.instance.collection('token_sending_pool').doc();

  await tokenPoolRef.set({
    'token_sender_uid': userUid,
    'token_target_uid': targetUid,
    'token_target_feed_no': targetFeedNo,
    'transfer_date': DateTime.now().toUtc(),
    'transfer_no': tokenPoolRef.id,
  });
}
