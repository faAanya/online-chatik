import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/chat_view.dart';
import 'package:flutter_frontend/components/my_carousel.dart';
import 'package:flutter_frontend/lang/strings.dart';
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
            appBar: AppBar(
              title: Text(
                appName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            body: Center(
              child: Column(
                children: [
                  Expanded(child: ChatView(chat: chatService.selectedChat)),
                  Divider(
                    height: 3,
                    thickness: 3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  MyCarousel(),
                ],
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
