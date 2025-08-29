import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/chat.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/servives/auth_service.dart';
import 'package:flutter_frontend/servives/chat_service.dart';
import 'package:provider/provider.dart';
import 'something.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final double avatarRadius = 30;

  final double horizontalPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatService>(
      builder: (context, chatService, child) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: InfiniteCarousel.builder(
                onIndexChanged: (i) => chatService.changeSelection(i),
                itemCount: chatService.chats.length,
                itemExtent: 80,
                center: true,
                itemBuilder: (context, index, realIndex) {
                  Chat chat = chatService.chats[index];
                  User u = chat.users.firstWhere(
                    (u) => u.id != AuthService.user!.id,
                  );

                  if (u.avatarUrl != null) {
                    return Padding(
                      padding: EdgeInsets.symmetric(),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage(u.avatarUrl!),
                        child: Text(
                          index.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        child: Text(
                          index.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.arrow_drop_up_outlined, size: 60)],
            ),
          ],
        );
      },
    );
  }
}
