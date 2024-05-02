import 'dart:developer';

import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/features/authentication/domain/usecase/authentication_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationState? initialState;

  final AuthenticationUsecase _usecase;

  AuthenticationCubit({
    this.initialState,
    required AuthenticationUsecase usecase,
  })  : _usecase = usecase,
        super(initialState ?? const AuthenticationState());

  resetState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(state.copyWith());
    });
  }

  emitUser(User? user) {
    emit(state.copyWith(user: user));
  }

  setIsLoginPage(bool value) {
    emit(state.copyWith(isLoginPage: value));
  }

  void checkIfLoggedIn() async {
    var either = await _usecase.checkIfLoggedIn();
    either.fold(
      (l) => log(
        l.toString(),
      ),
      (r) => emit(
        state.copyWith(
          user: r,
        ),
      ),
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    var either = await _usecase.login(
      username: username,
      password: password,
    );
    either.fold(
      (l) {
        emit(state.copyWith(error: l.error));
        resetState();
      },
      (r) => emit(
        state.copyWith(user: r),
      ),
    );
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    var either = await _usecase.signUp(
      username: username,
      password: password,
    );
    either.fold(
      (l) {
        emit(state.copyWith(error: l.error));
        resetState();
      },
      (r) => emit(
        state.copyWith(user: r),
      ),
    );
  }

  void logout() async {
    var failure = await _usecase.logout();
    if (failure != null) {
      emit(state.copyWith(error: failure.error));
      resetState();
    } else {
      emit(state.copyWith());
    }
  }
}
