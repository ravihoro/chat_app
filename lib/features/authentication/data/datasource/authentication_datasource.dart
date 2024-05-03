import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/core/utils/string_constants.dart';
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

  Future<void> logout();
}

class AuthenticationLocalDatasource implements AuthenticationDatasource {
  saveUser(User user) async {
    final userBox = await Hive.openBox<User>(StringConstants.loggedInUser);
    await userBox.clear();
    await userBox.add(
      User(
        username: user.username,
        password: user.password,
        messages: user.messages,
      ),
    );
    await userBox.close();
  }

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    var userBox = await Hive.openBox<User>(StringConstants.users);
    var users = userBox.values.toList();
    for (var user in users) {
      if (user.username == username && user.password == password) {
        saveUser(user);
        await userBox.close();
        return user;
      }
    }
    await userBox.close();
    throw const LoginException(message: 'Username/Password incorrect');
  }

  @override
  Future<User> signUp({
    required String username,
    required String password,
  }) async {
    var userBox = await Hive.openBox<User>(StringConstants.users);

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
    final userBox = await Hive.openBox<User>(StringConstants.loggedInUser);
    final loggedInUser = userBox.isEmpty ? null : userBox.getAt(0);
    userBox.close();

    if (loggedInUser == null) {
      throw Exception("No user found");
    } else {
      return loggedInUser;
    }
  }

  @override
  Future<void> logout() async {
    final userBox = await Hive.openBox<User>(StringConstants.loggedInUser);

    final usersBox = await Hive.openBox<User>(StringConstants.users);

    var currentUser = userBox.values.first;

    for (var e in usersBox.values) {
      if (e.username == currentUser.username) {
        e.messages = currentUser.messages;

        usersBox.putAt(
          usersBox.values.toList().indexOf(e),
          User(
            username: e.username,
            password: e.password,
            messages: e.messages,
          ),
        );
        break;
      }
    }

    await userBox.clear();
    await userBox.close();
    await usersBox.close();
  }
}
