String? isValidUsername(String? username) {
  if (username == null || username.isEmpty) return "Enter Username";
  return null;
}

String? isValidPassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Enter Password";
  } else if (password.length < 6) {
    return "Password should be at least 6 characters long";
  }
  return null;
}
