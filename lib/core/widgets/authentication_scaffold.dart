import 'package:chat_app/core/utils/theme.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScaffold<T> extends StatelessWidget {
  final String text;
  final Widget child;

  const AuthenticationScaffold({
    required this.text,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[400],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
      floatingActionButton:
          BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        return FloatingActionButton(
          child: Icon(
              state.themeData == lightTheme ? Icons.nightlight : Icons.sunny),
          onPressed: () {
            context.read<ThemeCubit>().setTheme();
          },
        );
      }),
    );
  }
}
