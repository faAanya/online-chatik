import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/chat.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/servives/auth_service.dart';
import 'package:flutter_frontend/servives/chat_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'something.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final double itemExtent = 80;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatService>(
      builder: (context, chatService, child) {
        return Column(
          children: [
            SizedBox(
              height: 100,
              child: InfiniteCarousel.builder(
                onIndexChanged: (i) => chatService.changeSelection(i),
                itemCount: chatService.chats.length,
                itemExtent: itemExtent,
                center: true,
                itemBuilder: (context, index, realIndex) {
                  Chat chat = chatService.chats[index];
                  User u = chat.users.firstWhere(
                    (u) => u.id != AuthService.user!.id,
                  );

                  return UserAvatar(
                    avatarUrl: u.avatarUrl,
                    text: index.toString(),
                    itemExtent: itemExtent,
                    selected: index == chatService.selectedIndex,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "lib/assets/images/selector.svg",
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    required this.text,
    required this.itemExtent,
    required this.selected,
  });

  final String? avatarUrl;
  final double itemExtent;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.all(2),
      width: itemExtent,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignOutside,
          style: BorderStyle.solid,
          color: Theme.of(context).colorScheme.primary,
          width: selected ? 4 : 1,
        ),
      ),
      child: CircleAvatar(
        backgroundImage: avatarUrl != null ? AssetImage(avatarUrl!) : null,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
