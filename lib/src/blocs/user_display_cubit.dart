import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/user/user_display.dart';

class UserDisplayCubit extends Cubit<UserDisplay> {
  final UserDisplay userDisplay;
  UserDisplayCubit(this.userDisplay) : super(userDisplay);

  void userDisplayChanger(UserDisplay userDp) {

    
    emit(userDp);
  }
}
