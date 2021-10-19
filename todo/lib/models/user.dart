import 'package:todo/network/models/user_model.dart';

class User {
  String username;
  String email;

  User({required this.username, required this.email});
}

class UserMapper {
  static User fromNetwork(UserModel user) {
    return User(username: user.username, email: user.email);
  }
}
