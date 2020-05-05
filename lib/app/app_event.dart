import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';
import 'package:doppio_dev_ixn/app/index.dart';
import 'package:meta/meta.dart';

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
      yield InAppState(0);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadAppEvent', error: _, stackTrace: stackTrace);
      yield ErrorAppState(errorMessage: _?.toString());
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
