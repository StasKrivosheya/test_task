import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginEmailFocusLost>(_onLoginEmailFocusLost);
    on<LoginPasswordFocusLost>(_onLoginPasswordFocusLost);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final (:isValidEmail, :errorMessage) = _validateEmail(event.email);
    emit(state.copyWith(
      email: event.email,
      emailError: errorMessage,
      clearEmailError: isValidEmail,
    ));
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final (:isValidPassword, :errorMessage) = _validatePassword(event.password);
    emit(state.copyWith(
      password: event.password,
      passwordError: errorMessage,
      clearPasswordError: isValidPassword,
    ));
  }

  void _onLoginEmailFocusLost(
      LoginEmailFocusLost event, Emitter<LoginState> emit) {
    final (:isValidEmail, :errorMessage) = _validateEmail(state.email);
    emit(state.copyWith(
      emailError: errorMessage,
      clearEmailError: isValidEmail,
    ));
  }

  void _onLoginPasswordFocusLost(
      LoginPasswordFocusLost event, Emitter<LoginState> emit) {
    final (:isValidPassword, :errorMessage) = _validatePassword(state.password);
    emit(state.copyWith(
      passwordError: errorMessage,
      clearPasswordError: isValidPassword,
    ));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) {
    // TODO: perform final check
    // TODO: set loader
    // TODO: perform request
    // TODO: perform navigation
  }

  ({bool isValidEmail, String? errorMessage}) _validateEmail(String email) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&\'*+\\/=?^_`{|}~-]{1,10}@(?:(?!.*--)[a-zA-Z0-9-]{1,10}(?<!-))(?:\.(?:[a-zA-Z0-9-]{2,10}))+");
    final isValidEmail = email.isNotEmpty &&
        email.length >= 6 &&
        email.length <= 30 &&
        regex.hasMatch(email);
    const errorMessage = 'Email is incorrect';
    return (
      isValidEmail: isValidEmail,
      errorMessage: isValidEmail ? null : errorMessage
    );
  }

  ({bool isValidPassword, String? errorMessage}) _validatePassword(
      String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]')) ||
        password.contains(RegExp(r'[А-Я]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]')) ||
        password.contains(RegExp(r'[а-я]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final isValidPassword = password.isNotEmpty &&
        password.length >= 6 &&
        password.length <= 10 &&
        hasUppercase &&
        hasLowercase &&
        hasDigit;

    const errorMessage = 'Password is incorrect';

    return (
      isValidPassword: isValidPassword,
      errorMessage: isValidPassword ? null : errorMessage
    );
  }
}
