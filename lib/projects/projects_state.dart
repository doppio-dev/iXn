import 'package:equatable/equatable.dart';

import 'package:doppio_dev_ixn/project/index.dart';

abstract class ProjectsState extends Equatable {
  final List propss;
  ProjectsState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class UnProjectsState extends ProjectsState {
  UnProjectsState();

  @override
  String toString() => 'UnProjectsState';
}

/// Initialized
class InProjectsState extends ProjectsState {
  final List<ProjectModel> projects;
  final bool showRemove;
  InProjectsState({this.projects, this.showRemove = false}) : super([projects, showRemove]);

  @override
  String toString() => 'InProjectsState $projects';

  InProjectsState copyWith({
    List<ProjectModel> projects,
    bool showRemove,
  }) {
    return InProjectsState(projects: projects ?? [...this.projects], showRemove: showRemove ?? this.showRemove);
  }
}

class ErrorProjectsState extends ProjectsState {
  final String errorMessage;

  ErrorProjectsState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorProjectsState';
}
