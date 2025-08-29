import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/chat.dart';
import 'package:flutter_frontend/model/message.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/servives/auth_service.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.chat});

  final Chat chat;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Chat>.value(
      value: widget.chat,
      builder: (context, child) {
        User me = AuthService.user!;

        return Consumer<Chat>(
          builder: (context, chat, child) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: ListView.builder(
                      itemCount: chat.messages.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          content: chat.messages[index].content,
                          isMine: chat.messages[index].senderId == me.id,
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: TextField(controller: _controller)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          chat.addMessage(
                            TextMessage(
                              content: _controller.text,
                              senderId: me.id,
                              createdAt: DateTime.now(),
                            ),
                          );
                          _controller.clear();
                        });
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.content, required this.isMine});

  final String content;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
      child: Row(
        mainAxisAlignment: isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(content),
            ),
          ),
        ],
      ),
    );
  }
}
