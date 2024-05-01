import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/usecase/chat_usecase.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUsecase usecase;

  ChatCubit({
    required this.usecase,
  }) : super(const ChatState());

  void fetchLocalMessage() {}

  void fetchRemoteMessage() async {
    var stream = usecase.remoteRepository.fetchMessages();
    await for (var e in stream) {
      e.fold(
        (l) => print(
          e.toString(),
        ),
        (r) => emit(
          state.copyWith(r),
        ),
      );
    }
  }

  void sendMessage(String message) {
    var chat = Chat(isSender: true, message: message);
    emit(state.copyWith(chat));
    usecase.remoteRepository.sendMessage(message);
  }
}
