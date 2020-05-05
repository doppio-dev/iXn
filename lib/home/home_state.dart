import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final List propss;
  HomeState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class UnHomeState extends HomeState {
  UnHomeState();

  @override
  String toString() => 'UnHomeState';
}

/// Initialized
class InHomeState extends HomeState {
  final String hello;

  InHomeState(this.hello) : super([hello]);

  @override
  String toString() => 'InHomeState $hello';
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorHomeState';
}
