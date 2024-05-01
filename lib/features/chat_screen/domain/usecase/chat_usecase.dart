import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatUsecase {
  final LocalChatRepository localRepository;
  final RemoteChatRepository remoteRepository;

  const ChatUsecase({
    required this.localRepository,
    required this.remoteRepository,
  });

  Future<Either<Failure, List<Chat>>> fetchLocalChat() async {
    throw Exception();
  }

  Stream<Either<Failure, Chat>> fetchRemoteChat() async* {
    await for (var e in remoteRepository.fetchMessages()) {
      yield (e);
    }
  }
}
