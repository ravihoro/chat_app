import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class LocalChatRepositoryImpl implements LocalChatRepository {
  @override
  Future<Either<Failure, List<Chat>>> fetchMessages() {
    throw UnimplementedError();
  }
}
