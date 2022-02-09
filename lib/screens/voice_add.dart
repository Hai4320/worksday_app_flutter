import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:worksday_app/models/task.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:intl/intl.dart';

class VoiceAdd extends StatefulWidget {
  const VoiceAdd({ Key? key }) : super(key: key);

  @override
  _VoiceAddState createState() => _VoiceAddState();
}

class _VoiceAddState extends State<VoiceAdd> {
  bool _isListening = false;
  late SpeechToText _speech;
  double _confidence = 1.0;
  String _text = 'Press the button and start speaking';

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create task by voice"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              child: const Text("Done", style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),),
              onPressed: (){
                Task task = Task(DateTime.now().toString(),_text,0,0,0);
                Navigator.pushNamed(context,"/AddTask",arguments: task);
              }
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text( 
            _text,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),

    );
  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}