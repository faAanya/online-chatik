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

  void sendMessage(Chat chat, User me) {
    if (_controller.text.isEmpty) return;
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
  }

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
                    color: Theme.of(context).colorScheme.surface,
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
                MessageTextField(
                  controller: _controller,
                  onSend: () => sendMessage(chat, me),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150, minHeight: 48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Message',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        fontSize: 16,
                      ),
                    ),
                    maxLines: null,
                    minLines: null,
                  ),
                ),
              ),
            ),
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: onSend,
              iconSize: 24,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
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
            constraints: BoxConstraints(maxWidth: 350),
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
