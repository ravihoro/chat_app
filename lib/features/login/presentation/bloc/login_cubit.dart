import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginState? initialState;

  LoginCubit({
    this.initialState,
  }) : super(
          initialState ?? const LoginState(),
        );

  void obscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  bool isValid({String? username, String? password}) {
    username = username ?? state.username;
    password = password ?? state.password;
    return isValidUsername(username) == null &&
        isValidPassword(password) == null;
  }

  setUsername(String? value) {
    emit(state.copyWith(
      username: value,
      isValid: isValid(username: value),
    ));
  }

  setPassword(String? value) {
    emit(state.copyWith(
      password: value,
      isValid: isValid(password: value),
    ));
  }
}
