import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project/configs/constants.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class TTSButton extends StatefulWidget {
  const TTSButton({super.key});

  @override
  State<TTSButton> createState() => _TTSButtonState();
}

class _TTSButtonState extends State<TTSButton> {
  bool _isTapped = false;
  FlutterTts _tts = FlutterTts();
  bool _isSlow = false; // Variable to track if speech should be slower

  @override
  void initState() {
    _setUpTts();
    super.initState();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => Expanded(
        child: InkWell(
          onTap: () {
            _isSlow = !_isSlow; // Toggle the value for alternating speeds
            _runTts(text: notifier.word2.ukrainian, isSlow: _isSlow);
            _isTapped = true;
            setState(() {});
            Future.delayed(Duration(milliseconds: 500), () {
              _isTapped = false;
              setState(() {});
            });
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.audiotrack, size: 50, color: _isTapped ? kBlue : Colors.black),
          ),
        ),
      ),
    );
  }


  _setUpTts() async {
    await _tts.setLanguage('uk-UA');
    List<dynamic> languages = await _tts.getLanguages;
    print(languages);
    print(languages.length);
    // Set the initial speech rate (you can adjust this if needed)
    await _tts.setSpeechRate(0.40);
  }

  _runTts({required String text, required bool isSlow}) async {
    // Set the speech rate based on the isSlow variable
    await _tts.setSpeechRate(isSlow ? 0.10 : 0.40);
    await _tts.speak(text);
  }
}
