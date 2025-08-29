import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/message.dart';
import 'package:flutter_frontend/model/user.dart';

class Chat extends ChangeNotifier {
  final String chatId;
  final ChatType type;
  final String title;
  final List<Message> messages;
  final List<User> users;

  Chat({
    required this.chatId,
    required this.type,
    required this.title,
    required this.messages,
    required this.users,
  });

  void addMessage(Message m) {
    messages.add(m);
    notifyListeners();
  }
}

enum ChatType { privateChat, groupChat }
