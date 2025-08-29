import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/home_page.dart';
import 'package:flutter_frontend/servives/chat_service.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatService>(create: (_) => ChatService()),
      ],
      child: HomePage(),
    );
  }
}
