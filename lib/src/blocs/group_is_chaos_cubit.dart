import 'package:flutter_bloc/flutter_bloc.dart';

class ChatIsChaosCubit extends Cubit<bool> {
  ChatIsChaosCubit() : super(false);

  void chatIsChaosTrue() {
    emit(true);
  }

  void chatIsChaosFalse() {
    emit(false);
  }
}
