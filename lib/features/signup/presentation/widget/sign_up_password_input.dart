import 'package:chat_app/core/utils/validators.dart';
import 'package:chat_app/core/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_cubit.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPasswordInput extends StatelessWidget {
  const SignUpPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
              context.read<SignUpCubit>().obscureText();
            },
            child: Icon(
              state.obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
          fieldKey: 'signUpForm_passwordInput_textField',
          onChanged: (password) =>
              context.read<SignUpCubit>().setPassword(password),
          labelText: 'Password',
          obscureText: state.obscureText,
          errorText:
              state.password == null ? null : isValidPassword(state.password),
        );
      },
    );
  }
}
