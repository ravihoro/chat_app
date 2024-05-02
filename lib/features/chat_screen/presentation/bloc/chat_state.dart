import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final List<Chat> messages;

  const ChatState({this.messages = const []});

  ChatState copyWith({
    Chat? chat,
  }) {
    return ChatState(messages: chat == null ? [] : [...messages, chat]);
  }

  @override
  List<Object?> get props => [
        messages,
      ];
}
