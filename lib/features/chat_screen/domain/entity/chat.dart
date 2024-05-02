import 'package:hive_flutter/hive_flutter.dart';

part 'chat.g.dart';

@HiveType(typeId: 1)
class Chat extends HiveObject {
  @HiveField(0)
  late bool isSender;

  @HiveField(1)
  late String message;

  Chat({
    required this.isSender,
    required this.message,
  });
}
