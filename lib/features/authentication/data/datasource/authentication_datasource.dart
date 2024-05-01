import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:hive/hive.dart';

abstract class AuthenticationDatasource {
  Future<User> login({
    required String username,
    required String password,
  });

  Future<User> signUp({
    required String username,
    required String password,
  });

  Future<User> checkIfLoggedIn();
}

class AuthenticationLocalDatasource implements AuthenticationDatasource {
  saveUser(User user) async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    await userBox.clear();
    await userBox.add(User(username: user.username, password: user.password));
    userBox.close();
  }

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    var userBox = await Hive.openBox<User>('users');
    var users = userBox.values.toList();
    for (var user in users) {
      if (user.username == username && user.password == password) {
        saveUser(user);
        return user;
      }
    }
    userBox.close();
    throw const LoginException(message: 'Username/Password incorrect');
  }

  @override
  Future<User> signUp({
    required String username,
    required String password,
  }) async {
    var userBox = await Hive.openBox<User>('users');

    var existingUsers =
        userBox.values.where((user) => user.username == username);
    if (existingUsers.isNotEmpty) {
      throw const SignUpException(
        message: 'User already exists',
      );
    }

    var newUser = User(username: username, password: password);
    await userBox.add(newUser);
    saveUser(newUser);
    userBox.close();
    return newUser;
  }

  @override
  Future<User> checkIfLoggedIn() async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    final loggedInUser = userBox.isEmpty ? null : userBox.getAt(0);
    userBox.close();

    if (loggedInUser == null) {
      throw Exception("No user found");
    } else {
      return loggedInUser;
    }
  }
}
