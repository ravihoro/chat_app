import 'package:chat_app/core/widgets/custom_elevation_button.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_cubit.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: ((previous, current) => previous.isValid != current.isValid),
      builder: (context, state) {
        return CustomElevatedButton(
          buttonText: 'Sign Up',
          keyText: 'signUpForm_signUp_elevatedButton',
          onPressed: state.isValid
              ? () {
                  var state = context.read<SignUpCubit>().state;
                  context.read<AuthenticationCubit>().signUp(
                        username: state.username!,
                        password: state.password!,
                      );
                }
              : null,
        );
      },
    );
  }
}
