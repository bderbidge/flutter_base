import 'package:flutter_base/infrastructure/interfaces/i_data_source.dart';
import 'package:flutter_base/models/user.dart';
import 'package:flutter_base/services/interfaces/i_user_service.dart';

class UserService implements IUserService {
  UserService({IDataSource db}) : _db = db;

  final String usersPath = "Users";
  final IDataSource _db;

  Future<User> getUser(String id) async {
    try {
      return await _db.getSingle<User>(usersPath, id, User.fromJSON);
    } catch (err) {
      print("getUser: $id Error: $err");
      return null;
    }
  }

  Future<void> createUser(User user) async {
    return await _db.create(path: usersPath, data: user.toJson(), id: user.uid);
  }

  Future<void> updateUser(User user) async {
    _db.update(usersPath, user.uid, user.toJson());
  }
}
