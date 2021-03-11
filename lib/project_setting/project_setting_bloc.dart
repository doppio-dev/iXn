import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingBloc extends Bloc<ProjectSettingEvent, ProjectSettingState> {
  ProjectSettingBloc() : super(UnProjectSettingState(0));

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  Stream<ProjectSettingState> mapEventToState(
    ProjectSettingEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProjectSettingBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
