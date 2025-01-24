part of 'login_bloc.dart';

enum LoginStatus { initial, loading, error, success }

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
  });

  final LoginStatus status;
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    String? emailError,
    bool clearEmailError = false,
    String? passwordError,
    bool clearPasswordError = false,
  }) {
    return LoginState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        emailError: clearEmailError ? null : (emailError ?? this.emailError),
        passwordError: clearPasswordError ? null : (passwordError ?? this.passwordError));
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        emailError,
        passwordError,
      ];
}
