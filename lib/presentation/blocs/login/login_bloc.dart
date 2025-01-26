import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task/data/models/user.dart';
import 'package:test_task/data/repositories/user_repository.dart';
import 'package:test_task/utils/validation_utils.dart';

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
    final (:isValidEmail, :errorMessage) = ValidationUtils.validateEmail(state.email);
    emit(state.copyWith(
      emailError: errorMessage,
      clearEmailError: isValidEmail,
    ));
  }

  void _onLoginPasswordFocusLost(
      LoginPasswordFocusLost event, Emitter<LoginState> emit) {
    final (:isValidPassword, :errorMessage) =
        ValidationUtils.validatePassword(state.password);
    emit(state.copyWith(
      passwordError: errorMessage,
      clearPasswordError: isValidPassword,
    ));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final (:isValidEmail, errorMessage: errorMessageEmail) =
        ValidationUtils.validateEmail(state.email);
    final (:isValidPassword, errorMessage: errorMessagePassword) =
        ValidationUtils.validatePassword(state.password);

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
}
