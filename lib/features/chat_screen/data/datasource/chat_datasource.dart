import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:web_socket_channel/io.dart';

abstract class ChatDatasource {
  Stream<Chat> fetchMessages();
}

class ChatLocalDatasource implements ChatDatasource {
  @override
  Stream<Chat> fetchMessages() async* {}
}

class ChatRemoteDatasource implements ChatDatasource {
  final _channel = IOWebSocketChannel.connect('wss://echo.websocket.org');

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  @override
  Stream<Chat> fetchMessages() async* {
    await for (var e in _channel.stream) {
      yield Chat(isSender: false, message: e);
    }
  }
}
