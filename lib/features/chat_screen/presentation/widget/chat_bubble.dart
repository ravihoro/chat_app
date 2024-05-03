import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;

  const ChatBubble({
    Key? key,
    required this.isSender,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSender
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: Radius.circular(!isSender ? 0 : 10.0),
                bottomRight: Radius.circular(isSender ? 0 : 10.0),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
