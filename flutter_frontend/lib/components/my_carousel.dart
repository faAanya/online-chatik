import 'package:flutter/material.dart';
import 'something.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final double avatarRadius = 30;

  final double horizontalPadding = 8.0;

  final List<String> imgs = const [
    'lib/images/1.jpg',
    'lib/images/2.jpg',
    'lib/images/3.jpg',
    'lib/images/4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: InfiniteCarousel.builder(
            itemCount: imgs.length,
            itemExtent: 80,
            center: true,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: EdgeInsets.symmetric(),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: AssetImage(
                    imgs[index % imgs.length],
                  ),
                  child: Text(
                    index.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_drop_up_outlined, size: 60)],
        ),
      ],
    );
  }
}
