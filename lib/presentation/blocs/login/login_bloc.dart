import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task/data/models/user.dart';
import 'package:test_task/data/repositories/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginEmailFocusLost>(_onLoginEmailFocusLost);
    on<LoginPasswordFocusLost>(_onLoginPasswordFocusLost);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final UserRepository _userRepository;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      clearEmailError: true,
    ));
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      clearPasswordError: true,
    ));
  }

  void _onLoginEmailFocusLost(LoginEmailFocusLost event, Emitter<LoginState> emit) {
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

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final (:isValidEmail, errorMessage: errorMessageEmail) =
        _validateEmail(state.email);
    final (:isValidPassword, errorMessage: errorMessagePassword) =
        _validatePassword(state.password);

    final inputsValid = isValidEmail && isValidPassword;

    if (!inputsValid) {
      emit(state.copyWith(
        emailError: errorMessageEmail,
        clearEmailError: isValidEmail,
        passwordError: errorMessagePassword,
        clearPasswordError: isValidPassword,
      ));
    }

    final canProceed = inputsValid && state.status != LoginStatus.loading;

    if (canProceed) {
      // set loader
      emit(state.copyWith(status: LoginStatus.loading));

      //  perform request
      var resultUser = await _userRepository.loginWith(
          email: state.email, password: state.password);

      // notify result
      if (resultUser == null) {
        emit(state.copyWith(status: LoginStatus.error));
      } else {
        emit(state.copyWith(status: LoginStatus.success, user: resultUser));
      }
    }
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
