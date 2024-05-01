import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String username;
  final String password;
  final bool isValid;

  const SignUpState({
    this.username = "",
    this.password = "",
    this.isValid = false,
  });

  SignUpState copyWith({
    String? username,
    String? password,
    bool? isValid,
  }) {
    return SignUpState(
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isValid,
      ];
}
