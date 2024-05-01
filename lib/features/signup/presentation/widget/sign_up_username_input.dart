import 'package:chat_app/core/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_cubit.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUsernameInput extends StatelessWidget {
  const SignUpUsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'signUpForm_nameInput_textField',
          onChanged: (name) => context.read<SignUpCubit>().setUsername(name),
          labelText: 'Username',
        );
      },
    );
  }
}
