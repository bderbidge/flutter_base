import 'package:flutter_base/models/user.dart';

abstract class IUserService {
  Future<User> getUser(String id);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
}
