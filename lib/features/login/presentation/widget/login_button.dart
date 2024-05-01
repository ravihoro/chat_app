import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_login_elevatedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: state.isValid == null || !state.isValid!
              ? null
              : () {
                  context.read<AuthenticationCubit>().login(
                        username: context.read<LoginCubit>().state.username!,
                        password: context.read<LoginCubit>().state.password!,
                      );
                },
          child: const Text('Login'),
        );
      },
    );
  }
}
