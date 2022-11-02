import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchButtonCubit extends Cubit<Image> {
  MatchButtonCubit() : super(Image.asset("asset/img/match_button.png"));

  void imageButtonSearching({required bool isTablet}) {
    Image imageMatchButton = isTablet == true
        ? Image.asset("asset/img/match_button_searching_tablet.png")
        : Image.asset("asset/img/match_button_searching.png");

    emit(imageMatchButton);
  }

  void imageButtonSearcingCancel({required bool isTablet}) {
    Image imageMatchButton = isTablet == true
        ? Image.asset("asset/img/match_button_tablet.png")
        : Image.asset("asset/img/match_button.png");
    emit(imageMatchButton);
  }

  void imageButtonUseToken({required bool isTablet}) {
    Image imageMatchButton = isTablet == true
        ? Image.asset("asset/img/match_button_use_token_tablet.png")
        : Image.asset("asset/img/match_button_use_token.png");
    emit(imageMatchButton);
  }

  void imageButtonFull({required bool isTablet}) {
    Image imageMatchButton = isTablet == true
        ? Image.asset("asset/img/match_button_full_tablet.png")
        : Image.asset("asset/img/match_button_full.png");
    emit(imageMatchButton);
  }
}
