import 'dart:developer';

import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/usecase/chat_usecase.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUsecase usecase;

  ChatCubit({
    required this.usecase,
  }) : super(const ChatState());

  void fetchLocalMessage() async {
    var either = await usecase.fetchLocalChat();
    either.fold(
      (l) => log(l.error),
      (r) {
        log("local message ${r.length}");
        for (var chat in r) {
          emit(state.copyWith(chat: chat));
        }
      },
    );
  }

  void fetchRemoteMessage() async {
    var stream = usecase.fetchRemoteChat();
    await for (var e in stream) {
      e.fold(
        (l) => log(
          e.toString(),
        ),
        (r) => emit(
          state.copyWith(chat: r),
        ),
      );
    }
  }

  void restartSession() {
    emit(state.copyWith());
    usecase.restartChat();
  }

  void closeSocket() {
    usecase.close();
  }

  void sendMessage(String message) {
    var chat = Chat(isSender: true, message: message);
    emit(state.copyWith(chat: chat));
    usecase.sendMessage(message);
  }
}
