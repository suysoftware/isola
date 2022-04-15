import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/blocs/chat_reference_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/service/firebase/storage/groups/group_attachment_message.dart';
import 'package:isola_app/src/utils/image_cropper.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../service/firebase/storage/feedshare/add_image_feeds.dart';
import '../../service/firebase/storage/feedshare/add_search_feed.dart';

class ChatImagePicker extends StatefulWidget {
  const ChatImagePicker(
      {Key? key,
      required this.userAll,
      required this.targetUid1,
      required this.targetUid2,
      required this.file,
      required this.isChaos,
      required this.targetUid3,
      required this.targetUid4,
      required this.targetUid5})
      : super(key: key);
  final IsolaUserAll userAll;
  final String targetUid1;
  final String targetUid2;
  final String targetUid3;
  final String targetUid4;
  final String targetUid5;

  final File file;
  final bool isChaos;

  @override
  State<ChatImagePicker> createState() => _ChatImagePickerState();
}

class _ChatImagePickerState extends State<ChatImagePicker>
    with TickerProviderStateMixin {
  bool _cropping = false;
  // ignore: prefer_typing_uninitialized_variables
  late var refChatInterior;
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void initState() {
    super.initState();
    refChatInterior = context.read<ChatReferenceCubit>().state;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeColor,
      navigationBar:
          const CupertinoNavigationBar(automaticallyImplyLeading: true),
      child: Column(
          mainAxisAlignment:
              100.h < 800 ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: 100.h < 800
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            ExtendedImage.file(
              widget.file,
              extendedImageEditorKey: editorKey,
              mode: ExtendedImageMode.editor,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              height: 600,
              width: 600,
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
            Container(
              height: 5.h,
              width: 40.w,
              decoration: BoxDecoration(
                  gradient: ColorConstant.isolaMainGradient,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                      color: ColorConstant.themeGrey,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        cropImage().whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          setState(() {});
                        });

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const AnimatedLiquidCircularProgressIndicator());
                      },
                      child: Text(
                        "Send Photo",
                        style: StyleConstants.postAddTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
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

    final String? fileFath = await ImageSaver.save(
        'isola_chat_image-${DateTime.now().toUtc().toString()}.jpg', fileData);
    if (widget.isChaos) {
      await uploadAttachmentToChaos(
          widget.userAll,
          fileFath!,
          refChatInterior,
          true,
          false,
          false,
          widget.targetUid1,
          widget.targetUid2,
          widget.targetUid3,
          widget.targetUid4,
          widget.targetUid5);
    } else {
      await uploadAttachment(widget.userAll, fileFath!, refChatInterior, true,
          false, false, widget.targetUid1, widget.targetUid2);
    }

    _cropping = false;
  }
}

class ChatImagePickerNoChat extends StatefulWidget {
  const ChatImagePickerNoChat(
      {Key? key,
      required this.userAll,
      required this.file,
      required this.isChaos,
      required this.isProfile,
      required this.cropAspectRatios,required this.pHeight,required this.pWidth})
      : super(key: key);
  final IsolaUserAll userAll;

  final File file;
  final bool isChaos;
  final bool isProfile;
  final double cropAspectRatios;
  final int pHeight;
  final int pWidth;

  @override
  State<ChatImagePickerNoChat> createState() => _ChatImagePickerNoChatState();
}

class _ChatImagePickerNoChatState extends State<ChatImagePickerNoChat>
    with TickerProviderStateMixin {
  bool _cropping = false;
  // ignore: prefer_typing_uninitialized_variables
  late var refChatInterior;
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  File? file2 = null;
  @override
  void initState() {
    super.initState();
    refChatInterior = context.read<ChatReferenceCubit>().state;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeColor,
      navigationBar:
          const CupertinoNavigationBar(automaticallyImplyLeading: true),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ExtendedImage.file(
                widget.file,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                enableLoadState: true,
                cacheRawData: true,
                height: 600,
                width: 360,
                extendedImageEditorKey: editorKey,
                initEditorConfigHandler: (state) {
                  return EditorConfig(
                      cropRectPadding: const EdgeInsets.all(15.0),
                      cornerColor: ColorConstant.iGradientMaterial4,
                      maxScale: 4.0,
                      hitTestSize: 10.0,
                      initCropRectType:
                          InitCropRectType.imageRect, // imageRect,
                      cropAspectRatio: widget.cropAspectRatios,
                      editActionDetailsIsChanged:
                          (EditActionDetails? details) {});
                },
              ),
            ),
            /*   ExtendedImage.file(
              widget.file,
              extendedImageEditorKey: editorKey,
              mode: ExtendedImageMode.editor,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              height: 600,
              width: 600,
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
            ),*/
            Center(
              child: Container(
                height: 5.h,
                width: 40.w,
                decoration: BoxDecoration(
                    gradient: ColorConstant.isolaMainGradient,
                    border: Border.all(color: ColorConstant.transparentColor),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0))),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(0.2),
                    onPressed: () async {
                      if (widget.isProfile) {
                        cropImageProfile().whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          setState(() {});
                        });

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const AnimatedLiquidCircularProgressIndicator());
                      } else {
                        cropImage().whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          setState(() {});
                        });

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const AnimatedLiquidCircularProgressIndicator());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          color: ColorConstant.themeGrey,
                          border:
                              Border.all(color: ColorConstant.transparentColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      child: Center(
                        child: Text(
                          "Send Photo",
                          style: StyleConstants.postAddTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            )
          ]),
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
    // print(fileData);
    final String? fileFath =
        await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

    file2 = File(fileFath!);

    String fileID = const Uuid().v4();
    await uploadImage(widget.userAll.isolaUserMeta.userUid, file2!, fileID)
        .then((value) {
      addImageFeedToDatabase(
        feedIsActivity: false,
        imageFeedUrl: value,
        uid: widget.userAll.isolaUserMeta.userUid,
        userAvatarUrl: widget.userAll.isolaUserDisplay.avatarUrl,
        userName: widget.userAll.isolaUserDisplay.userName,
        userUniversity: widget.userAll.isolaUserDisplay.userUniversity,
      );
    });
    _cropping = false;
  }

  Future<void> cropImageProfile() async {
    if (_cropping) {
      return;
    }
    final Uint8List fileData = Uint8List.fromList(kIsWeb
        ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))!
        : (await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!))!);
    // print(fileData);
    final String? fileFath =
        await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

    file2 = File(fileFath!);
    await uploadImageForProfile(
      widget.userAll.isolaUserMeta.userUid,
      file2!,
    ).then((value) {
      CollectionReference usersDisplay =
          FirebaseFirestore.instance.collection('users_display');

      usersDisplay
          .doc(widget.userAll.isolaUserMeta.userUid)
          .update({'uPic': value});
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
  static const double ratio6_10 = 6.0 / 10.0;

  /// ratio of width and height is 9 : 16
  static const double ratio9_16 = 9.0 / 16.0;

  /// ratio of width and height is 16 : 9
  static const double ratio16_9 = 16.0 / 9.0;
}
