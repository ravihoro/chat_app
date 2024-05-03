import 'package:chat_app/core/utils/injection_container.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/view/chat_screen_view.dart';
import 'package:chat_app/features/login/presentation/view/login_view.dart';
import 'package:chat_app/features/signup/presentation/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) async {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.user == null) {
          return state.isLoginPage ? const LoginView() : const SignUpView();
        } else {
          return BlocProvider(
            create: (_) => sl<ChatCubit>(),
            child: const ChatScreenView(),
          );
        }
      },
    );
  }
}
