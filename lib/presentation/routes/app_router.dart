import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, initial: true),
      ];
}
