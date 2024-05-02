import 'dart:developer';

String? isValidUsername(String? username) {
  if (username == null || username.isEmpty) return "Enter Username";
  return null;
}

String? isValidPassword(String? password) {
  if (password == null || password.isEmpty) {
    log("hereddd");
    return "Enter Password";
  } else if (password.length < 6) {
    log("lengtheeee");
    return "Password should be at least 6 characters long";
  }
  log("nullll");
  return null;
}
