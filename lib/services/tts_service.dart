import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  late FlutterTts _flutterTts;

  TTSService(){
    _initializeTts();
  }

  Future<void> _initializeTts() async {
  _flutterTts = FlutterTts();
   await _flutterTts.setLanguage("en-US");
   await _flutterTts.setPitch(1.0);
   await _flutterTts.setSpeechRate(0.5);
  }



  Future<void> speak(String text) async {
   if (text.isNotEmpty) {
     await _flutterTts.speak(text);
   }
  }



  Future<void> stop() async {
   await _flutterTts.stop();
  }
}
