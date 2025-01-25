// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({Key? key, required User user, List<PageRouteInfo>? children})
    : super(
        MainRoute.name,
        args: MainRouteArgs(key: key, user: user),
        initialChildren: children,
      );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainRouteArgs>();
      return MainPage(key: args.key, user: args.user);
    },
  );
}

class MainRouteArgs {
  const MainRouteArgs({this.key, required this.user});

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, user: $user}';
  }
}
