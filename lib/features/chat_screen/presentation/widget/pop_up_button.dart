import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_cubit.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopUpButton extends StatelessWidget {
  const PopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      child: PopupMenuButton<int>(
        child: const Icon(
          Icons.more_vert,
        ),
        onSelected: (value) {
          if (value == 0) {
            context.read<ChatCubit>().restartSession();
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                context.read<ChatCubit>().fetchRemoteMessage();
              },
            );
          } else if (value == 1) {
            context.read<ThemeCubit>().setTheme();
          } else {
            context.read<AuthenticationCubit>().logout();
            context.read<ChatCubit>().closeSocket();
          }
        },
        itemBuilder: (_) {
          return const [
            PopupMenuItem(
              value: 0,
              child: Text(
                'Restart Chat',
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(
                'Change Theme',
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                'Logout',
              ),
            )
          ];
        },
      ),
    );
  }
}
