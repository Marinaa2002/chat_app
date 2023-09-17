import 'package:chat2_app/models/message.dart';
import 'package:flutter/material.dart';

class CustomChatBubbleForFriend extends StatelessWidget {
  CustomChatBubbleForFriend({super.key,required this.message, required this.color, this.borderRadius});

  Color color;
  BorderRadiusGeometry? borderRadius;
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
