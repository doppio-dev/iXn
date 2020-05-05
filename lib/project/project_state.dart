import 'package:equatable/equatable.dart';

import 'index.dart';

abstract class ProjectState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  ProjectState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ProjectState getStateCopy();

  ProjectState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnProjectState extends ProjectState {
  UnProjectState(int version) : super(version);

  @override
  String toString() => 'UnProjectState';

  @override
  UnProjectState getStateCopy() {
    return UnProjectState(0);
  }

  @override
  UnProjectState getNewVersion() {
    return UnProjectState(version + 1);
  }
}

/// Initialized
class InProjectState extends ProjectState {
  final ProjectModel project;

  InProjectState(int version, this.project) : super(version, [project]);

  @override
  String toString() => 'InProjectState $project';

  @override
  InProjectState getStateCopy() {
    return InProjectState(version, project);
  }

  @override
  InProjectState getNewVersion() {
    return InProjectState(version + 1, project);
  }
}

class ErrorProjectState extends ProjectState {
  final String errorMessage;

  ErrorProjectState(int version, this.errorMessage) : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorProjectState';

  @override
  ErrorProjectState getStateCopy() {
    return ErrorProjectState(version, errorMessage);
  }

  @override
  ErrorProjectState getNewVersion() {
    return ErrorProjectState(version + 1, errorMessage);
  }
}
