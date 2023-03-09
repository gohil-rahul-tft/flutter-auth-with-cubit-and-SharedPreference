part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess<T> extends LoginState {
  final LoginResponse data;

  const LoginSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class LogoutSuccess extends LoginState {
  const LogoutSuccess();

  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
