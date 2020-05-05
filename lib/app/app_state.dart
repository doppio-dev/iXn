import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class AppState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  AppState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  AppState getStateCopy();

  AppState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnAppState extends AppState {
  UnAppState({int version = 0}) : super(version);

  @override
  String toString() => 'UnAppState';

  @override
  UnAppState getStateCopy() {
    return UnAppState();
  }

  @override
  UnAppState getNewVersion() {
    return UnAppState(version: version + 1);
  }
}

/// Initialized
class InAppState extends AppState {
  InAppState(int version) : super(version, []);

  @override
  String toString() => 'InAppState';

  @override
  InAppState getStateCopy() {
    return InAppState(version);
  }

  @override
  InAppState getNewVersion() {
    return InAppState(version + 1);
  }
}

class ErrorAppState extends AppState {
  final String errorMessage;

  ErrorAppState({int version = 0, @required this.errorMessage}) : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorAppState';

  @override
  ErrorAppState getStateCopy() {
    return ErrorAppState(version: version, errorMessage: errorMessage);
  }

  @override
  ErrorAppState getNewVersion() {
    return ErrorAppState(version: version + 1, errorMessage: errorMessage);
  }
}
