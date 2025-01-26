import 'package:json_annotation/json_annotation.dart';

part 'user_models.g.dart';

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
