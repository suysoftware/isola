// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:collection/collection.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class ProfileMediaPage extends StatefulWidget {
  const ProfileMediaPage({Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User user;
  final IsolaUserAll userAll;
  @override
  _ProfileMediaPageState createState() => _ProfileMediaPageState();
}

class _ProfileMediaPageState extends State<ProfileMediaPage> {
  RefreshController _refreshController =
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
        userUid: widget.user.uid);
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
              userAll: widget.userAll,
            ),
          )),
    );
  }
}

class ProfileBasicGridWidget extends StatelessWidget {
  ProfileBasicGridWidget(
      {Key? key, required this.refProfileMedia, required this.userAll})
      : super(key: key);
  final DatabaseReference refProfileMedia;
  final IsolaUserAll userAll;

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
    var gridTypes = <ProfileGridTile>[
      const ProfileGridTile(2, 1),
      const ProfileGridTile(1, 2),
      const ProfileGridTile(2, 2),
      const ProfileGridTile(1, 1),
    ];

    feedValue.add(const ProfileGridTile(1, 2));
  }

  var feedValue = <ProfileGridTile>[];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feeds')
            .doc(userAll.isolaUserMeta.userUid)
            .collection('image_feeds')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            feedValue.clear();
       

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            //    List<dynamic> itemList =
            //      documents.map((doc) => doc['feed_image']).toList();
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
                    doc['feed_report_value']))
                .toList();

                if(itemDatas.length!=0){

                       gridTileWithPostValue();
                }
            print(itemDatas.length);
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
                      ...feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: ImageTile(
                            postValue: itemDatas.length,
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            imageUrl: itemDatas[index].feedImageUrl,
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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Icon(CupertinoIcons.xmark_square),
              ),
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



/*



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
                  imageFeed.userUid == userAll.isolaUserMeta.userUid) {
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







*/