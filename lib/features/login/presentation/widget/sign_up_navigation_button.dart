import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpNavigationButton extends StatelessWidget {
  const SignUpNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const ValueKey("sign_up_navigation_key"),
      child: const Text('Sign Up'),
      onPressed: () {
        context.read<AuthenticationCubit>().setIsLoginPage(false);
      },
    );
  }
}
