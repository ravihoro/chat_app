import 'package:chat_app/core/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextFormField(
          obscureText: true,
          fieldKey: 'loginForm_passwordInput_textField',
          onChanged: (password) =>
              context.read<LoginCubit>().setPassword(password),
          labelText: 'Password',
        );
      },
    );
  }
}
