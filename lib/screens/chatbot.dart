/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController userController = TextEditingController();
  String botReply = '';

  Future<void> sendMessageToBot() async {
    var url = Uri.parse('http://192.168.1.6:5000/get');
    var response = await http.post(url, body: {'msg': userController.text});

    if (response.statusCode == 200) {
      setState(() {
        botReply = response.body;
      });
    } else {
      setState(() {
        botReply = 'Error: Could not get response.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Diabetes Care Chatbot')),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  hintText: 'Type your message to the bot...',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: sendMessageToBot,
                child: Text('Send'),
              ),
              SizedBox(height: 20),
              Text(
                'Bot:\n$botReply',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController userController = TextEditingController();
  List<Map<String, String>> messages = [];

  Future<void> sendMessage() async {
    String userText = userController.text;

    setState(() {
      messages.add({'sender': 'user', 'text': userText});
      userController.clear();
    });

    var url = Uri.parse('http://192.168.1.6:5000/get');
    var response = await http.post(url, body: {'msg': userText});

    if (response.statusCode == 200) {
      setState(() {
        messages.add({'sender': 'bot', 'text': response.body});
      });
    } else {
      setState(() {
        messages
            .add({'sender': 'bot', 'text': 'Error: Could not get response.'});
      });
    }
  }

  Widget buildMessage(Map<String, String> msg) {
    bool isUser = msg['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(msg['text'] ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diabetes Chat Bot')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: messages.map(buildMessage).toList(),
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: Text('Send'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
