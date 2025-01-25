import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: 'https://randomuser.me/api/')
abstract class UserService {
  factory UserService(Dio dio, {String? baseUrl}) = _UserService;

  @GET('/')
  Future<UserResponse> getUser(@Body() Map<String, dynamic> map);
}

@JsonSerializable()
class UserCredentials {
  UserCredentials({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$UserCredentialsToJson(this);
}

class UserResponse {
  UserResponse({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final result = json['results'][0];
    final name = result['name'];
    final picture = result['picture'];

    return UserResponse(
      firstName: name['first'],
      lastName: name['last'],
      email: result['email'],
      avatar: picture['large'],
    );
  }
}
