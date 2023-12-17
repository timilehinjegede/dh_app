import 'dart:async';
import 'dart:io';
import 'package:dexter_health/core/core.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorder {
  static const _channel = MethodChannel('com.dexter.health.app/recording');
  static const int sampleRate =
      44100; // Must match the sample rate in the native code
  static const int channelCount = 1; // Mono audio
  static const int bitDepth = 16; // 16-bit PCM

  List<int> _audioBuffer = [];
  Timer? _timer;
  int _bufferedDurationMs = 0;
  // int _targetDurationMs = 5000; // 5 seconds
  int _targetDurationMs = 10000; // 10 seconds

  AudioRecorder() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'recordingData':
        handleIncomingAudioData(call.arguments);
        break;
      // Handle other method calls if any
    }
  }

  void handleIncomingAudioData(dynamic data) {
    if (data is Uint8List) {
      _audioBuffer.addAll(data);
      // Process data as needed
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      // Check if we have enough data for 5 seconds
      int requiredSamples = (sampleRate * _targetDurationMs / 1000).round();
      int requiredBytes =
          requiredSamples * channelCount * (bitDepth / 8).round();

      if (_audioBuffer.length >= requiredBytes) {
        _createWavFile(
            Uint8List.fromList(_audioBuffer.sublist(0, requiredBytes)));
        _audioBuffer = _audioBuffer.sublist(requiredBytes);
      }
    });
  }

  Future<File?> _createWavFile(Uint8List audioData) async {
    final dir = await getApplicationDocumentsDirectory();
    String fileName =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';

    WavFileCreator wavCreator = WavFileCreator();
    File wavFile = await wavCreator.createWavFile(audioData, fileName);

    // HTTP().sendAudioFile(filePath);
    DioHttpApi().uploadFile(
      appEndpoints.speechToText,
      file: wavFile,
    );
    return wavFile;
  }

  Future<void> startRecording() async {
    _audioBuffer.clear();
    try {
      await _channel.invokeMethod('startListening');
      startTimer();
    } on PlatformException catch (e) {
      // Handle exception
    }
  }

  Future<void> stopRecording() async {
    try {
      await _channel.invokeMethod('stopListening');
      _timer?.cancel();
      _timer = null;
      // Handle any remaining data in _audioBuffer
      if (_audioBuffer.isNotEmpty) {
        _createWavFile(Uint8List.fromList(_audioBuffer));
        _audioBuffer.clear();
      }
    } on PlatformException catch (e) {
      // Handle exception
    }
  }
}
