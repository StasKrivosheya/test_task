import 'package:test_task/data/models/user.dart';
import 'package:test_task/data/network/auth/user_models.dart';
import 'package:test_task/data/network/auth/user_service.dart';

class UserRepository {
  UserRepository({required UserService userService})
      : _userService = userService;

  final UserService _userService;

  Future<User?> loginWith({required String email, required String password}) async {
    try {
      final userCredentials = UserCredentials(email: email, password: password);

      final userResponse = await _userService.getUser(userCredentials.toJson());

      return User.fromResponse(userResponse);
    } catch (e) {
      // handle error if necessary
      return null;
    }
  }
}
