import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/repositories/user_repository.dart';
import 'package:test_task/presentation/routes/app_router.dart';
import 'package:test_task/presentation/widgets/sign_in_text_field.dart';

import '../../blocs/login/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(userRepository: context.read<UserRepository>()),
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
                child: Text('Sign in',
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == LoginStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      showCloseIcon: true,
                      behavior: SnackBarBehavior.floating,
                      content: Text('Server error. Please, try again'),
                    ));
                  } else if (state.status == LoginStatus.success) {
                    final parameter = state.user!;
                    context.router.replace(MainRoute(user: parameter));
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SignInTextField(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        errorText: state.emailError,
                        disabled: state.status == LoginStatus.loading,
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
                        disabled: state.status == LoginStatus.loading,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(LoginPasswordChanged(value)),
                        onFocusLost: () => context
                            .read<LoginBloc>()
                            .add(LoginPasswordFocusLost()),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (state.status != LoginStatus.loading) {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          overlayColor: Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Builder(builder: (context) {
                          if (state.status == LoginStatus.loading) {
                            return SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            );
                          }
                          return Text(
                            'Log in',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600),
                          );
                        }),
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
