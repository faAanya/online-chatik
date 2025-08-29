import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/chat.dart';
import 'package:flutter_frontend/model/message.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/servives/auth_service.dart';

class ChatService extends ChangeNotifier {
  final List<Chat> _chats = [];
  List<Chat> get chats => UnmodifiableListView(_chats);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  Chat get selectedChat => _chats[_selectedIndex];

  ChatService() {
    User? u = AuthService.user;
    if (u != null) {
      fetchChatsForUser(u);
    } else {}
  }

  void changeSelection(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> fetchChatsForUser(User u) async {
    List<Chat> fetcherChats = [
      Chat(
        chatId: "1",
        type: ChatType.privateChat,
        title: "Cat 1",
        messages: [
          TextMessage(
            content: "Meow 1",
            senderId: "1",
            createdAt: DateTime.now(),
          ),
        ],
        users: [
          u,
          User(
            id: "1",
            nickname: "Cat 1",
            phonenumber: "",
            avatarUrl: "lib/assets/images/1.jpg",
          ),
        ],
      ),
      Chat(
        chatId: "2",
        type: ChatType.privateChat,
        title: "Cat 2",
        messages: [
          TextMessage(
            content: "Meow 2",
            senderId: "1",
            createdAt: DateTime.now(),
          ),
        ],
        users: [
          u,
          User(
            id: "2",
            nickname: "Cat 2",
            phonenumber: "",
            avatarUrl: "lib/assets/images/2.jpg",
          ),
        ],
      ),
      Chat(
        chatId: "3",
        type: ChatType.privateChat,
        title: "Cat 3",
        messages: [],
        users: [
          u,
          User(
            id: "3",
            nickname: "Cat 3",
            phonenumber: "",
            avatarUrl: "lib/assets/images/3.jpg",
          ),
        ],
      ),
      Chat(
        chatId: "4",
        type: ChatType.privateChat,
        title: "Cat 4",
        messages: [],
        users: [
          u,
          User(
            id: "4",
            nickname: "Cat 4",
            phonenumber: "",
            avatarUrl: "lib/assets/images/4.jpg",
          ),
        ],
      ),
      Chat(
        chatId: "5",
        type: ChatType.privateChat,
        title: "Cat 5",
        messages: [],
        users: [
          u,
          User(id: "5", nickname: "Cat 5", phonenumber: "", avatarUrl: null),
        ],
      ),
    ];
    _chats.addAll(fetcherChats);
    notifyListeners();
  }
}
