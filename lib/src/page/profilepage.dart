// ignore_for_file: avoid_init_to_null, avoid_print, implementation_imports
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/page/profile/profile_biography.dart';
import 'package:isola_app/src/page/profile/profile_media_page.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_image_feeds.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:isola_app/src/service/firebase/storage/getters/display_getter.dart';
import 'package:isola_app/src/utils/image_cropper.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/page/profile/profile_timeline_page.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
    required this.userAll,
  }) : super(key: key);
  final User user;
  final IsolaUserAll userAll;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

TextStyle navigatorStyle = 100.h >= 700
    ? (100.h >= 1100
        ? StyleConstants.profileNaviTabletTextStyle
        : StyleConstants.profileNaviTextStyle)
    : StyleConstants.profileMiniNaviTextStyle;

class _ProfilePageState extends State<ProfilePage> {
  int _profileSegmentedValue = 0;

  final Map<int, Widget> _profileTabs = <int, Widget>{
    0: Container(
      padding: EdgeInsets.zero,
      child: Text(
        "Timeline",
        style: navigatorStyle,
      ),
      color: ColorConstant.themeGrey,
    ),
    1: Padding(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text("Media", style: navigatorStyle),
        color: ColorConstant.themeGrey,
      ),
    ),
    2: Padding(
      padding: EdgeInsets.zero,
      child: Container(
        child: Text(
          "Biograph",
          style: navigatorStyle,
        ),
        color: ColorConstant.themeGrey,
      ),
    ),
  };

  StatefulWidget buildProfileWidget() {
    switch (_profileSegmentedValue) {
      case 0:
        return ProfileTimelinePage(
          user: widget.user,
          userAll: widget.userAll,
        );

      case 1:
        return ProfileMediaPage(
          user: widget.user,
          userAll: widget.userAll,
        );

      case 2:
        return ProfileBiographPage(
          user: widget.user,
          userAll: widget.userAll,
        );
      default:
        return ProfileTimelinePage(
          user: widget.user,
          userAll: widget.userAll,
        );
    }
  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Profile"),
          ),
          automaticallyImplyLeading: false,
          trailing: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
                onTap: () {
                  /*  addImageFeedToDatabase(
                      widget.userAll.isolaUserMeta.userUid,
                      widget.userAll.isolaUserDisplay.avatarUrl,
                      widget.userAll.isolaUserDisplay.userName,
                      "https://en.pimg.jp/054/507/693/1/54507693.jpg");*/

                  //image feed bölümünü eklemeyi unutma

                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(settingsPage);

                  //   getTimelineFeeds(widget.userAll,20);
                },
                child: Image.asset("asset/img/settings_button.png")),
          ),
        ),
        child: Container(
          color: ColorConstant.themeGrey,
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 2.h, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: ColorConstant.isolaMainGradient,
                                border: Border.all(
                                    color: ColorConstant.transparentColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60.sp))),
                            child: Padding(
                              padding: const EdgeInsets.all(0.5),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstant.milkColor,
                                      border: Border.all(
                                          color:
                                              ColorConstant.transparentColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.sp))),
                                  child: ClipOval(
                                      child: 100.h >= 700
                                          ? (100.h <= 1100
                                              ? CachedNetworkImage(
                                                  imageUrl: widget
                                                      .userAll
                                                      .isolaUserDisplay
                                                      .avatarUrl,
                                                  width: 110.sp,
                                                  height: 110.sp,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                  cacheManager:
                                                      CacheManager(Config(
                                                    "cachedImageFiles",
                                                    stalePeriod:
                                                        const Duration(days: 3),
                                                    //one week cache period
                                                  )),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: widget
                                                      .userAll
                                                      .isolaUserDisplay
                                                      .avatarUrl,
                                                  width: 80.sp,
                                                  height: 80.sp,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                                                        cacheManager: CacheManager(
        Config(
          "cachedImageFiles",
          stalePeriod: const Duration(days: 3),
          //one week cache period
        )
    ),
                                                ))
                                          : CachedNetworkImage(
                                              imageUrl: widget.userAll
                                                  .isolaUserDisplay.avatarUrl,
                                              width: 75.sp,
                                              height: 75.sp,
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      CupertinoIcons
                                                          .xmark_square),
                                                                    cacheManager: CacheManager(
        Config(
          "cachedImageFiles",
          stalePeriod: const Duration(days: 3),
          //one week cache period
        )
    ),
                                            ))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 100.h >= 700 ? (100.h >= 1100 ? 14.h : 14.h) : 9.5.h,
                    right: 100.h >= 700 ? (100.h >= 1100 ? 35.w : 28.w) : 33.w,
                    child: CupertinoButton(
                      onPressed: () {
                        showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) => Center(
                                  child: AddProfilePhotoContainer(
                                      userAll: widget.userAll),
                                ));
                      },
                      child: SizedBox(
                        height: 100.h >= 700
                            ? (100.h <= 1100 ? 22.sp : 5.h)
                            : 21.sp,
                        width: 100.h >= 700
                            ? (100.h <= 1100 ? 22.sp : 6.w)
                            : 19.sp,
                        child: Image.asset(
                          "asset/img/profile_edit_icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(
                      widget.userAll.isolaUserDisplay.userName,
                      style: 100.h >= 1100
                          ? StyleConstants.profileNameTabletTextStyle
                          : StyleConstants.profileNameTextStyle,
                    ),
                    context
                                .read<UserAllCubit>()
                                .state
                                .isolaUserDisplay
                                .userIsOnline ==
                            true
                        ? Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset("asset/img/profile_online.png"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset("asset/img/profile_offline.png"),
                          ),
                  ],
                ),
              ),
              Text(
                widget.userAll.isolaUserDisplay.userUniversity,
                style: 100.h >= 1100
                    ? StyleConstants.profileUniversityTabletTextStyle
                    : StyleConstants.profileUniversityTextStyle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(
                              color: ColorConstant.softPurple.withOpacity(0.6),
                              width: 1.5))),
                  child: CupertinoSlidingSegmentedControl(
                      backgroundColor: ColorConstant.themeGrey,
                      thumbColor: ColorConstant.themeGrey,
                      groupValue: _profileSegmentedValue,
                      padding: const EdgeInsets.all(4.0),
                      children: _profileTabs,
                      onValueChanged: (dynamic i) {
                        setState(() {
                          _profileSegmentedValue = i;
                        });
                      }),
                ),
              ),
              buildProfileWidget(),
            ],
          ),
        ));
  }
}

class AddProfilePhotoContainer extends StatefulWidget {
  const AddProfilePhotoContainer({Key? key, required this.userAll})
      : super(key: key);
  final IsolaUserAll userAll;

  @override
  State<AddProfilePhotoContainer> createState() =>
      _AddProfilePhotoContainerState();
}

class _AddProfilePhotoContainerState extends State<AddProfilePhotoContainer>
    with TickerProviderStateMixin {
  var t1 = TextEditingController();
  bool _cropping = false;

  File? file = null;
  File? file2 = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 5,
    );
    file = File(xfile!.path);
    setState(() {});
  }

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

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
                          extendedImageEditorKey: editorKey,
                          mode: ExtendedImageMode.editor,
                          fit: BoxFit.contain,
                          height: 500,
                          width: 500,
                          enableLoadState: true,
                          cacheRawData: true,
                          initEditorConfigHandler: (state) {
                            return EditorConfig(
                                cornerColor: ColorConstant.iGradientMaterial4,
                                maxScale: 4.0,
                                cropRectPadding: const EdgeInsets.all(15.0),
                                hitTestSize: 10.0,
                                initCropRectType: InitCropRectType.imageRect,
                                cropAspectRatio: CropAspectRatios.ratio1_1,
                                editActionDetailsIsChanged:
                                    (EditActionDetails? details) {});
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      gradient: ColorConstant.isolaMainGradient,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(1.0),
                      onPressed: () async {
                        cropImage().whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          setState(() {});
                        });

                        //  cropImage();

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AnimatedLiquidCircularProgressIndicator());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: ColorConstant.themeGrey,
                            border: Border.all(
                                color: ColorConstant.transparentColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0))),
                        child: Center(
                          child: Text(
                            "Post",
                            style: StyleConstants.postAddTextStyle,
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

  Future<void> cropImage() async {
    if (_cropping) {
      return;
    }
    final Uint8List fileData = Uint8List.fromList(kIsWeb
        ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))!
        : (await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!))!);
    print(fileData);
    final String? fileFath =
        await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

    file2 = File(fileFath!);
    await uploadImageForProfile(
      widget.userAll.isolaUserMeta.userUid,
      file2!,
    )
        // widget.userDisplay,gestureKey"profilePhoto")
        .then((value) {
      CollectionReference users_display =
          FirebaseFirestore.instance.collection('users_display');

      users_display
          .doc(widget.userAll.isolaUserMeta.userUid)
          .update({'uPic': value});

      /*
      var refAvatarUrl = refGetter(
          enum2: RefEnum.Useravatar,
          targetUid: widget.userAll.isolaUserMeta.userUid,
          userUid: widget.userAll.isolaUserMeta.userUid,
          crypto: "");
      refAvatarUrl.set(value);

      widget.userAll.isolaUserDisplay.avatarUrl = value;*/
    });

    _cropping = false;
  }
}

class CropAspectRatios {
  /// no aspect ratio for crop
  //static const double custom = null;

  /// the same as aspect ratio of image
  /// [cropAspectRatio] is not more than 0.0, it's original
  static const double original = 0.0;

  /// ratio of width and height is 1 : 1
  static const double ratio1_1 = 1.0;

  /// ratio of width and height is 3 : 4
  static const double ratio3_4 = 3.0 / 4.0;

  /// ratio of width and height is 4 : 3
  static const double ratio4_3 = 4.0 / 3.0;

  /// ratio of width and height is 8 : 10
  static const double ratio8_10 = 8.0 / 10.0;

  /// ratio of width and height is 9 : 16
  static const double ratio9_16 = 9.0 / 16.0;

  /// ratio of width and height is 16 : 9
  static const double ratio16_9 = 16.0 / 9.0;
}
