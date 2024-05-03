import 'dart:developer';

import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_screen/data/datasource/chat_datasource.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:chat_app/features/chat_screen/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class RemoteChatRepositoryImpl implements RemoteChatRepository {
  final ChatRemoteDatasource datasource;

  const RemoteChatRepositoryImpl({required this.datasource});

  @override
  void sendMessage(String message) {
    datasource.sendMessage(message);
  }

  @override
  void close() {
    datasource.close();
  }

  @override
  Failure? restartChat() {
    try {
      datasource.restartChat();
      return null;
    } catch (e) {
      return const GenericFailure();
    }
  }

  @override
  Stream<Either<Failure, Chat>> fetchMessages() async* {
    try {
      var chatStream = datasource.fetchMessages();

      await for (var e in chatStream) {
        yield Right(e);
      }
    } catch (e) {
      log("fetch message: ${e.toString()}");
      //("fetch message: ${e.toString()}");
      yield const Left(
        ServerFailure(
          error: "Socket exception",
        ),
      );
    }
  }
}
