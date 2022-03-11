// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:collection/collection.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TargetProfileMediaPage extends StatefulWidget {
  const TargetProfileMediaPage({Key? key, required this.userUid})
      : super(key: key);
  final String userUid;

  @override
  _TargetProfileMediaPageState createState() => _TargetProfileMediaPageState();
}

class _TargetProfileMediaPageState extends State<TargetProfileMediaPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late var _refProfileMedia;
  //late var searchHistoryData;
  var searchFeed = <FeedMeta>[];
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _refProfileMedia = refGetter(
        enum2: RefEnum.Searchfeedsget,
        targetUid: "",
        crypto: '',
        userUid: widget.userUid);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Container(
            color: ColorConstant.themeGrey,
            child: ProfileBasicGridWidget(
              key: widget.key,
              refProfileMedia: _refProfileMedia,
             userUid: widget.userUid,
            ),
          )),
    );
  }
}

class ProfileBasicGridWidget extends StatelessWidget {
  ProfileBasicGridWidget(
      {Key? key, required this.refProfileMedia, required this.userUid})
      : super(key: key);
  final DatabaseReference refProfileMedia;
  final String userUid;

  static const tiles = [
    ProfileGridTile(2, 1),
    ProfileGridTile(1, 2),
    ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
    ProfileGridTile(1, 2),
    ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
    ProfileGridTile(1, 2),
    ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
    ProfileGridTile(1, 2),
    ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
    ProfileGridTile(1, 2),
    ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
  ];

  Future<void> gridTileWithPostValue() async {
    feedValue.add(const ProfileGridTile(1, 2));
  }

  var feedValue = <ProfileGridTile>[];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: refProfileMedia.onValue,
        builder: (context, event) {
          if (event.hasData) {
            feedValue.clear();
            var searchDatas = <FeedMeta>[];

            var gettingSearch = event.data.snapshot.value as Map;

            gettingSearch.forEach((key, value) {
              var imageFeed = FeedMeta.fromJson(value);

              if (imageFeed.feedIsImage == true &&
                  imageFeed.userUid == userUid) {
                searchDatas.add(imageFeed);
                gridTileWithPostValue();
              }
            });

            return searchDatas.isEmpty
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
                      ...feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: ImageTile(
                            postValue: searchDatas.length,
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            imageUrl: searchDatas[index].feedImageUrl,
                          ),
                        );
                      })
                    ],
                  );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 12.sp,
              ),
            );
          }
        });
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.postValue,
    required this.imageUrl,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);
  final int postValue;
  final String imageUrl;
  final int index;
  final int width;
  final int height;

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
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileGridTile {
  const ProfileGridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
