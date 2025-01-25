import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_task/data/network/auth/user_service.dart';
import 'package:test_task/data/network/feed/feed_service.dart';
import 'package:test_task/data/repositories/feed_repository.dart';
import 'package:test_task/data/repositories/user_repository.dart';

import 'app.dart';

void main() async {
  // initializations
  await initPackages();

  // custom dependencies
  final repositoryProviders = getRepositoryProviders();

  runApp(MultiRepositoryProvider(
    providers: repositoryProviders,
    child: MyApp(),
  ));
}

Future initPackages() async {
  await dotenv.load();
}

List<RepositoryProvider> getRepositoryProviders() {
  final dio = Dio();

  final userService = UserService(dio);
  final userRepository = UserRepository(userService);

  final feedService = FeedService(dio);
  final feedRepository = FeedRepository(feedService);

  return [
    RepositoryProvider.value(value: userRepository),
    RepositoryProvider.value(value: feedRepository),
  ];
}
