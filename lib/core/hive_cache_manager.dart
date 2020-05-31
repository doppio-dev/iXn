import 'package:doppio_dev_ixn/core/logger.dart';

import 'package:hive/hive.dart';
import 'package:semaphore/semaphore.dart';
import 'package:pedantic/pedantic.dart';

class HiveCacheManager {
  String _key = 'cache_v2';
  String _nameLogger = 'HiveCacheManager';
  String _keyTime = 'cache_time_v2';
  Duration _duration = Duration(hours: 8);
  final _sm = LocalSemaphore(1);

  static HiveCacheManager _instance;
  Stream<dynamic> _compactStream;
  LazyBox<dynamic> _box;
  Box<dynamic> _boxTime;

  factory HiveCacheManager() {
    _instance ??= HiveCacheManager.internal();
    return _instance;
  }

  void init(String name, Duration duration) {
    _key = '${name.toLowerCase()}$_key';
    _nameLogger = '$name$_nameLogger';
    _keyTime = '${name.toLowerCase()}$_keyTime';
    _duration = duration;
  }

  Future<void> openAsync() async {
    final path = _key;
    final pathTime = _keyTime;
    _box = await Hive.openLazyBox(_key, path: path);
    _boxTime = await Hive.openBox(_keyTime, path: pathTime);
    _compactStream = Stream<void>.periodic(const Duration(seconds: 311));
    unawaited(_compactStream.forEach((_) async {
      await _box.compact();
      await _boxTime.compact();
    }));
  }

  HiveCacheManager.internal();

  bool containsKey(String itemId, {bool useExpire = true}) {
    try {
      _sm.acquire();
      return _containsKey(itemId, useExpire: useExpire);
    } catch (error, stackTrace) {
      log('$error', name: _nameLogger, error: error, stackTrace: stackTrace);
      return false;
    } finally {
      _sm.release();
    }
  }

  bool _containsKey(
    String itemId, {
    bool useExpire,
  }) {
    if (useExpire == true && _duration != null) {
      if (!_boxTime.containsKey(itemId)) {
        return false;
      }
      final time = _boxTime.get(itemId) as DateTime;
      final difference = time.difference(DateTime.now());
      if (difference > _duration) {
        _boxTime.delete(itemId);
        return false;
      }
    }
    if (!_box.containsKey(itemId)) {
      return false;
    }
    return true;
  }

  /// offsetExpire - less time save  (if add time)
  Future<void> putAsync(String key, dynamic value, {Duration offsetExpire, bool useExpire = true}) async {
    try {
      await _sm.acquire();
      if (useExpire == true && _duration != null) {
        var time = DateTime.now();
        if (offsetExpire != null) {
          time.add(offsetExpire);
        }
        await _boxTime.put(key, time);
      }
      await _box.put(key, value);
    } finally {
      _sm.release();
    }
  }

  Future<dynamic> getItemAsync(String keyId, {bool useExpire = true}) async {
    try {
      await _sm.acquire();
      return await (_getItemAsync(keyId, useExpire: useExpire));
    } finally {
      _sm.release();
    }
  }

  Future<dynamic> _getItemAsync(String keyId, {bool useExpire = true}) async {
    try {
      if (useExpire == true) {
        if (_containsKey(keyId, useExpire: useExpire) == false) return null;
      }
      return await _box.get(keyId);
    } finally {}
  }

  Future<List<dynamic>> getAllAsync({bool useExpire = true}) async {
    try {
      await _sm.acquire();
      final keys = _box.keys.toList();
      final result = [];
      for (var item in keys) {
        final map = await _getItemAsync(item.toString(), useExpire: useExpire);
        result.add(map);
      }
      return result;
    } finally {
      _sm.release();
    }
  }

  Future<void> deleteAsync(String keyCurrent) async {
    try {
      await _sm.acquire();
      await _box.delete(keyCurrent);
      await _boxTime.delete(keyCurrent);
    } finally {
      _sm.release();
    }
  }

  Future<void> compactAsync() async {
    try {
      await _sm.acquire();
      await _box.compact();
      await _boxTime.compact();
    } finally {
      _sm.release();
    }
  }
}
