import 'package:isola_app/src/model/user/user_display.dart';
import 'package:isola_app/src/model/user/user_meta.dart';

class UserAll {
  late UserDisplay userDisplay;
  late UserMeta userMeta;
  late bool searchStatus;



  UserAll(
      this.userDisplay,
      this.userMeta,
      this.searchStatus,
);
}
