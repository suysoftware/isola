import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';

class ChattingMessageNotificationMini extends StatelessWidget {
  final int notiValue;

  const ChattingMessageNotificationMini({
    Key? key,
    required this.notiValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.milkColor, width: 1.0),
          color: ColorConstant.milkColor,
          borderRadius: BorderRadius.all(Radius.circular(20.h))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.h),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            " $notiValue ",
            style: StyleConstants.softMilkTextStyle,
          ),
        ),
      ),
    );
  }
}
