import 'dart:async';
import 'dart:developer' as developer;
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:pedantic/pedantic.dart';
import 'package:meta/meta.dart';

import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';

@immutable
abstract class ProjectsEvent {
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc});
}

class UnProjectsEvent extends ProjectsEvent {
  @override
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc}) async* {
    yield UnProjectsState();
  }
}

class LoadProjectsEvent extends ProjectsEvent {
  final projectsCacheManager = ProjectsCacheManager();

  @override
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc}) async* {
    try {
      yield UnProjectsState();
      final projectsMap = await projectsCacheManager.getAllAsync(useExpire: false);
      final projects = projectsMap.cast<Map<dynamic, dynamic>>().map(ProjectModel.fromMap).toList();
      yield InProjectsState(projects: projects);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectsEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectsState(_?.toString());
    }
  }
}

class AddProjectsEvent extends ProjectsEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final ProjectModel projectModel;
  AddProjectsEvent({@required this.projectModel});
  @override
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc}) async* {
    try {
      if (currentState is InProjectsState) {
        await projectsCacheManager.putAsync(projectModel.id, projectModel.toMap());
        final newProjects = [...currentState.projects]..add(projectModel);
        yield currentState.copyWith(projects: newProjects);
        unawaited(navigatorKey.currentState.pushNamed(ProjectPage.routeName, arguments: {'id': projectModel.id}));
        unawaited(navigatorKey.currentState.pushNamed(ProjectSettingPage.routeName, arguments: {'id': projectModel.id}));
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectsEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectsState(_?.toString());
    }
  }
}

class RemoveProjectsEvent extends ProjectsEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final ProjectModel projectModel;
  RemoveProjectsEvent({@required this.projectModel});
  @override
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc}) async* {
    try {
      if (currentState is InProjectsState) {
        await projectsCacheManager.deleteAsync(projectModel.id);
        final newProjects = [...currentState.projects]..remove(projectModel);
        yield currentState.copyWith(projects: newProjects);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectsEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectsState(_?.toString());
    }
  }
}

class ViewProjectsEvent extends ProjectsEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final bool showRemove;
  ViewProjectsEvent({@required this.showRemove});
  @override
  Stream<ProjectsState> applyAsync({ProjectsState currentState, ProjectsBloc bloc}) async* {
    try {
      if (currentState is InProjectsState) {
        yield currentState.copyWith(showRemove: showRemove);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectsEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectsState(_?.toString());
    }
  }
}
