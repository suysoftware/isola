// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class SystemChatCont extends StatelessWidget {
  String targetMesaj;
  SystemChatCont({Key? key, required this.targetMesaj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 

    return Stack(
      children: [
        RichText(
          text: TextSpan(
              text: targetMesaj,
              style: 100.h >= 1100
                  ? StyleConstants.targetTabletChatMessageTextStyle
                  : StyleConstants.targetChatMessageTextStyle),
        ),
      ],
    );
  }
}
