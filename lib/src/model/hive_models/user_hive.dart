import 'package:hive/hive.dart';
part 'user_hive.g.dart';

@HiveType(typeId: 1)
class UserHive {
  UserHive({required this.likesData,required this.exloreData});
  @HiveField(0)
  List<String> likesData;

  @HiveField(1)
  List<String> exloreData;

 
}
