import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/speech_service.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final String apiKey =
      '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';

  final speechService = SpeechService();
  String _lastRecognizedText = '';

  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    speechService.initSpeech();
  }

  Future<void> _sendMessage(String userMessage) async {
    setState(() {
      _messages.add({'role': 'user', 'message': userMessage});
    });
    _controller.clear();

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
      'HTTP-Referer': 'SugarIQ',
    };

    final recentMessages = _messages.length > 3
        ? _messages.sublist(_messages.length - 3)
        : _messages;

    final body = jsonEncode({
      'model': 'openai/gpt-3.5-turbo',
      'messages': [
        {
          'role': 'system',
          'content': '''
You are a smart medical assistant specialized in diabetes. You can answer all questions related to diabetes, including:
- Symptoms of diabetes
- Prevention methods
- Nutrition and diabetic-friendly diets
- Exercise plans for diabetics
- Medication and insulin guidance
- Blood sugar monitoring
- Lifestyle tips and advice
- Managing complications

If the user asks about anything unrelated to diabetes, kindly guide them back to the topic.

Always provide clear, accurate, and helpful information tailored for diabetic patients.
'''
        },
        ...recentMessages.map((msg) => {
              'role': msg['role'] == 'user' ? 'user' : 'assistant',
              'content': msg['message'],
            }),
      ],
    });

    http.Response response;
    int attempts = 0;

    do {
      response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 429) {
        await Future.delayed(Duration(seconds: 5));
      }
      attempts++;
    } while (response.statusCode == 429 && attempts < 3);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      setState(() {
        _messages.add({'role': 'assistant', 'message': reply});
      });
    } else {
      setState(() {
        _messages.add({
          'role': 'assistant',
          'message': 'Error: Unable to fetch response. Please try again later.',
        });
        print('Status code: ${response.statusCode}');
      });
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message['message'] ?? ''),
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
              children: _messages.map(_buildMessage).toList(),
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'type your message...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: () {
                    if (!_isListening) {
                      speechService.startListening((recognizedText) {
                        if (recognizedText != _lastRecognizedText) {
                          setState(() {
                            _controller.text = recognizedText;
                            _lastRecognizedText = recognizedText;
                          });
                        }
                      });
                      setState(() {
                        _isListening = true;
                      });
                    } else {
                      speechService.stopListening();
                      setState(() {
                        _isListening = false;
                      });
                    }
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _sendMessage(_controller.text.trim());
                    }
                  },
                  child: Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
