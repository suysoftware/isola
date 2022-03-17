import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReportSheet extends StatelessWidget {
  const ReportSheet(
      {Key? key,
      required this.reporterUid,
      required this.targetUid1,
      required this.targetUid2,
      required this.isAllGroup,
      required this.groupNo})
      : super(key: key);

  final String reporterUid;
  final String targetUid1;
  final String targetUid2;
  final bool isAllGroup;
  final String groupNo;

  final String rt101 = 'rt101';
  final String rt102 = 'rt102';
  final String rt103 = 'rt103';
  final String rt104 = 'rt104';
  final String rt105 = 'rt105';

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Choose Reason !'),
      message: const Text('sebebini söyle aga '),
      actions: [
        CupertinoActionSheetAction(
          child: Text(rt101),
          onPressed: () async {
            if (isAllGroup == false) {
              DocumentReference reportRef =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              await reportRef.set({
                'reportGroup': groupNo,
                'reasonType': rt101,
                'reportNo': reportRef.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });
            } else {
              DocumentReference reportRef1 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              DocumentReference reportRef2 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

             await reportRef1.set({
                'reportGroup': groupNo,
                'reasonType': rt101,
                'reportNo': reportRef1.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });

             await reportRef2.set({
                'reportGroup': groupNo,
                'reasonType': rt101,
                'reportNo': reportRef2.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid2,
              });
            }

            print('/////////');
            print(reporterUid);
            print(targetUid1);
            print(targetUid2);
            print(isAllGroup);
            print(groupNo);
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt102),
            onPressed: () async {
            if (isAllGroup == false) {
              DocumentReference reportRef =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              await reportRef.set({
                'reportGroup': groupNo,
                'reasonType': rt102,
                'reportNo': reportRef.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });
            } else {
              DocumentReference reportRef1 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              DocumentReference reportRef2 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

             await reportRef1.set({
                'reportGroup': groupNo,
                'reasonType': rt102,
                'reportNo': reportRef1.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });

             await reportRef2.set({
                'reportGroup': groupNo,
                'reasonType': rt102,
                'reportNo': reportRef2.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid2,
              });
            }

            print('/////////');
            print(reporterUid);
            print(targetUid1);
            print(targetUid2);
            print(isAllGroup);
            print(groupNo);
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt103),
             onPressed: () async {
            if (isAllGroup == false) {
              DocumentReference reportRef =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              await reportRef.set({
                'reportGroup': groupNo,
                'reasonType': rt103,
                'reportNo': reportRef.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });
            } else {
              DocumentReference reportRef1 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              DocumentReference reportRef2 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

             await reportRef1.set({
                'reportGroup': groupNo,
                'reasonType': rt103,
                'reportNo': reportRef1.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });

             await reportRef2.set({
                'reportGroup': groupNo,
                'reasonType': rt103,
                'reportNo': reportRef2.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid2,
              });
            }

            print('/////////');
            print(reporterUid);
            print(targetUid1);
            print(targetUid2);
            print(isAllGroup);
            print(groupNo);
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt104),
     onPressed: () async {
            if (isAllGroup == false) {
              DocumentReference reportRef =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              await reportRef.set({
                'reportGroup': groupNo,
                'reasonType': rt104,
                'reportNo': reportRef.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });
            } else {
              DocumentReference reportRef1 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              DocumentReference reportRef2 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

             await reportRef1.set({
                'reportGroup': groupNo,
                'reasonType': rt104,
                'reportNo': reportRef1.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });

             await reportRef2.set({
                'reportGroup': groupNo,
                'reasonType': rt104,
                'reportNo': reportRef2.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid2,
              });
            }

            print('/////////');
            print(reporterUid);
            print(targetUid1);
            print(targetUid2);
            print(isAllGroup);
            print(groupNo);
            Navigator.pop(context);
          },
        ),
                CupertinoActionSheetAction(
          child: Text(rt105),
     onPressed: () async {
            if (isAllGroup == false) {
              DocumentReference reportRef =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              await reportRef.set({
                'reportGroup': groupNo,
                'reasonType': rt105,
                'reportNo': reportRef.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });
            } else {
              DocumentReference reportRef1 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

              DocumentReference reportRef2 =
                  FirebaseFirestore.instance.collection('reports_pool').doc();

             await reportRef1.set({
                'reportGroup': groupNo,
                'reasonType': rt105,
                'reportNo': reportRef1.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid1,
              });

             await reportRef2.set({
                'reportGroup': groupNo,
                'reasonType': rt105,
                'reportNo': reportRef2.id,
                'reportDate': DateTime.now().toUtc(),
                'reporterUid': reporterUid,
                'targetUid': targetUid2,
              });
            }

            print('/////////');
            print(reporterUid);
            print(targetUid1);
            print(targetUid2);
            print(isAllGroup);
            print(groupNo);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
