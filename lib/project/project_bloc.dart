import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  StreamSubscription<ProjectModel> projectSubject;

  @override
  Future<void> close() async {
    // dispose objects
    await projectSubject.cancel();
    await super.close();
  }

  ProjectBloc() : super(UnProjectState(0)) {
    projectSubject = ProjectsRepository().projectSubject.listen((value) {
      add(LoadSettingProjectEvent(value.id));
    });
  }

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
