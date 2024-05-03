import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? username;
  final String? password;
  final bool obscureText;
  final bool isValid;

  const LoginState({
    this.username,
    this.password,
    this.obscureText = true,
    this.isValid = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? obscureText,
    bool? isValid,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      obscureText: obscureText ?? this.obscureText,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isValid,
        obscureText,
      ];
}
