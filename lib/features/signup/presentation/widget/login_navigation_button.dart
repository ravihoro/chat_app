import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginNavigationButton extends StatelessWidget {
  const LoginNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const ValueKey("login_navigation_key"),
      child: const Text('Login'),
      onPressed: () {
        context.read<AuthenticationCubit>().setIsLoginPage(true);
      },
    );
  }
}
