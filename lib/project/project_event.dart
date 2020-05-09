import 'dart:async';
import 'dart:developer' as developer;

import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProjectEvent {
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc});
}

class UnProjectEvent extends ProjectEvent {
  @override
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc}) async* {
    yield UnProjectState(0);
  }
}

class LoadProjectEvent extends ProjectEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final String id;

  @override
  String toString() => 'LoadProjectEvent';

  LoadProjectEvent(this.id);

  @override
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc}) async* {
    try {
      yield UnProjectState(0);
      final projectMap = await projectsCacheManager.getItemAsync(id);
      final project = ProjectModel.fromMap(projectMap as Map<dynamic, dynamic>);
      yield InProjectState(0, project);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectState(0, _?.toString());
    }
  }
}

class SaveProjectEvent extends ProjectEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final ProjectModel projectModel;

  @override
  String toString() => runtimeType.toString();

  SaveProjectEvent(this.projectModel);

  @override
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc}) async* {
    try {
      if (currentState is InProjectState) {
        if (!projectsCacheManager.containsKey(projectModel?.id, useExpire: false)) {
          return;
        }
        await projectsCacheManager.putAsync(projectModel.id, projectModel.toMap());

        ProjectsBloc().add(LoadProjectsEvent());
        yield currentState.copyWith(project: projectModel, version: currentState.version + 1);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectState(0, _?.toString());
    }
  }
}

class LoadSettingProjectEvent extends ProjectEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final String id;

  @override
  String toString() => 'LoadSettingProjectEvent';

  LoadSettingProjectEvent(this.id);

  @override
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc}) async* {
    try {
      if (currentState is InProjectState) {
        if (currentState.project.id != id) {
          return;
        }
        final projectMap = await projectsCacheManager.getItemAsync(id);
        final project = ProjectModel.fromMap(projectMap as Map<dynamic, dynamic>);
        yield currentState.copyWith(
            project: project.copySettings(
              name: project.name,
              defaultLocale: project.defaultLocale,
              locales: project.locales,
            ),
            version: currentState.version + 1);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadSettingProjectEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectState(0, _?.toString());
    }
  }
}
