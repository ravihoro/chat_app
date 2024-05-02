import 'package:chat_app/core/widgets/custom_elevation_button.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return CustomElevatedButton(
          buttonText: "Login",
          keyText: 'loginForm_login_elevatedButton',
          onPressed: !state.isValid
              ? null
              : () {
                  var loginState = context.read<LoginCubit>().state;
                  context.read<AuthenticationCubit>().login(
                        username: loginState.username!,
                        password: loginState.password!,
                      );
                },
        );
      },
    );
  }
}
