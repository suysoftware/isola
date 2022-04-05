class GroupSettingModel {
  late String groupNo;
  late String userUid;
  late String groupMemberName1;
  late String groupMemberAvatarUrl1;
  late String groupMemberName2;
  late String groupMemberAvatarUrl2;
  late String groupMemberUid2;
  late String groupMemberName3;
  late String groupMemberAvatarUrl3;
  late String groupMemberUid3;
  late int newNotiValueAmount;

  GroupSettingModel(
      {required this.groupNo,
      required this.userUid,
      required this.groupMemberName1,
      required this.groupMemberAvatarUrl1,
      required this.groupMemberName2,
      required this.groupMemberAvatarUrl2,
      required this.groupMemberUid2,
      required this.groupMemberName3,
      required this.groupMemberAvatarUrl3,
      required this.groupMemberUid3
      ,required this.newNotiValueAmount
      });
}
