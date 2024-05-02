import 'package:chat_app/features/login/presentation/widget/login_button.dart';
import 'package:chat_app/features/login/presentation/widget/login_password_input.dart';
import 'package:chat_app/features/login/presentation/widget/login_username_input.dart';
import 'package:chat_app/features/login/presentation/widget/sign_up_navigation_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginUsernameInput(),
        SizedBox(
          height: 8.0,
        ),
        LoginPasswordInput(),
        SizedBox(
          height: 8.0,
        ),
        LoginButton(),
        SizedBox(
          height: 8.0,
        ),
        SignUpNavigationButton(),
      ],
    );
  }
}
