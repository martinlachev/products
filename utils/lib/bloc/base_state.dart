part of 'base_bloc.dart';

abstract class BaseState extends Equatable {
  final AsyncStatus status;

  const BaseState({this.status = AsyncStatus.initial});

  BaseState copyWith({AsyncStatus? status});

  @override
  List<Object?> get props => [status];
}
