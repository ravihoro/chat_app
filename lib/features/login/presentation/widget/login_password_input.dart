import 'package:chat_app/core/utils/validators.dart';
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
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.obscureText != current.obscureText,
      builder: (context, state) {
        return CustomTextFormField(
          prefixIcon: const Icon(
            Icons.lock,
          ),
          suffix: GestureDetector(
            onTap: () {
              context.read<LoginCubit>().obscureText();
            },
            child: Icon(
              state.obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
          obscureText: state.obscureText,
          fieldKey: 'loginForm_passwordInput_textField',
          onChanged: (password) =>
              context.read<LoginCubit>().setPassword(password),
          labelText: 'Password',
          errorText:
              state.password == null ? null : isValidPassword(state.password),
        );
      },
    );
  }
}
