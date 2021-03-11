import 'dart:async';

import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/app/index.dart';
import 'package:doppio_dev_ixn/core/logger.dart';
import 'package:doppio_dev_ixn/core/simple_bloc_delegate.dart';

import 'project/index.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mainApp');
String appVersion;

Future<void> main() async {
  await init();
  await runZonedGuarded<Future<Null>>(() async {
    runApp(AppPage());
  }, (Object error, StackTrace stackTrace) async {
    log('$error', name: 'Main', error: error, stackTrace: stackTrace);
  });
}

Future<void> init({bool ensureInitialized = true}) async {
  try {
    if (ensureInitialized == true) {
      WidgetsFlutterBinding.ensureInitialized();
    }
    Bloc.observer = SimpleBlocObserver();
    await ProjectsCacheManager().openAsync();
    await AutoTranslateCacheManager().openAsync();
    appVersion = '0.1.0+1';
  } catch (error, stackTrace) {
    log('$error', name: 'Main', error: '$error', stackTrace: stackTrace);
  }
}
