import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';

class UserHiveCubit extends Cubit<UserHive> {
  final UserHive userHive;
  UserHiveCubit(this.userHive) : super(userHive);

  void userHiveLikeAdd(String element) async {
    var box = await Hive.openBox('userHive');
    UserHive userHive = box.get('datetoday');
    userHive.likesData.add(element);
    box.put('datetoday', userHive);
    emit(userHive);
  }

  void userHiveLikeDelete(String element) async {
    var box = await Hive.openBox('userHive');
    UserHive userHive = box.get('datetoday');
    userHive.likesData.remove(element);
    box.put('datetoday', userHive);
    emit(userHive);
  }
}
