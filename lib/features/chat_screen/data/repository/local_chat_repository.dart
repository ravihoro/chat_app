import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/data/datasource/chat_datasource.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class LocalChatRepositoryImpl implements LocalChatRepository {
  final ChatLocalDatasource datasource;

  const LocalChatRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Chat>>> fetchMessages() async {
    try {
      var messages = await datasource.fetchMessages();
      return Right(messages);
    } catch (e) {
      return Left(GenericFailure(error: e.toString()));
    }
  }
}
