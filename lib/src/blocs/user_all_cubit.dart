import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_meta.dart';

class UserAllCubit extends Cubit<IsolaUserAll> {
  final IsolaUserAll userDisplay;
  UserAllCubit(this.userDisplay) : super(userDisplay);

  void userAllChanger(IsolaUserAll userAll) {
    emit(userAll);
  }

  void searchingStatusChanger(bool statusInfo) {
    var nowUserMeta = IsolaUserMeta(
        state.isolaUserMeta.userEmail,
        state.isolaUserMeta.userToken,
        state.isolaUserMeta.joinedGroupList,
        state.isolaUserMeta.userUid,
        state.isolaUserMeta.userIsValid,
        state.isolaUserMeta.userFriends,
        state.isolaUserMeta.userBlocked,
        state.isolaUserMeta.userActivityClubs,
        statusInfo,
        state.isolaUserMeta.userFriendOrders);
    var nowUserAll = IsolaUserAll(state.isolaUserDisplay, nowUserMeta);

    emit(nowUserAll);
  }
}
