import 'package:flutter/material.dart';
import 'package:sugar_iq/screens/chatbot.dart';

class ChatBotButton extends StatelessWidget {
  const ChatBotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatbot()),
        );
      },
      backgroundColor: Color(0xFF85C26F),
      child: Icon(
        Icons.chat,
        color: Colors.white,
      ),
    );
  }
}
