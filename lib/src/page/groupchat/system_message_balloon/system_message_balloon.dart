// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/groupchat/chat_interior_page.dart';
import 'package:isola_app/src/page/groupchat/system_message_balloon/system_chat_container.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_chat_container_left.dart';
import 'package:sizer/sizer.dart';

class SystemMessageBalloon extends StatelessWidget {
  String memberMessage;
  String memberAvatarUrl;
  int memberMessageTime;
  String memberName;
  String memberUid;

  SystemMessageBalloon(
      {Key? key,
      required this.memberMessage,
      required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSpacing = (memberMessage.length / 50) * 1.4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sizedBox,
        
        SizedBox(
 
          child: Column(
          
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 1.w),
                child: Text(
                  memberName,
                  style: 100.h <= 1100
                      ? StyleConstants.chatNameTextStyle1
                      : StyleConstants.chatTabletNameTextStyle1,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                child: SystemChatCont(
                  targetMesaj: memberMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
