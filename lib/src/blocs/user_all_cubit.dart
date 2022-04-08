import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/user/user_all.dart';


class UserAllCubit extends Cubit<IsolaUserAll> {
  final IsolaUserAll userDisplay;
  UserAllCubit(this.userDisplay) : super(userDisplay);

  void userAllChanger(IsolaUserAll userAll) {
    emit(userAll);
  }
}
