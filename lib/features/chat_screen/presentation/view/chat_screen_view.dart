import 'dart:developer';

import 'package:chat_app/features/chat_screen/presentation/bloc/chat_cubit.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/chat_screen/presentation/widget/chat_bubble.dart';
import 'package:chat_app/features/chat_screen/presentation/widget/pop_up_button.dart';
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
    log("chat screen initstate");
    Future.delayed(const Duration(milliseconds: 200), () {
      context.read<ChatCubit>().fetchLocalMessage();
    });
    context.read<ChatCubit>().fetchRemoteMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: const [
          PopUpButton(),
        ],
      ),
      body: Column(
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
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(
                            controller.text.trim(),
                          );

                      controller.clear();
                    }
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
