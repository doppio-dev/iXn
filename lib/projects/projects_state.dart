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

  InProjectsState({this.projects}) : super([projects]);

  @override
  String toString() => 'InProjectsState $projects';

  InProjectsState copyWith({
    List<ProjectModel> projects,
  }) {
    return InProjectsState(
      projects: projects ?? [...this.projects],
    );
  }
}

class ErrorProjectsState extends ProjectsState {
  final String errorMessage;

  ErrorProjectsState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorProjectsState';
}
