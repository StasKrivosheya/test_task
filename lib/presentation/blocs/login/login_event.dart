part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class LoginEmailFocusLost extends LoginEvent {}

final class LoginPasswordFocusLost extends LoginEvent {}

final class LoginSubmitted extends LoginEvent {}
