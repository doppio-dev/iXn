import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

void logBuild(String message, String name) {
  log(message, name: name, render: true);
}

void log(
  String message, {
  DateTime time,
  int sequenceNumber,
  int level = 0,
  String name = '',
  dynamic error,
  StackTrace stackTrace,
  bool render,
}) {
  if (render == true) {
    return;
  }

  if (kIsWeb) {
    var postfix = '';
    if (error != null) {
      postfix = ', error: $error; stackTrace: $stackTrace';
    }
    print('$name: $message $postfix');
  }

  developer.log(message ?? '', name: name, error: error, stackTrace: stackTrace);
}
