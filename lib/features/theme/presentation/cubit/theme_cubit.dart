import 'package:chat_app/core/utils/theme.dart';
import 'package:chat_app/features/theme/presentation/cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
            lightTheme,
          ),
        );

  setTheme() {
    emit(
      state.copyWith(
        state.themeData == lightTheme ? darkTheme : lightTheme,
      ),
    );
  }
}
