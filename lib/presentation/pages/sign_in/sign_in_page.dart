import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:test_task/presentation/widgets/sign_in_text_field.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SignInTextField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: 40),
                    SignInTextField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: Size(double.infinity, 40),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
