// ignore_for_file: implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key, required this.userUid}) : super(key: key);
  final String userUid;
  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage>
    with TickerProviderStateMixin {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  late AnimationController animationController;
  late Animation<double> checkBoxOpacity;
  bool checkbox = false;
  String userName = "";
  String userUniversity = "";
  checkBox() {
    if (animationController.isCompleted) {
      // animationController2.reverse();
      animationController.reverse();
      checkbox = false;
    } else {
      animationController.forward();
      checkbox = true;
    }
  }

  bool isOther = true;
  bool isMale = false;
  bool isFemale = false;

  bool nameFilled = true;
  bool surNameFilled = true;
  bool universityFilled = true;

  @override
  void initState() {
    super.initState();

    if (context.read<UserAllCubit>().state.isolaUserDisplay.userIsNonBinary != true) {
      if (context.read<UserAllCubit>().state.isolaUserDisplay.userSex == true) {
        isOther = false;
        isMale = true;
        isFemale = false;
      }
      else{
         isOther = false;
        isMale = false;
        isFemale = true;
      }
    }

    userName = context.read<UserAllCubit>().state.isolaUserDisplay.userName;
    userUniversity = context.read<UserAllCubit>().state.isolaUserDisplay.userUniversity;
    

    t1.text = userName.split(" ").first;
    t2.text = userName.split(" ").last;
    t3.text = userUniversity;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    checkBoxOpacity = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();

    t1.dispose();
    t2.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBoxH = SizedBox(
      height: 1.5.h,
    );
    var sizedBox3xH = SizedBox(
      height: 4.5.h,
    );
    var sizedBoxW = SizedBox(
      width: 6.w,
    );
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: true,
        ),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox3xH,

                //add picture circle

                sizedBox3xH,
                sizedBoxH,
                //add Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: const Text(
                        "Name",
                        style: StyleConstants.signUpTitlesTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 70.w,
                    height: 4.h,
                    child: CupertinoTextField(
                      maxLength: 15,
                      keyboardType: TextInputType.name,
                      onChanged: (s) {
                        if (t1.text.length < 2) {
                          nameFilled = false;
                          setState(() {});
                        } else {
                          nameFilled = true;
                          setState(() {});
                        }
                      },
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: nameFilled == true
                                  ? const BorderSide(
                                      width: 0.3,
                                      color: ColorConstant.softBlack)
                                  : const BorderSide(
                                      width: 1.0,
                                      color: ColorConstant.redAlert))),
                      controller: t1,
                      placeholder: "Your name",
                      placeholderStyle: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w100),
                    )),

                sizedBoxH,
                //Add Surname
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: const Text(
                        "Surname",
                        style: StyleConstants.signUpTitlesTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 70.w,
                    height: 4.h,
                    child: CupertinoTextField(
                      maxLength: 15,
                      onChanged: (t) {
                        if (t2.text.length < 2) {
                          surNameFilled = false;
                          setState(() {});
                        } else {
                          surNameFilled = true;
                          setState(() {});
                        }
                      },
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: surNameFilled == true
                                  ? const BorderSide(
                                      width: 0.3,
                                      color: ColorConstant.softBlack)
                                  : const BorderSide(
                                      width: 1.0,
                                      color: ColorConstant.redAlert))),
                      controller: t2,
                      placeholder: "Your surname",
                      placeholderStyle: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w100),
                    )),
                sizedBoxH,
                //Add University
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: const Text(
                        "University",
                        style: StyleConstants.signUpTitlesTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 70.w,
                    height: 4.h,
                    child: CupertinoTextField(
                      onChanged: (w) {
                        if (t3.text.length < 2) {
                          universityFilled = false;
                          setState(() {});
                        } else {
                          universityFilled = true;
                          setState(() {});
                        }
                      },
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: universityFilled == true
                                  ? const BorderSide(
                                      width: 0.3,
                                      color: ColorConstant.softBlack)
                                  : const BorderSide(
                                      width: 1.0,
                                      color: ColorConstant.redAlert))),
                      controller: t3,
                      placeholder: "Your University",
                      placeholderStyle: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w100),
                    )),
                sizedBox3xH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: const Text(
                        "Gender",
                        style: StyleConstants.signUpTitlesTextStyle,
                      ),
                    ),
                  ],
                ),
                sizedBoxH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Other Gender Button
                    Container(
                      width: 21.w,
                      height: 3.5.h,
                      decoration: isOther == true
                          ? BoxDecoration(
                              // gradient: ColorConstant.isolaMainGradient,
                              color: ColorConstant.accountEditButtonColor,
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.all(Radius.circular(7
                                  .sp)), /*
                              boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0.1,
                                      blurRadius: 1.0,
                                      blurStyle: BlurStyle.outer)
                                ]*/
                            )
                          : BoxDecoration(
                              color: ColorConstant.messageBoxGrey,
                              border: Border.all(width: 0.01),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.sp)),
                              boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0.02,
                                      blurRadius: 0.3,
                                      blurStyle: BlurStyle.outer)
                                ]),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CupertinoButton(
                          child: Text("OTHER",
                              style: isOther == true
                                  ? StyleConstants
                                      .signUpGenderButtonActiveTextStyle
                                  : StyleConstants
                                      .signUpGenderPassiveButtonTextStyle),
                          onPressed: () {
                            if (isOther == true) {
                              //Nothing
                            } else {
                              //change and setstate

                              setState(() {
                                isOther = true;
                                isMale = false;
                                isFemale = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    sizedBoxW,
                    // Male Genter Button
                    Container(
                      width: 21.w,
                      height: 3.5.h,
                      decoration: isMale == true
                          ? BoxDecoration(
  color: ColorConstant.accountEditButtonColor,                              border: Border.all(width: 0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.sp)),
                          )
                          : BoxDecoration(
                              color: ColorConstant.messageBoxGrey,
                              border: Border.all(width: 0.01),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.sp)),
                              boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0.02,
                                      blurRadius: 0.3,
                                      blurStyle: BlurStyle.outer)
                                ]),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CupertinoButton(
                          child: Text("MALE",
                              style: isMale == true
                                  ? StyleConstants
                                      .signUpGenderButtonActiveTextStyle
                                  : StyleConstants
                                      .signUpGenderPassiveButtonTextStyle),
                          onPressed: () {
                            if (isMale == true) {
                              //Nothing
                            } else {
                              //change and setstate

                              setState(() {
                                isOther = false;
                                isMale = true;
                                isFemale = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    sizedBoxW,
                    // Female Gender Button
                    Container(
                      width: 21.w,
                      height: 3.5.h,
                      decoration: isFemale == true
                          ? BoxDecoration(
                 color: ColorConstant.accountEditButtonColor,
                              border: Border.all(width: 0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.sp)),
                              boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0.1,
                                      blurRadius: 1.0,
                                      blurStyle: BlurStyle.outer)
                                ])
                          : BoxDecoration(
                              color: ColorConstant.messageBoxGrey,
                              border: Border.all(width: 0.01),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.sp)),
                           ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CupertinoButton(
                          child: Text("FEMALE",
                              style: isFemale == true
                                  ? StyleConstants
                                      .signUpGenderButtonActiveTextStyle
                                  : StyleConstants
                                      .signUpGenderPassiveButtonTextStyle),
                          onPressed: () {
                            if (isFemale == true) {
                              //Nothing
                            } else {
                              //change and setstate

                              setState(() {
                                isOther = false;
                                isMale = false;
                                isFemale = true;
                              });
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),

                sizedBoxH,
                sizedBoxH,

                sizedBoxH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 25.w,
                      height: 4.2.h,
                      decoration: BoxDecoration(
                        color: ColorConstant.accountEditButtonColor,
                        border: Border.all(width: 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                        /* boxShadow: const [
                            BoxShadow(
                                spreadRadius: 0.1,
                                blurRadius: 1.0,
                                blurStyle: BlurStyle.outer)
                          ]*/
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CupertinoButton(
                          child: Text("Update",
                              style: isOther == true
                                  ? StyleConstants
                                      .signUpGenderButtonActiveTextStyle
                                  : StyleConstants
                                      .signUpGenderPassiveButtonTextStyle),
                          onPressed: () {
                            if (t1.text.length > 2 &&
                                t2.text.length > 2 &&
                                t3.text.isNotEmpty) {
                              var refUserDisplay = refGetter(
                                  enum2: RefEnum.Userdisplay,
                                  targetUid: widget.userUid,
                                  userUid: widget.userUid,
                                  crypto: "");

                              refUserDisplay
                                  .child("user_name")
                                  .set("${t1.text} ${t2.text}");
                              refUserDisplay
                                  .child("user_university")
                                  .set(t3.text);

                              refUserDisplay
                                  .child("user_sex")
                                  .set(isMale == true
                                      ? true
                                      : isFemale == true
                                          ? false
                                          : true);

                              refUserDisplay
                                  .child("user_is_non_binary")
                                  .set(isOther);
                              FocusScope.of(context).requestFocus(FocusNode());
                              //resim yok
                              Navigator.pop(context);
                            } else {
                              showCupertinoDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content: const Text(
                                            "You have to fill all bar"),
                                        actions: [
                                          CupertinoButton(
                                              child: const Text("Okey"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ));
  }
}
