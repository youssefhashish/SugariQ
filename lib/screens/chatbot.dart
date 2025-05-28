import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../components/speech_service.dart';
import '../widgets/app_theme.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

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

    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        _messages.add({
          'role': 'assistant',
          'message': 'API key not found. Please check your configuration.',
        });
      });
      return;
    }

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
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
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          message['message'] ?? '',
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
            title:
                Text('Diabetes Chat Bot', style: TextStyle(fontSize: 18.sp))),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10.w),
                children: _messages.map(_buildMessage).toList(),
              ),
            ),
            Divider(height: 1.h),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'type your message...',
                        hintStyle: TextStyle(fontSize: 14.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide:
                              BorderSide(color: AppTheme.primary, width: 2.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      size: 24.sp,
                    ),
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
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 14.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        _sendMessage(_controller.text.trim());
                      }
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 20.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
