import 'dart:developer';

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

  Future<void> logout();
}

class AuthenticationLocalDatasource implements AuthenticationDatasource {
  saveUser(User user) async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    await userBox.clear();
    log("save user: ${user.messages.length}");
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
    var userBox = await Hive.openBox<User>('users');
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

  @override
  Future<void> logout() async {
    final userBox = await Hive.openBox<User>('logged_in_user');

    final usersBox = await Hive.openBox<User>('users');

    var currentUser = userBox.values.first;

    for (var e in usersBox.values) {
      log("e: ${e.messages.length} current: ${currentUser.messages.length}");
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
