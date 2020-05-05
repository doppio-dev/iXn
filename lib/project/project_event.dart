import 'dart:async';
import 'dart:developer' as developer;

import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
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

  @override
  String toString() => 'LoadProjectEvent';

  LoadProjectEvent();

  @override
  Stream<ProjectState> applyAsync({ProjectState currentState, ProjectBloc bloc}) async* {
    try {
      yield UnProjectState(0);
      final args = ModalRoute.of(ContextService().buildContext).settings.arguments as Map<String, Object>;
      final projectMap = await projectsCacheManager.getItemAsync(args['id'] as String);
      final project = ProjectModel.fromMap(projectMap as Map<dynamic, dynamic>);
      yield InProjectState(0, project);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProjectEvent', error: _, stackTrace: stackTrace);
      yield ErrorProjectState(0, _?.toString());
    }
  }
}
