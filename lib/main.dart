import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/environment/env_service.dart';
import 'package:test_task/data/network/auth/user_service.dart';
import 'package:test_task/data/network/feed/feed_service.dart';
import 'package:test_task/data/repositories/feed_repository.dart';
import 'package:test_task/data/repositories/user_repository.dart';

import 'app.dart';

void main() async {
  // app DIO instance
  final dio = Dio();

  // environmental variables
  final envService = EnvService();
  await envService.loadEnv();

  // app services
  final userService = UserService(dio);
  final feedService = FeedService(dio);

  // app repositories
  final userRepository = UserRepository(userService: userService);
  final feedRepository = FeedRepository(feedService: feedService, envService: envService);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: userRepository),
      RepositoryProvider.value(value: feedRepository),
    ],
    child: MyApp(),
  ));
}
