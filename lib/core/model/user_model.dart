import 'package:chat_app/features/chat_screen/domain/entity/chat.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late List<Chat> messages;

  User({
    required this.username,
    required this.password,
    this.messages = const [],
  });
}
