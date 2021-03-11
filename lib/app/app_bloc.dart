import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:doppio_dev_ixn/app/index.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static final _appBlocSingleton = AppBloc._internal();
  factory AppBloc() {
    return _appBlocSingleton;
  }
  AppBloc._internal() : super(UnAppState());

  @override
  Future<void> close() async {
    // dispose objects
    await _appBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'AppBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
