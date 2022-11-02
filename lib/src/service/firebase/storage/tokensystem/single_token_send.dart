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

Future<void> earnToken(String userUid,String earnType) async {

if(earnType=='earn_rate'){

 DocumentReference tokenEarnPool =
      FirebaseFirestore.instance.collection('token_earn_pool').doc(userUid);

  await tokenEarnPool.set({
    'earner_uid': userUid,
    'operation_time': DateTime.now().toUtc(),
    'order_no': userUid,
    'earn_type':earnType
  });
}

else{
 DocumentReference tokenEarnPool =
      FirebaseFirestore.instance.collection('token_earn_pool').doc();

  await tokenEarnPool.set({
    'earner_uid': userUid,
    'operation_time': DateTime.now().toUtc(),
    'order_no': tokenEarnPool.id,
    'earn_type':earnType
  });


}


 
}
