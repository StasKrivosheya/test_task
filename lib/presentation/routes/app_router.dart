import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../data/models/user.dart';
import '../pages/login/login_page.dart';
import '../pages/main/main_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: MainRoute.page),
      ];
}
