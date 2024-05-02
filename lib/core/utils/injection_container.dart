import 'package:chat_app/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:chat_app/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:chat_app/features/authentication/domain/usecase/authentication_usecase.dart';
import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/chat_screen/data/datasource/chat_datasource.dart';
import 'package:chat_app/features/chat_screen/data/repository/local_chat_repository.dart';
import 'package:chat_app/features/chat_screen/data/repository/remote_chat_repository.dart';
import 'package:chat_app/features/chat_screen/domain/usecase/chat_usecase.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_cubit.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SignUpCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ChatCubit(usecase: sl<ChatUsecase>()));
  sl.registerFactory(() => ThemeCubit());

  sl.registerFactory(
      () => AuthenticationCubit(usecase: sl<AuthenticationUsecase>()));

  sl.registerLazySingleton(
    () => ChatUsecase(
      localRepository: sl<LocalChatRepositoryImpl>(),
      remoteRepository: sl<RemoteChatRepositoryImpl>(),
    ),
  );

  sl.registerLazySingleton(
    () => LocalChatRepositoryImpl(
      datasource: sl<ChatLocalDatasource>(),
    ),
  );
  sl.registerLazySingleton(
    () => RemoteChatRepositoryImpl(
      datasource: sl<ChatRemoteDatasource>(),
    ),
  );

  sl.registerLazySingleton(() => ChatRemoteDatasource());
  sl.registerLazySingleton(() => ChatLocalDatasource());

  sl.registerLazySingleton(
      () => AuthenticationUsecase(sl<AuthenticationRepositoryImpl>()));
  sl.registerLazySingleton(
      () => AuthenticationRepositoryImpl(sl<AuthenticationLocalDatasource>()));
  sl.registerLazySingleton(() => AuthenticationLocalDatasource());
}
