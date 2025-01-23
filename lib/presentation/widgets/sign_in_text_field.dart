import 'package:flutter/material.dart';

class SignInTextField extends StatelessWidget {
  const SignInTextField(
      {super.key, required this.labelText, required this.hintText});

  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
