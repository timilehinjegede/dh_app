// ignore_for_file: unused_field
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dexter_health/core/core.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

typedef OnDataCallback = void Function(File file);

class SpeechToTextService {
  final OnDataCallback onData;

  static const _channel = MethodChannel('com.dexter.health.app/recording');

  static const int sampleRate = 44100;
  static const int channelCount = 1;
  static const int bitDepth = 16;

  List<int> _audioBuffer = [];
  Timer? _timer;
  final int _targetDurationMs = 5000; // 5 seconds

  SpeechToTextService({required this.onData}) {
    _channel.setMethodCallHandler(methodCallHandler);
  }

  Future<void> methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'recordingData':
        final data = call.arguments;
        if (data is Uint8List) {
          _audioBuffer.addAll(data);
        }
        break;
    }
  }

  void startRecordingTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        // Check if we have enough data for 5 seconds
        int requiredSamples = (sampleRate * _targetDurationMs / 1000).round();
        int requiredBytes =
            requiredSamples * channelCount * (bitDepth / 8).round();

        if (_audioBuffer.length >= requiredBytes) {
          final audioData = Uint8List.fromList(
            _audioBuffer.sublist(0, requiredBytes),
          );

          _processAudioData(audioData);
          _audioBuffer = _audioBuffer.sublist(requiredBytes);
        }
      },
    );
  }

  Future<File?> _processAudioData(Uint8List audioData) async {
    final dir = await getApplicationDocumentsDirectory();
    final timeStamp = DateTime.now().millisecondsSinceEpoch;

    String fileName = '${dir.path}/recording_$timeStamp.wav';

    WavFileCreator wavCreator = WavFileCreator();
    File wavFile = await wavCreator.createWavFile(audioData, fileName);

    onData(wavFile);

    return wavFile;
  }

  Future<void> startListening() async {
    _audioBuffer.clear();
    try {
      await _channel.invokeMethod('startListening');
      startRecordingTimer();
    } on PlatformException catch (e) {
      log('Error is => $e');
    }
  }
}
