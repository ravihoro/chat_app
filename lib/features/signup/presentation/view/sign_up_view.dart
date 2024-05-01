import 'package:chat_app/core/utils/injection_container.dart';
import 'package:chat_app/core/widgets/authentication_scaffold.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_cubit.dart';
import 'package:chat_app/features/signup/presentation/view/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => sl<SignUpCubit>(),
      child: const AuthenticationScaffold(
        text: 'Sign Up',
        child: SignUpForm(),
      ),
    );
  }
}
