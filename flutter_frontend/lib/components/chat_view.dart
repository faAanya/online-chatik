import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [
    Message(content: "Miv", mine: false),
    Message(content: "Moew", mine: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.amber,
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  content: messages[index].content,
                  isMine: messages[index].mine,
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
                  messages.add(Message(content: _controller.text, mine: true));
                  _controller.clear();
                });
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}

class Message {
  Message({required this.content, required this.mine});
  String content;
  bool mine;
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
