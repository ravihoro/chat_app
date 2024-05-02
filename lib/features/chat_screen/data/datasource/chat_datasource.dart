import 'dart:async';

import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/io.dart';

abstract class ChatDatasource<T> {
  T fetchMessages();
}

class ChatLocalDatasource implements ChatDatasource<Future<List<Chat>>> {
  @override
  Future<List<Chat>> fetchMessages() async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    final loggedInUser = userBox.isEmpty ? null : userBox.getAt(0);
    if (loggedInUser != null) {
      var messages = [...loggedInUser.messages];

      await userBox.close();
      return messages;
    }
    return [];
  }
}

class ChatRemoteDatasource implements ChatDatasource<Stream<Chat>> {
  late IOWebSocketChannel? _channel;

  storeMessage(Chat chat) async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    final loggedInUser = userBox.isEmpty ? null : userBox.getAt(0);
    loggedInUser!.messages.add(chat);

    await userBox.put(0, loggedInUser);
    await userBox.close();
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
    storeMessage(Chat(isSender: true, message: message));
  }

  void close() async {
    await _channel?.sink.close();
  }

  void restartChat() async {
    final userBox = await Hive.openBox<User>('logged_in_user');
    final loggedInUser = userBox.isEmpty ? null : userBox.getAt(0);
    loggedInUser!.messages = [];
    await userBox.put(0, loggedInUser);
    await userBox.close();
    _channel?.sink.close();
  }

  @override
  Stream<Chat> fetchMessages() async* {
    _channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
    await for (var e in _channel!.stream) {
      var chat = Chat(isSender: false, message: e);
      storeMessage(chat);
      yield chat;
    }
  }
}
