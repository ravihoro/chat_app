import 'package:chat_app/features/login/presentation/widget/login_button.dart';
import 'package:chat_app/features/login/presentation/widget/login_password_input.dart';
import 'package:chat_app/features/login/presentation/widget/login_username_input.dart';
import 'package:chat_app/features/login/presentation/widget/sign_up_navigation_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LoginUsernameInput(),
        const SizedBox(
          height: 8.0,
        ),
        const LoginPasswordInput(),
        const SizedBox(
          height: 8.0,
        ),
        LoginButton(),
        const SizedBox(
          height: 8.0,
        ),
        const SignUpNavigationButton(),
      ],
    );
  }
}
