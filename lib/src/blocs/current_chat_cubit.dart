import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentChatCubit extends Cubit<String> {
  CurrentChatCubit() : super("");

  void currentChatReset() {
    emit('');
  }

  void currentChatChanger(String chatNo) {
    emit(chatNo);
  }
}
