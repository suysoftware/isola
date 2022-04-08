// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:collection/collection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../model/feeds/image_feed_meta.dart';
import '../../model/hive_models/user_hive.dart';
import '../../model/user/user_all.dart';
import '../../model/user/user_meta.dart';
import '../../widget/search_detail.dart';

int feedAllControl = 0;

bool aDeleted = false;

void amountUpdater(int updateValue) async {
  feedAllControl = updateValue;
}

void deletedStatusChanger() async {
  aDeleted = !aDeleted;
}

class TargetProfileMediaPage extends StatefulWidget {
  const TargetProfileMediaPage(
      {Key? key, required this.userAll, required this.targetUid})
      : super(key: key);

  final IsolaUserAll userAll;
  final String targetUid;
  @override
  _TargetProfileMediaPageState createState() => _TargetProfileMediaPageState();
}

class _TargetProfileMediaPageState extends State<TargetProfileMediaPage> {
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

  void _onLoading() async {
    if (BasicGridWidget.feedValue.length >= feedAllControl) {
      feedAllControl = 0;
      _refreshController.loadNoData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        setState(() {
          BasicGridWidget.gtGetterWithValue(
              feedAllControl - BasicGridWidget.feedValue.length);
        });
      }
      _refreshController.loadComplete();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          header: const ClassicHeader(),
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: Container(
            color: ColorConstant.themeGrey,
            child: BasicGridWidget(
              key: widget.key,
              userUid: widget.targetUid,
              userMeta: widget.userAll.isolaUserMeta,
            ),
          )),
    );
  }
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget(
      {Key? key, required this.userUid, required this.userMeta})
      : super(key: key);

  final String userUid;
  final IsolaUserMeta userMeta;

  static void gtMixer() {
    feedValue.shuffle();
  }

  static void feedAdder(int cac, int mac) {
    feedValue.add(GridTile(cac, mac));
  }

  static var exploreHistoryState = <String>[];

  static void explorerUpdate(User user) async {}

  static void gtGetterReset() {
    feedValue.clear();
    feedValue.addAll(tiles2);
  }

  static void gtGetter() {
    feedValue.addAll(tiles2);
  }

  static void gtGetterWithValue(int value) {
    for (var i = 0; i < value; i++) {
      feedValue.add(
        const GridTile(1, 2),
      );
    }
  }

  static void explorerGetter(User user) async {
    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');

    alreadySeem = userHive.exloreData;
  }

  static var alreadySeem = <dynamic>[];

  static const tiles2 = [
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
  ];

  static var feedValue = <GridTile>[
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
    const GridTile(1, 2),
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
            .collection('feeds')
            .doc(widget.userUid)
            .collection('image_feeds')
            .orderBy('feed_date', descending: true)
            .limit(BasicGridWidget.feedValue.length + 9)
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
              }
            }

            if (aDeleted == true) {
              BasicGridWidget.feedValue.removeLast();
              aDeleted = false;
            }

            amountUpdater(itemDatas.length);
            return itemDatas.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.photo,
                        size: 65.sp,
                        color: ColorConstant.softGrey,
                      ),
                      const Text("You have not image")
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

_openDetail(context, index, List<dynamic> imageItemList, String userUid,
    IsolaUserMeta userMeta, int sira) {
  List<dynamic> slicedList = imageItemList.slice(sira);

  final route = CupertinoPageRoute(
    builder: (context) => SearchDetail(
      index: index,
      imageItemList: slicedList,
      userUid: userUid,
      userMeta: userMeta,
      itemLoc: sira,
      isProfile: true,
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
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(CupertinoIcons.xmark_square),
                    cacheManager: CacheManager(Config(
                      "cachedImageFiles",
                      stalePeriod: const Duration(days: 3),
                      //one week cache period
                    )),
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
