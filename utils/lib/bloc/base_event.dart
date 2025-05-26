part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class Initialized extends BaseEvent {
  final Object? data;

  const Initialized([this.data]);

  @override
  List<Object?> get props => [data];
}

class StatusChanged extends BaseEvent {
  final AsyncStatus status;
  final String errorMessage;

  const StatusChanged({required this.status, this.errorMessage = ''});

  @override
  List<Object?> get props => [status, errorMessage];
}
