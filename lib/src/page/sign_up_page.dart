// ignore_for_file: implementation_imports, avoid_print, must_be_immutable, avoid_init_to_null

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/sign_up_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/sign_up.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/interest_add_page.dart';
import 'package:isola_app/src/page/terms_privacy/agree_terms.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.userAll}) : super(key: key);
  final IsolaUserAll userAll;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  late AnimationController animationController;
  late Animation<double> checkBoxOpacity;
  bool checkbox = false;
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

    animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    checkBoxOpacity = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    ///burası değiştirilecek otomati kolarak okulunun ism iyazılacak
    t3.text = "Tilburg University";
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
          child: Column(children: [
            sizedBox3xH,

            //add picture circle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    height: 130.sp,
                    width: 130.sp,
                    color: ColorConstant.messageBoxGrey,
                    child: context
                                .read<SignUpCubit>()
                                .state
                                .signUpPicturePath !=
                            "null"
                        ? Image.file(
                            File(context
                                .read<SignUpCubit>()
                                .state
                                .signUpPicturePath),
                            fit: BoxFit.cover,
                          )
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                              height: 50.sp,
                              width: 50.sp,
                              child: Center(
                                child: CupertinoButton(
                                  child: Image.asset(
                                    "asset/img/search_page_cam_icon.png",
                                  ),
                                  onPressed: () async {
                                    if (t1.text.length < 2 ||
                                        t2.text.length < 2 ||
                                        t3.text.isEmpty) {
                                      showCupertinoDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
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
                                    } else {
                                      var signUp = SignUp(
                                          "",
                                          t1.text,
                                          t2.text,
                                          t3.text,
                                          isMale == true
                                              ? true
                                              : isFemale == true
                                                  ? false
                                                  : true,
                                          isOther);
                                      context.read<SignUpCubit>().signUpChange(
                                          "null",
                                          signUp.signUpName,
                                          signUp.signUpSurname,
                                          signUp.signUpUniversity,
                                          signUp.signUpGender,
                                          signUp.signUpNonBinary);

                                      showCupertinoDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) =>
                                              Center(
                                                child:
                                                    AddProfileSignUpPhotoContainer(
                                                  signUp: signUp,
                                                ),
                                              ));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),

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
                                  width: 0.3, color: ColorConstant.softBlack)
                              : const BorderSide(
                                  width: 1.0, color: ColorConstant.redAlert))),
                  controller: t1,
                  placeholder: "Your name",
                  placeholderStyle:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),
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
                                  width: 0.3, color: ColorConstant.softBlack)
                              : const BorderSide(
                                  width: 1.0, color: ColorConstant.redAlert))),
                  controller: t2,
                  placeholder: "Your surname",
                  placeholderStyle:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),
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
                  readOnly: true,
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
                                  width: 0.3, color: ColorConstant.softBlack)
                              : const BorderSide(
                                  width: 1.0, color: ColorConstant.redAlert))),
                  controller: t3,
                  placeholder: "Your University",
                  placeholderStyle:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),
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
                          gradient: ColorConstant.isolaMainGradient,
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                          boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 0.1,
                                  blurRadius: 1.0,
                                  blurStyle: BlurStyle.outer)
                            ])
                      : BoxDecoration(
                          color: ColorConstant.messageBoxGrey,
                          border: Border.all(width: 0.01),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
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
                              ? StyleConstants.signUpGenderButtonActiveTextStyle
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
                          gradient: ColorConstant.isolaMainGradient,
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                          boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 0.1,
                                  blurRadius: 1.0,
                                  blurStyle: BlurStyle.outer)
                            ])
                      : BoxDecoration(
                          color: ColorConstant.messageBoxGrey,
                          border: Border.all(width: 0.01),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
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
                              ? StyleConstants.signUpGenderButtonActiveTextStyle
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
                          gradient: ColorConstant.isolaMainGradient,
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                          boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 0.1,
                                  blurRadius: 1.0,
                                  blurStyle: BlurStyle.outer)
                            ])
                      : BoxDecoration(
                          color: ColorConstant.messageBoxGrey,
                          border: Border.all(width: 0.01),
                          borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                          boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 0.02,
                                  blurRadius: 0.3,
                                  blurStyle: BlurStyle.outer)
                            ]),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CupertinoButton(
                      child: Text("FEMALE",
                          style: isFemale == true
                              ? StyleConstants.signUpGenderButtonActiveTextStyle
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    checkBox();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 6.w,
                        width: 6.w,
                        child: Container(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Opacity(
                                  opacity: checkBoxOpacity.value,
                                  child: const Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: ColorConstant.signUpGenderButtons,
                                  )),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: ColorConstant.signUpGenderButtons,
                                    width: 1.0)))),
                  ),
                ),
                const AgreeTermsOfUse(),
              ],
            ),
            sizedBoxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 25.w,
                  height: 4.2.h,
                  decoration: BoxDecoration(
                      gradient: ColorConstant.isolaMainGradient,
                      border: Border.all(width: 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(7.sp)),
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 0.1,
                            blurRadius: 1.0,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CupertinoButton(
                      child: Text("Next",
                          style: isOther == true
                              ? StyleConstants.signUpGenderButtonActiveTextStyle
                              : StyleConstants
                                  .signUpGenderPassiveButtonTextStyle),
                      onPressed: () {
                        if (t1.text.length > 2 &&
                            t2.text.length > 2 &&
                            t3.text.isNotEmpty) {
                          if (checkbox == true) {
                            print("tıklı");

                            if (context
                                    .read<SignUpCubit>()
                                    .state
                                    .signUpPicturePath !=
                                "null") {
                              var picPath = context
                                  .read<SignUpCubit>()
                                  .state
                                  .signUpPicturePath;

                              //resim var
                              File file = File(picPath);
                              uploadImage(widget.userAll.isolaUserMeta.userUid, file,
                                      "profilePhoto")
                                  // widget.userDisplay,gestureKey"profilePhoto")
                                  .then((value) {
                                FirebaseAuth _auth = FirebaseAuth.instance;

                                CollectionReference users_display =
                                    FirebaseFirestore.instance
                                        .collection('users_display');

                                users_display
                                    .doc(_auth.currentUser!.uid)
                                    .update({
                                  'uPic': value,
                                  'uName': "${t1.text} ${t2.text}",
                                  'uSex': (isMale == true
                                      ? true
                                      : isFemale == true
                                          ? false
                                          : true),
                                  'uNonBinary': isOther
                                });

//widget.userDisplay.avatarUrl = value;

                                ///// eskiler
                                var refAvatarUrl = refGetter(
                                    enum2: RefEnum.Useravatar,
                                    targetUid: widget.userAll.isolaUserMeta.userUid,
                                    userUid: widget.userAll.isolaUserMeta.userUid,
                                    crypto: "");
                                var refUserDisplay = refGetter(
                                    enum2: RefEnum.Userdisplay,
                                    targetUid:widget.userAll.isolaUserMeta.userUid,
                                    userUid: widget.userAll.isolaUserMeta.userUid,
                                    crypto: "");

                                refAvatarUrl.set(value);

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

                                widget.userAll.isolaUserDisplay.avatarUrl = value;
                                print("kakakakkakakakka");
                                print("kakakakkakakakka");
                                print("kakakakkakakakka");
                                print("kakakakkakakakka");
                                print("kakakakkakakakka");
                                print("kakakakkakakakka");
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => InterestAddPage(
                                              userUid:
                                                  widget.userAll.isolaUserMeta.userUid,
                                            )));
                              });
                            } else {
                              var refUserDisplay = refGetter(
                                  enum2: RefEnum.Userdisplay,
                                  targetUid: widget.userAll.isolaUserMeta.userUid,
                                  userUid: widget.userAll.isolaUserMeta.userUid,
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
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => InterestAddPage(
                                            userUid: widget.userAll.isolaUserMeta.userUid
                                          )));
                            }
                          } else {
                            showCupertinoDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                      content: const Text(
                                          "You have to agree our terms"),
                                      actions: [
                                        CupertinoButton(
                                            child: const Text("Okey"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ));
                          }
                        } else {
                          showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    content:
                                        const Text("You have to fill all bar"),
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

class AddProfileSignUpPhotoContainer extends StatefulWidget {
  AddProfileSignUpPhotoContainer({Key? key, required this.signUp})
      : super(key: key);
  SignUp signUp;
  @override
  State<AddProfileSignUpPhotoContainer> createState() =>
      _AddProfileSignUpPhotoContainerState();
}

class _AddProfileSignUpPhotoContainerState
    extends State<AddProfileSignUpPhotoContainer>
    with TickerProviderStateMixin {
  File? file = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 250,
      maxWidth: 250,
    );
    file = File(xfile!.path);
    var currentSignUp = context.read<SignUpCubit>().state;

    context.read<SignUpCubit>().signUpChange(
        xfile.path,
        currentSignUp.signUpName,
        currentSignUp.signUpSurname,
        currentSignUp.signUpUniversity,
        currentSignUp.signUpGender,
        currentSignUp.signUpNonBinary);

    setState(() {});
  }

  final GlobalKey<ExtendedImageGestureState> gestureKey =
      GlobalKey<ExtendedImageGestureState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 95.w,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(25.0))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: ColorConstant.milkColor,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CupertinoButton(
                      child: const Icon(
                        CupertinoIcons.xmark,
                        color: ColorConstant.softBlack,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.w, 2.h, 0.0, 0.0),
                child: SizedBox(
                  height: 45.h,
                  width: 95.w,
                  // color: ColorConstant.addTimelinePost,
                  child: file == null
                      ? GestureDetector(
                          onTap: () {
                            chooseImage();
                          },
                          child: ClipOval(
                            child: Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 70.sp,
                              color: ColorConstant.themeGrey,
                            ),
                          ),
                        )
                      : ExtendedImage.file(
                          file!,
                          //  scale: 2.6,
                          extendedImageGestureKey: gestureKey,

                          //   shape: BoxShape.circle,
                          mode: ExtendedImageMode.gesture,
                          fit: BoxFit.fill,
                          border: Border.all(
                              color: ColorConstant.iGradientMaterial4,
                              width: 1.0),

                          borderRadius:
                              BorderRadius.all(Radius.circular(70.sp)),

                          initGestureConfigHandler: (state) {
                            return GestureConfig(
                                maxScale: 4.0,
                                cacheGesture: true,
                                //  cropRectPadding: EdgeInsets.all(10.0),
                                //hitTestSize: 10.0,
                                initialAlignment: InitialAlignment.center,
                                gestureDetailsIsChanged:
                                    (GestureDetails? details) {
                                  print(details?.totalScale);
                                });
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    // print(t1.text);

                    //  Navigator.pop(context);
                  },
                  child: Container(
                    height: 5.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        gradient: ColorConstant.isolaMainGradient,
                        border:
                            Border.all(color: ColorConstant.transparentColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: ColorConstant.themeGrey,
                            border: Border.all(
                                color: ColorConstant.transparentColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0))),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const CupertinoAlertDialog(
                                        content: CupertinoActivityIndicator(),
                                      ));

                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                setState(() {});
                              });
                            },
                            child: Text(
                              "Update Photo",
                              style: StyleConstants.postAddTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
