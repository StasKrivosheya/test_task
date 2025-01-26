import 'package:test_task/data/network/auth/user_models.dart';

final class User {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory User.fromResponse(UserResponse user) {
    return User(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      avatar: user.avatar,
    );
  }
}
