import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/network/auth/user_service.dart';
import 'package:test_task/data/repositories/user_repository.dart';

import 'app.dart';

void main() {
  // dependencies
  final dio = Dio();
  final userService = UserService(dio);
  final userRepository = UserRepository(userService);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: userRepository),
    ],
    child: MyApp(),
  ));
}
