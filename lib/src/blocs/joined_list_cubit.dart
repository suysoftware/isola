// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class JoinedListCubit extends Cubit<List<dynamic>> {
  JoinedListCubit() : super(<dynamic>[]);

  void joinedListAdd(String addingValue) {
    var emitingList = <dynamic>[];
    emitingList.addAll(state);
    emitingList.add(addingValue);

    print("searhingbastıcubit");
    emit(emitingList);
  }

  void joinedListRemove(String removingValue) {
    var emitingList = <dynamic>[];
    emitingList.addAll(state);
    emitingList.remove(removingValue);

    emit(emitingList);
  }

  void joinedListAllAdd(List<dynamic> comingJoinedList) {
    var emitingList = <dynamic>[];

    emitingList.addAll(comingJoinedList);

    print("searhingbastıcubit");
    emit(emitingList);
  }

  void joinedListWithoutNothing(String firstValue) {
    var emitingList = <dynamic>[];
    emitingList.remove("nothing");
    emitingList.add(firstValue);

    emit(emitingList);
  }
}
