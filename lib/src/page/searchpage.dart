import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/page/groupchat/chat_image_picker.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import '../extensions/locale_keys.dart';
import '../service/firebase/storage/feedshare/add_image_feeds.dart';
import '../utils/image_cropper.dart';
import '../widget/search_detail.dart';

int feedAllControl = 0;
void amountUpdater(int updateValue) async {
  feedAllControl = updateValue;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User user;
  final IsolaUserAll userAll;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int loadingValue = 2;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    // if failed,use refreshFailed()
    setState(() {
      BasicGridWidget.gtGetterReset();
    });
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  chooseImage2() async {
    XFile? xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);
    File file = File(xfile!.path);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => ChatImagePickerNoChat(
              userAll: widget.userAll,
              file: file,
              isChaos: false,
              isProfile: false,
              cropAspectRatios: CropAspectRatios.ratio6_10,
              pHeight: 1000,
              pWidth: 600,
            ));
  }

  void _onLoading() async {
    if (BasicGridWidget.feedValue.length >= feedAllControl) {
      feedAllControl = 0;
      _refreshController.loadNoData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        setState(() {
          BasicGridWidget.gtGetter();
        });
      }
      _refreshController.loadComplete();
    }
  }

  @override
  void initState() {
    super.initState();

    widget.userAll.isolaUserMeta.userToken =
        context.read<UserAllCubit>().state.isolaUserMeta.userToken;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(1.0),
                  onPressed: () async => chooseImage2()
                  //    onPressed: () async =>addSearchItemDialogContent(context)
                  ,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Image.asset(
                        "asset/img/search_page_cam_icon.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: ColorConstant.milkColor,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.main_explore.tr(),
            ),
          ),
        ),
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            footer: const ClassicFooter(),
            header: const ClassicHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Container(
              color: ColorConstant.themeGrey,
              child: BasicGridWidget(
                key: widget.key,
                userUid: widget.userAll.isolaUserMeta.userUid,
                userMeta: widget.userAll.isolaUserMeta,
              ),
            )));
  }
/*
  addSearchItemDialogContent(BuildContext context) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Center(
        child: AddSearchItemContainer(
          userAll: widget.userAll,
        ),
      ),
    );
  }*/
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget({
    Key? key,
    required this.userUid,
    required this.userMeta,
  }) : super(key: key);

  final String userUid;
  final IsolaUserMeta userMeta;

  static void gtGetter() {
    feedValue.addAll(tiles2);
  }

  static void gtGetterReset() {
    feedValue.clear();
    feedValue.addAll(tiles2);
  }

  static var exploreHistoryState = <String>[];

  static var alreadySeem = <dynamic>[];

  static const tiles2 = [
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
  ];

  static var feedValue = <GridTile>[
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
  ];

  @override
  State<BasicGridWidget> createState() => _BasicGridWidgetState();
}

class _BasicGridWidgetState extends State<BasicGridWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('image_feeds')
            .orderBy('feed_date', descending: true)
            .limit(BasicGridWidget.feedValue.length + 16)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            List<dynamic> itemDatas = documents
                .map((doc) => IsolaImageFeedModel(
                    doc['feed_date'],
                    doc['feed_no'],
                    doc['feed_image'],
                    doc['like_list'],
                    doc['like_value'],
                    doc['user_avatar_url'],
                    doc['user_name'],
                    doc['user_uid'],
                    doc['user_loc'],
                    doc['feed_visibility'],
                    doc['feed_report_value'],
                    doc['user_university'],
                    doc['feed_token'],
                    doc['feed_token_list']))
                .toList();

            if (itemDatas.length < BasicGridWidget.feedValue.length &&
                itemDatas.isNotEmpty) {
              int deleteNeed =
                  BasicGridWidget.feedValue.length - itemDatas.length;

              for (var i = 0; i < deleteNeed; i++) {
                BasicGridWidget.feedValue.removeLast();
                if (BasicGridWidget.feedValue.length == 1) {
                  BasicGridWidget.feedValue.removeLast();
                  BasicGridWidget.feedValue.add(
                    const GridTile(3, 3),
                  );
                }
              }
            }


            amountUpdater((itemDatas.length));
            return itemDatas.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.photo,
                        size: 65.sp,
                        color: ColorConstant.softGrey,
                      ),
                      Text(LocaleKeys.profile_havenotimage.tr())
                    ],
                  ))
                : StaggeredGrid.count(
                    crossAxisCount: 3,
                    children: [
                      ...BasicGridWidget.feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: GestureDetector(
                            onTap: () {
                              _openDetail(context, index, itemDatas,
                                  widget.userUid, widget.userMeta, index);
                            },
                            child: ImageTile(
                              index: index,
                              width: tile.crossAxisCount * 100,
                              height: tile.mainAxisCount * 100,
                              imageUrl: itemDatas[index].feedImageUrl,
                            ),
                          ),
                        );
                      })
                    ],
                  );
          } else if (snapshot.hasError) {
            return const Text('It Error!');
          } else {
            return Center(
                child: CupertinoActivityIndicator(
              animating: true,
              radius: 15.sp,
            ));
          }
        });
  }
}

_openDetail(
  context,
  index,
  List<dynamic> imageItemList,
  String userUid,
  IsolaUserMeta userMeta,
  int sira,
) {
  List<dynamic> slicedList = imageItemList.slice(sira);

  final route = CupertinoPageRoute(
    builder: (context) => SearchDetail(
      index: index,
      imageItemList: slicedList,
      userUid: userUid,
      userMeta: userMeta,
      itemLoc: sira,
      isProfile: false,
    ),
  );
  Navigator.push(context, route);
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    Key? key,
    required this.imageUrl,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String imageUrl;
  final int index;
  final int width;
  final int height;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isScope = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: ColorConstant.isolaMainGradient,
            border: Border.all(color: ColorConstant.transparentColor),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.milkColor,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: const BorderRadius.all(Radius.circular(15.0))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                tag: 'tag ${widget.imageUrl}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    cacheManager: CacheManager(Config(
                      "cachedImageFiles",
                      stalePeriod: const Duration(days: 3),
                      //one week cache period
                    )),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(CupertinoIcons.xmark_square),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

/*
class AddSearchItemContainer extends StatefulWidget {
  const AddSearchItemContainer({Key? key, required this.userAll})
      : super(key: key);
  final IsolaUserAll userAll;

  @override
  State<AddSearchItemContainer> createState() => _AddSearchItemContainerState();
}

class _AddSearchItemContainerState extends State<AddSearchItemContainer>
    with TickerProviderStateMixin {
  var t1 = TextEditingController();
  bool _cropping = false;
  File? file;



  File? file2 = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
      preferredCameraDevice:CameraDevice.rear
        source: ImageSource.gallery,

        imageQuality: 100);
    file = File(xfile!.path);
    setState(() {});
  }

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void dispose() {

    super.dispose();
  }

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
               
                  child: file == null
                      ? GestureDetector(
                          onTap: () {
      

                            chooseImage();
                          },
                          child: ClipOval(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Icon(
                                 CupertinoIcons.photo_camera_solid,
                                 size: 70.sp,
                                 color: ColorConstant.themeGrey,
                               ),
                                Text(LocaleKeys.main_clickhere.tr(),style: TextStyle(fontFamily: 'Roboto-Bold',fontSize: 24.sp,color: ColorConstant.themeGrey))
                             ],
                           ),
                            ),
                        )
                      : ExtendedImage.file(
                        
                          file!,
                          fit: BoxFit.contain,
                          mode: ExtendedImageMode.editor,
                          enableLoadState: true,
                          cacheRawData: true,
                          height: 1000,
                          width: 600,
                          extendedImageEditorKey: editorKey,
                          initEditorConfigHandler: (state) {
                            return EditorConfig(
                             
                                cropRectPadding: const EdgeInsets.all(15.0),
                               
                                cornerColor: ColorConstant.iGradientMaterial4,
                                maxScale: 4.0,
                       
                                hitTestSize: 10.0,
                                initCropRectType: InitCropRectType.imageRect,// imageRect,
                                cropAspectRatio: CropAspectRatios.ratio6_10,
                                editActionDetailsIsChanged:
                                    (EditActionDetails? details) {
                           
                                });
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
                        cropImage()
                      /*  String fileID = const Uuid().v4();
                        uploadImage(widget.userAll.isolaUserMeta.userUid, file!,
                                fileID)
                            .then((value) {
                          addImageFeedToDatabase(
                            feedIsActivity: false,
                            imageFeedUrl: value,
                            uid: widget.userAll.isolaUserMeta.userUid,
                            userAvatarUrl:
                                widget.userAll.isolaUserDisplay.avatarUrl,
                            userName: widget.userAll.isolaUserDisplay.userName,
                            userUniversity:
                                widget.userAll.isolaUserDisplay.userUniversity,
                          );*/

                   
                
                    .whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          setState(() {});
                        });

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const AnimatedLiquidCircularProgressIndicator());
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
                            LocaleKeys.main_post.tr(),
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
    // print(fileData);
    final String? fileFath =
        await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

    file2 = File(fileFath!);
    
          String fileID = const Uuid().v4();
                       await uploadImage(widget.userAll.isolaUserMeta.userUid, file2!,
                                fileID)
                            .then((value) {
                          addImageFeedToDatabase(
                            feedIsActivity: false,
                            imageFeedUrl: value,
                            uid: widget.userAll.isolaUserMeta.userUid,
                            userAvatarUrl:
                                widget.userAll.isolaUserDisplay.avatarUrl,
                            userName: widget.userAll.isolaUserDisplay.userName,
                            userUniversity:
                                widget.userAll.isolaUserDisplay.userUniversity,
                          );

                   
                
                        });
    _cropping = false;
  }
}
*/
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
