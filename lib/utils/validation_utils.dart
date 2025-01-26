class ValidationUtils {
  static ({bool isValidEmail, String? errorMessage}) validateEmail(
      String email) {
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

  static ({bool isValidPassword, String? errorMessage}) validatePassword(
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
