import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:doppio_dev_ixn/project/index.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  ProjectState get initialState => UnProjectState(0);

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProjectBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
