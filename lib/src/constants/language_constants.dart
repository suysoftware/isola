import 'package:flutter/cupertino.dart';

class AppConstant {
  // ignore: constant_identifier_names
  static const EN_LOCALE = Locale("en", "US");
  // ignore: constant_identifier_names
  static const TR_LOCALE = Locale("tr", "TR");
  // ignore: constant_identifier_names
  static const ES_LOCALE = Locale("es", "ES");
  // ignore: constant_identifier_names
  static const DE_LOCALE = Locale("de", "DE");
  // ignore: constant_identifier_names
  static const LANG_PATH = "asset/lang";

  // ignore: constant_identifier_names
  static const SUPPORTED_LOCALE = [
    AppConstant.EN_LOCALE,
    AppConstant.TR_LOCALE,
    AppConstant.DE_LOCALE,
    AppConstant.ES_LOCALE,
  ];
}
