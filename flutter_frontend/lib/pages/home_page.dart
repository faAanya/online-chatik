import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/chat_view.dart';
import 'package:flutter_frontend/components/my_carousel.dart';
import 'package:flutter_frontend/servives/chat_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatService>(
      builder: (context, chatService, child) {
        if (chatService.chats.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text("Polina Chat")),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(child: ChatView(chat: chatService.selectedChat)),
                    SizedBox(height: 10),
                    MyCarousel(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text("Nothing yet"));
        }
      },
    );
  }
}
