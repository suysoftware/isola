import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> groupChaosApply(String uid, String groupNo) async {
  DocumentReference groupChaosApplyRef =
      FirebaseFirestore.instance.collection('chaos_apply_pool').doc(uid);

  groupChaosApplyRef.set({
    
    'memberUid':uid,
    'groupNo':groupNo,
    'operationTime':DateTime.now().add(const Duration(minutes: 7)).toUtc(),
    
    
    });
}
