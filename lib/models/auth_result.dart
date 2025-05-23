import 'user_model.dart';

class AuthResult {
  final String token;
  final UserModel user;

  AuthResult({required this.token, required this.user});
}
