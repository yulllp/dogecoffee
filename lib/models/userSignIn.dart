import 'package:doge_coffee/models/user.dart';

class UserSignInResult {
  final User? user;
  final String token;

  UserSignInResult({required this.user, required this.token});

  factory UserSignInResult.fromJson(Map<String, dynamic> json) {
    return UserSignInResult(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}
