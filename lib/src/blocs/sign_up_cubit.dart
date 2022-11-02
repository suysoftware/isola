import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/model/user/sign_up.dart';

class SignUpCubit extends Cubit<SignUp> {
  SignUpCubit() : super(SignUp("null", "", "", "", false, false));

  void signUpChange(String imagePath, String name, String surName,
      String university, bool gender, bool nonBinary) {
    var signUpNew =
        SignUp(imagePath, name, surName, university, gender, nonBinary);

    emit(signUpNew);
  }
}
