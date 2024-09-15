import 'package:ball_sort/languages/zh_language.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'en_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': ZhLanguage().zhLanguage,
    'en_US': EnLanguage().enLanguage,
  };
}
