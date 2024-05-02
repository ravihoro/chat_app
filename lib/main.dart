import 'package:chat_app/app_view.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/core/utils/injection_container.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ChatAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ThemeCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WebSocket Demo',
            theme: context.watch<ThemeCubit>().state.themeData,
            home: const AppView(),
          );
        },
      ),
    );
  }
}
