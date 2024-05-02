import 'package:chat_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat_screen/presentation/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().fetchLocalMessage();
    context.read<ChatCubit>().fetchRemoteMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          PopupMenuButton<int>(
            child: const Icon(
              Icons.more_vert,
            ),
            onSelected: (value) {
              if (value == 0) {
                context.read<ChatCubit>().restartSession();
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.read<ChatCubit>().fetchRemoteMessage();
                });
              } else {
                context.read<AuthenticationCubit>().logout();
                context.read<ChatCubit>().closeSocket();
              }
            },
            itemBuilder: (_) {
              return const [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    'Restart Chat',
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Logout',
                  ),
                )
              ];
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chat = state.messages[index];
                        return ChatBubble(
                          isSender: chat.isSender,
                          message: chat.message,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter your message',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        context.read<ChatCubit>().sendMessage(
                              controller.text.trim(),
                            );

                        controller.clear();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
