import 'package:equatable/equatable.dart';

import 'package:doppio_dev_ixn/project/project_model.dart';

abstract class ProjectSettingState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  ProjectSettingState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ProjectSettingState getStateCopy();

  ProjectSettingState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnProjectSettingState extends ProjectSettingState {
  UnProjectSettingState(int version) : super(version);

  @override
  String toString() => 'UnProjectSettingState';

  @override
  UnProjectSettingState getStateCopy() {
    return UnProjectSettingState(0);
  }

  @override
  UnProjectSettingState getNewVersion() {
    return UnProjectSettingState(version + 1);
  }
}

/// Initialized
class InProjectSettingState extends ProjectSettingState {
  final ProjectModel project;

  InProjectSettingState(int version, this.project) : super(version, [project]);

  @override
  String toString() => 'InProjectSettingState $project';

  @override
  InProjectSettingState getStateCopy() {
    return InProjectSettingState(version, project);
  }

  @override
  InProjectSettingState getNewVersion() {
    return InProjectSettingState(version + 1, project);
  }

  InProjectSettingState copyWith({
    int version,
    ProjectModel project,
  }) {
    return InProjectSettingState(
      version ?? this.version,
      project ?? this.project,
    );
  }
}

class ErrorProjectSettingState extends ProjectSettingState {
  final String errorMessage;

  ErrorProjectSettingState(int version, this.errorMessage) : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorProjectSettingState';

  @override
  ErrorProjectSettingState getStateCopy() {
    return ErrorProjectSettingState(version, errorMessage);
  }

  @override
  ErrorProjectSettingState getNewVersion() {
    return ErrorProjectSettingState(version + 1, errorMessage);
  }
}
