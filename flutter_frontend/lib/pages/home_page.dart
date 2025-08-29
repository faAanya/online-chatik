import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/chat_view.dart';
import 'package:flutter_frontend/components/my_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Polina Chat")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: ChatView()),
              SizedBox(height: 10),
              MyCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}
