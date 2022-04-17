// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
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

    if (context.read<UserAllCubit>().state.isolaUserDisplay.userIsNonBinary !=
        true) {
      if (context.read<UserAllCubit>().state.isolaUserDisplay.userSex == true) {
        isOther = false;
        isMale = true;
        isFemale = false;
      } else {
        isOther = false;
        isMale = false;
        isFemale = true;
      }
    }

    userName = context.read<UserAllCubit>().state.isolaUserDisplay.userName;
    userUniversity =
        context.read<UserAllCubit>().state.isolaUserDisplay.userUniversity;

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

                sizedBox3xH,
                sizedBoxH,
                //add Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                       LocaleKeys.main_name.tr(),
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
                      placeholder: LocaleKeys.main_yourname.tr(),
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
                      child:  Text(
                        LocaleKeys.main_surname,
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
                      placeholder: LocaleKeys.main_yoursurname.tr(),
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
                      child:  Text(
                       LocaleKeys.main_university.tr(),
                        style: StyleConstants.signUpTitlesTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 70.w,
                    height: 4.h,
                    child: CupertinoTextField(
                      readOnly: true,
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
                      placeholder: LocaleKeys.main_youruniversity.tr(),
                      placeholderStyle: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w100),
                    )),
                sizedBox3xH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child:  Text(
                       LocaleKeys.main_gender.tr(),
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
                              color: ColorConstant.accountEditButtonColor,
                              border: Border.all(width: 0.1),
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
                          child: Text(LocaleKeys.main_other.tr(),
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
                              color: ColorConstant.accountEditButtonColor,
                              border: Border.all(width: 0.1),
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
                          child: Text( LocaleKeys.main_male.tr(),
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
                          child: Text(LocaleKeys.main_female.tr(),
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
                              CollectionReference accountUpdateRef =
                                  FirebaseFirestore.instance
                                      .collection('users_display');

                              accountUpdateRef.doc(widget.userUid).update({
                                'uName': "${t1.text} ${t2.text}",
                                'uSex': isMale == true
                                    ? true
                                    : isFemale == true
                                        ? false
                                        : true,
                                'uNonBinary': isOther,
                              });

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
