import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String? username;
  final String? password;
  final bool isValid;
  final bool obscureText;

  const SignUpState({
    this.username,
    this.password,
    this.obscureText = true,
    this.isValid = false,
  });

  SignUpState copyWith({
    String? username,
    String? password,
    bool? isValid,
    bool? obscureText,
  }) {
    return SignUpState(
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
