import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'user_models.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: 'https://randomuser.me/api/')
abstract class UserService {
  factory UserService(Dio dio, {String? baseUrl}) = _UserService;

  @GET('/')
  Future<UserResponse> getUser(@Body() Map<String, dynamic> map);
}
