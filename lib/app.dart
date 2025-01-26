import 'package:flutter/material.dart';

import 'presentation/routes/app_router.dart';
import 'presentation/theme/theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Test Task App',
      themeMode: ThemeMode.light,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
    );
  }
}
