import 'package:cloud_firestore/cloud_firestore.dart';

class PopularTimeline {
  late PopularItem popularItem1;
  late PopularItem popularItem2;

  PopularTimeline(this.popularItem1, this.popularItem2);
}

class PopularItem {
  late String pAvatarUrl;
  late Timestamp pDate;
  late String pLink;
  late String pName;
  late String pText;
  late int pLikeValue;

  PopularItem(this.pAvatarUrl, this.pDate, this.pLink, this.pName, this.pText,
      this.pLikeValue);
}
