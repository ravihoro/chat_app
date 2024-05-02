import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:dartz/dartz.dart';

abstract class LocalChatRepository {
  Future<Either<Failure, List<Chat>>> fetchMessages();
}

abstract class RemoteChatRepository {
  void sendMessage(String message);

  void close();

  void restartChat();

  Stream<Either<Failure, Chat>> fetchMessages();
}
