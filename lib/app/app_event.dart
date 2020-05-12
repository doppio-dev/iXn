import 'dart:async';
import 'dart:developer' as developer;

import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/widgets.dart';
import 'package:doppio_dev_ixn/app/index.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class AppEvent {
  Stream<AppState> applyAsync({AppState currentState, AppBloc bloc});
}

class UnAppEvent extends AppEvent {
  @override
  Stream<AppState> applyAsync({AppState currentState, AppBloc bloc}) async* {
    yield UnAppState();
  }
}

class LoadAppEvent extends AppEvent {
  @override
  Stream<AppState> applyAsync({AppState currentState, AppBloc bloc}) async* {
    try {
      yield UnAppState();
      unawaited(checkUpdate());
      yield InAppState(0);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadAppEvent', error: _, stackTrace: stackTrace);
      yield ErrorAppState(errorMessage: _?.toString());
    }
  }

  Future checkUpdate() async {
    final response = await http.get('https://github.com/doppio-dev/iXn/tags');
    if (response.statusCode == 200) {
      final exp = RegExp(r'(v_\d+\.\d+\.\d+\+\(\d+\))');
      final lastReleaseMatch = exp?.firstMatch(response.body);
      final lastRelease = lastReleaseMatch?.group(0)?.replaceAll('(', '')?.replaceAll(')', '');
      if (lastRelease?.substring(2) != appVersion) {
        NotificationService.showUpdate();
      }
    }
  }
}

class ChangeThemeAppEvent extends AppEvent {
  @override
  String toString() => 'ChangeThemeAppEvent';

  ChangeThemeAppEvent();

  @override
  Stream<AppState> applyAsync({AppState currentState, AppBloc bloc}) async* {
    yield currentState.getNewVersion();
  }
}

class ChangeLocaleAppEvent extends AppEvent {
  final Locale locale;
  @override
  String toString() => 'ChangeLocaleAppEvent $locale';

  ChangeLocaleAppEvent(this.locale);

  @override
  Stream<AppState> applyAsync({AppState currentState, AppBloc bloc}) async* {
    yield currentState.getNewVersion();
  }
}
