import 'package:chat_app/core/utils/injection_container.dart';
import 'package:chat_app/core/widgets/authentication_scaffold.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/login/presentation/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      child: BlocProvider<LoginCubit>(
        create: (_) => sl<LoginCubit>(),
        child: const AuthenticationScaffold(
          text: 'Login',
          child: LoginForm(),
        ),
      ),
    );
  }
}
