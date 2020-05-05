import 'dart:async';
import 'dart:developer' as developer;

import 'package:doppio_dev_ixn/home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class UnHomeEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async* {
    yield UnHomeState();
  }
}

class LoadHomeEvent extends HomeEvent {
  @override
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async* {
    try {
      yield UnHomeState();
      yield InHomeState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadHomeEvent', error: _, stackTrace: stackTrace);
      yield ErrorHomeState(_?.toString());
    }
  }
}
