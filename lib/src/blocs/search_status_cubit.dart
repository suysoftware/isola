// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchStatusCubit extends Cubit<bool> {
  SearchStatusCubit() : super(false);

  void searching() {
      print("searhingbastıcubit");
    emit(true);
  }

  void pauseSearching() {
     print("pausesearhingbastıcubit");
    emit(false);
  }
}
