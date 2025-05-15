import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isInitialized = false;
  String _lastWords = '';

  Future<bool> initSpeech() async {
    _isInitialized = await _speech.initialize();
    return _isInitialized;
  }

  void startListening(Function(String) onFinalResult) async {
    if (!_isListening && _isInitialized) {
      await _speech.listen(
        listenMode: stt.ListenMode.confirmation,
        onResult: (val) {
          if (val.finalResult && val.recognizedWords.trim().isNotEmpty) {
            _lastWords = val.recognizedWords;
            onFinalResult(_lastWords);
          }
        },
      );
      _isListening = true;
    }
  }

  void stopListening() {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
    }
  }

  bool get isListening => _isListening;
}
