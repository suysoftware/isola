import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreDataCubit extends Cubit<List<dynamic>> {
  ExploreDataCubit() : super(["d"]);

  void exploreChanger(newList) {
    emit(newList);
  }
}
