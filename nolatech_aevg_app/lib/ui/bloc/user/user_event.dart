/*
part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
*/

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//class AppStarted extends UserEvent {}

class RegisterUserEvent extends UserEvent {
  final UserAppModel register;

  RegisterUserEvent(this.register);

  @override
  List<Object> get props => [register];
}
