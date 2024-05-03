import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpState? initialState;

  SignUpCubit({this.initialState}) : super(initialState ?? const SignUpState());

  bool isValid({
    String? username,
    String? password,
  }) {
    username = username ?? state.username;
    password = password ?? state.password;
    return isValidUsername(username) == null &&
        isValidPassword(password) == null;
  }

  void obscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  setUsername(String? username) {
    emit(
      state.copyWith(
        username: username,
        isValid: isValid(
          username: username,
        ),
      ),
    );
  }

  setPassword(String? password) {
    emit(
      state.copyWith(
        password: password,
        isValid: isValid(
          password: password,
        ),
      ),
    );
  }
}
