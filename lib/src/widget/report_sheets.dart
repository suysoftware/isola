import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/model/group/group_setting_model.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import '../service/firebase/storage/groups/group_leave.dart';

Future<void> addToReportPool(String groupNo, String reasonType,
    String reporterUid, String targetUid) async {
  DocumentReference reportRef =
      FirebaseFirestore.instance.collection('reports_pool').doc();
  await reportRef.set({
    'reportGroup': groupNo,
    'reasonType': reasonType,
    'reportNo': reportRef.id,
    'reportDate': DateTime.now().toUtc(),
    'reporterUid': reporterUid,
    'targetUid': targetUid,
  });
}

Future<void> addFeedToReportPool(String reasonType, String reporterUid,
    bool isImageFeed, String feedNo, String targetUid) async {
  DocumentReference reportRef =
      FirebaseFirestore.instance.collection('feed_reports_pool').doc();
  await reportRef.set({
    'reportFeedNo': feedNo,
    'reasonType': reasonType,
    'reportIsImage': isImageFeed,
    'reportNo': reportRef.id,
    'reportDate': DateTime.now().toUtc(),
    'reporterUid': reporterUid,
    'targetUid': targetUid,
  });
}

class ReportSheet extends StatelessWidget {
  const ReportSheet(
      {Key? key,
      required this.reporterUid,
      required this.targetUid1,
      required this.targetUid2,
      required this.isAllGroup,
      required this.groupNo,
      required this.groupSettingModel})
      : super(key: key);

  final String reporterUid;
  final String targetUid1;
  final String targetUid2;
  final bool isAllGroup;
  final String groupNo;
  final GroupSettingModel groupSettingModel;

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
            onPressed: () {
              if (isAllGroup == false) {
                addToReportPool(groupNo, rt101, reporterUid, targetUid1);
                leaveGroup(groupSettingModel).whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    Navigator.pushReplacementNamed(context, navigationBar);
                  });
                });
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const AnimatedLiquidCircularProgressIndicator());
              } else {
                addToReportPool(groupNo, rt101, reporterUid, targetUid1);
                addToReportPool(groupNo, rt101, reporterUid, targetUid2);
                leaveGroup(groupSettingModel).whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    Navigator.pushReplacementNamed(context, navigationBar);
                  });
                });
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const AnimatedLiquidCircularProgressIndicator());
              }
            }),
        CupertinoActionSheetAction(
          child: Text(rt102),
          onPressed: () {
            if (isAllGroup == false) {
              addToReportPool(groupNo, rt102, reporterUid, targetUid1);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              addToReportPool(groupNo, rt102, reporterUid, targetUid1);
              addToReportPool(groupNo, rt102, reporterUid, targetUid2);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt103),
          onPressed: () {
            if (isAllGroup == false) {
              addToReportPool(groupNo, rt103, reporterUid, targetUid1);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              addToReportPool(groupNo, rt103, reporterUid, targetUid1);
              addToReportPool(groupNo, rt103, reporterUid, targetUid2);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt104),
          onPressed: () {
            if (isAllGroup == false) {
              addToReportPool(groupNo, rt104, reporterUid, targetUid1);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              addToReportPool(groupNo, rt104, reporterUid, targetUid1);
              addToReportPool(groupNo, rt104, reporterUid, targetUid2);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt105),
          onPressed: () {
            if (isAllGroup == false) {
              addToReportPool(groupNo, rt105, reporterUid, targetUid1);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              addToReportPool(groupNo, rt105, reporterUid, targetUid1);
              addToReportPool(groupNo, rt105, reporterUid, targetUid2);
              leaveGroup(groupSettingModel).whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

class ReportFeedSheet extends StatelessWidget {
  const ReportFeedSheet(
      {Key? key,
      required this.reporterUid,
      required this.isImageFeed,
      required this.feedNo,
      required this.targetUid})
      : super(key: key);

  final String reporterUid;
  final bool isImageFeed;
  final String feedNo;
  final String targetUid;

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
            onPressed: () {
              if (isImageFeed == true) {
//reporting feed is image feed

                addFeedToReportPool(rt101, reporterUid, true, feedNo, targetUid)
                    .whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    Navigator.pushReplacementNamed(context, navigationBar);
                  });
                });

                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const AnimatedLiquidCircularProgressIndicator());
              } else {
                //feed is not image feed

                addFeedToReportPool(
                        rt101, reporterUid, false, feedNo, targetUid)
                    .whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    Navigator.pushReplacementNamed(context, navigationBar);
                  });
                });

                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const AnimatedLiquidCircularProgressIndicator());
              }

              //  Navigator.pop(context);
            }),
        CupertinoActionSheetAction(
          child: Text(rt102),
          onPressed: () {
            if (isImageFeed == true) {
//reporting feed is image feed

              addFeedToReportPool(rt102, reporterUid, true, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              //feed is not image feed

              addFeedToReportPool(rt102, reporterUid, false, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt103),
          onPressed: () {
            if (isImageFeed == true) {
//reporting feed is image feed

              addFeedToReportPool(rt103, reporterUid, true, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              //feed is not image feed

              addFeedToReportPool(rt103, reporterUid, false, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt104),
          onPressed: () {
            if (isImageFeed == true) {
//reporting feed is image feed

              addFeedToReportPool(rt104, reporterUid, true, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              //feed is not image feed

              addFeedToReportPool(rt104, reporterUid, false, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(rt105),
          onPressed: () {
            if (isImageFeed == true) {
//reporting feed is image feed

              addFeedToReportPool(rt105, reporterUid, true, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            } else {
              //feed is not image feed

              addFeedToReportPool(rt105, reporterUid, false, feedNo, targetUid)
                  .whenComplete(() {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  Navigator.pushReplacementNamed(context, navigationBar);
                });
              });

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const AnimatedLiquidCircularProgressIndicator());
            }
          },
        ),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'))
      ],
    );
  }
}
