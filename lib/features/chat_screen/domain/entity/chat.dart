import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final bool isSender;
  final String message;

  const Chat({
    required this.isSender,
    required this.message,
  });

  @override
  List<Object?> get props => [
        isSender,
        message,
      ];
}
