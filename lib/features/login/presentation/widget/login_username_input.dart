import 'package:chat_app/core/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUsernameInput extends StatelessWidget {
  const LoginUsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'loginForm_usernameInput_textField',
          onChanged: (username) =>
              context.read<LoginCubit>().setUsername(username),
          labelText: 'Username',
        );
      },
    );
  }
}
