import 'package:doppio_dev_ixn/core/hive_cache_manager.dart';

class AutoTranslateCacheManager extends HiveCacheManager {
  static AutoTranslateCacheManager _instance;
  factory AutoTranslateCacheManager() {
    if (_instance == null) {
      _instance = AutoTranslateCacheManager._internal();
      _instance.init('AutoTranslate', null);
    }
    return _instance;
  }
  AutoTranslateCacheManager._internal() : super.internal();
}
