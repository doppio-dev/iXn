import 'dart:async';
import 'dart:developer' as developer;

import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProjectSettingEvent {
  Stream<ProjectSettingState> applyAsync({ProjectSettingState currentState, ProjectSettingBloc bloc});
}

class UnProjectSettingEvent extends ProjectSettingEvent {
  @override
  Stream<ProjectSettingState> applyAsync({ProjectSettingState currentState, ProjectSettingBloc bloc}) async* {
    yield UnProjectSettingState(0);
  }
}

class LoadProjectSettingEvent extends ProjectSettingEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final String id;
  @override
  String toString() => 'LoadProjectSettingEvent';

  LoadProjectSettingEvent(this.id);

  @override
  Stream<ProjectSettingState> applyAsync({ProjectSettingState currentState, ProjectSettingBloc bloc}) async* {
    try {
      yield UnProjectSettingState(0);
      final projectMap = await projectsCacheManager.getItemAsync(id);
      final project = ProjectModel.fromMap(projectMap as Map<dynamic, dynamic>);
      yield InProjectSettingState(0, project);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectSettingEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectSettingState(0, _?.toString());
    }
  }
}

class SaveProjectSettingEvent extends ProjectSettingEvent {
  final projectsCacheManager = ProjectsCacheManager();
  final ProjectModel projectModel;

  @override
  String toString() => runtimeType.toString();

  SaveProjectSettingEvent(this.projectModel);

  @override
  Stream<ProjectSettingState> applyAsync({ProjectSettingState currentState, ProjectSettingBloc bloc}) async* {
    try {
      if (currentState is InProjectSettingState) {
        if (!projectsCacheManager.containsKey(projectModel?.id, useExpire: false)) {
          return;
        }
        await projectsCacheManager.putAsync(projectModel.id, projectModel.toMap());
        ProjectsRepository().projectSubject.add(projectModel);
        yield currentState.copyWith(project: projectModel, version: currentState.version + 1);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectSettingState(0, _?.toString());
    }
  }
}
