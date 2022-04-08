// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchStatusCubit extends Cubit<bool> {
  SearchStatusCubit() : super(false);

  void searching() {
    emit(true);
  }

  void pauseSearching() {
    emit(false);
  }
}
