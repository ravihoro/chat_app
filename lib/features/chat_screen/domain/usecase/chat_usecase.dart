import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatUsecase {
  final LocalChatRepository _localRepository;
  final RemoteChatRepository _remoteRepository;

  const ChatUsecase({
    required LocalChatRepository localRepository,
    required RemoteChatRepository remoteRepository,
  })  : _localRepository = localRepository,
        _remoteRepository = remoteRepository;

  Future<Either<Failure, List<Chat>>> fetchLocalChat() async {
    return _localRepository.fetchMessages();
  }

  void close() {
    _remoteRepository.close();
  }

  void sendMessage(String message) {
    _remoteRepository.sendMessage(message);
  }

  void restartChat() {
    _remoteRepository.restartChat();
  }

  Stream<Either<Failure, Chat>> fetchRemoteChat() async* {
    await for (var e in _remoteRepository.fetchMessages()) {
      yield (e);
    }
  }
}
