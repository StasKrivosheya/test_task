import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/presentation/widgets/sign_in_text_field.dart';

import '../../blocs/login/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: _LoginLayout(),
      ),
    );
  }
}

class _LoginLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SignInTextField(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        errorText: state.emailError,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(LoginEmailChanged(value)),
                        onFocusLost: () => context
                            .read<LoginBloc>()
                            .add(LoginEmailFocusLost()),
                      ),
                      SizedBox(height: 40),
                      SignInTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        errorText: state.passwordError,
                        obscureText: true,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(LoginPasswordChanged(value)),
                        onFocusLost: () => context
                            .read<LoginBloc>()
                            .add(LoginPasswordFocusLost()),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          overlayColor: Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
