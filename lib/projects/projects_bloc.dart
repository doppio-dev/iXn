import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:doppio_dev_ixn/project/project_model.dart';
import 'package:doppio_dev_ixn/projects/index.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  static final ProjectsBloc _projectsBlocSingleton = ProjectsBloc._internal();

  StreamSubscription<ProjectModel> projectSubject;
  factory ProjectsBloc() {
    return _projectsBlocSingleton;
  }
  ProjectsBloc._internal() : super(UnProjectsState()) {
    projectSubject = ProjectsRepository().projectSubject.listen((value) {
      add(LoadProjectsEvent());
    });
  }

  @override
  Future<void> close() async {
    // dispose objects
    await projectSubject.cancel();
    await super.close();
  }

  @override
  Stream<ProjectsState> mapEventToState(
    ProjectsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProjectsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
