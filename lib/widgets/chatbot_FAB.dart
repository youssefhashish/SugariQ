import 'package:flutter/material.dart';
import 'package:sugar_iq/screens/chatbot.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class ChatBotButton extends StatelessWidget {
  const ChatBotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatBotPage()),
        );
      },
      backgroundColor: AppTheme.primary,
      child: Icon(
        Icons.chat,
        color: Colors.white,
      ),
    );
  }
}
