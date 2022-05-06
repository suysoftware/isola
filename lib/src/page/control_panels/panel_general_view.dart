import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class PanelGeneralView extends StatefulWidget {
  const PanelGeneralView({Key? key}) : super(key: key);

  @override
  State<PanelGeneralView> createState() => _PanelGeneralViewState();
}

class _PanelGeneralViewState extends State<PanelGeneralView>
    with TickerProviderStateMixin {
  int totalUserValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text('Isola Statistics'),
          Text('Users : $totalUserValue'),
          Text('Male: '),
          Text('Female: '),
          Text('Other: '),
          Text('Total Group:'),
          Text('Active Group:'),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          Text(''),
          CupertinoButton(
              child: Text('reload'),
              onPressed: () {
                var reloadRef = FirebaseFirestore.instance
                    .collection('panel_statistics')
                    .doc('isola_stats')
                    .collection('reload_stats')
                    .doc();

                reloadRef.set({

                  'halo':'mrb'
                });
                setState(() {});
              })
        ],
      ),
    ));
  }
}
