import 'package:flutter/material.dart';

class SignInTextField extends StatelessWidget {
  const SignInTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
    this.onFocusLost,
  });

  final String labelText;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFocusLost;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          onFocusLost?.call();
        }
      },
      child: TextField(
        onChanged: onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
