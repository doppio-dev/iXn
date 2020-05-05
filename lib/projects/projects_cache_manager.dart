import 'package:doppio_dev_ixn/core/hive_cache_manager.dart';

class ProjectsCacheManager extends HiveCacheManager {
  static ProjectsCacheManager _instance;
  factory ProjectsCacheManager() {
    if (_instance == null) {
      _instance = ProjectsCacheManager._internal();
      _instance.init('Projects', null);
    }
    return _instance;
  }
  ProjectsCacheManager._internal() : super.internal();
}
