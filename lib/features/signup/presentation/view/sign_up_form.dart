import 'package:chat_app/features/signup/presentation/widget/login_navigation_button.dart';
import 'package:chat_app/features/signup/presentation/widget/sign_up_button.dart';
import 'package:chat_app/features/signup/presentation/widget/sign_up_password_input.dart';
import 'package:chat_app/features/signup/presentation/widget/sign_up_username_input.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignUpUsernameInput(),
        SizedBox(
          height: 8.0,
        ),
        SignUpPasswordInput(),
        SizedBox(
          height: 8.0,
        ),
        SignUpButton(),
        SizedBox(
          height: 8.0,
        ),
        LoginNavigationButton(),
      ],
    );
  }
}
