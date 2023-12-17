import 'dart:io';
import 'dart:typed_data';
import 'package:wav/wav.dart';

class WavFileCreator {
  static const int sampleRate = 44100;
  static const int channelCount = 1;
  static const int bitDepth = 16;

  // creates a .wav file from a Uint8List
  Future<File> createWavFile(Uint8List audioData, String fileName) async {
    File wavFile = File(fileName);
    Float64List floatAudioData = convertAudioData(audioData);

    final wav = Wav(
      [floatAudioData],
      sampleRate,
    );

    final wavBytes = wav.write();

    await wavFile.writeAsBytes(wavBytes, mode: FileMode.write);

    return wavFile;
  }

  Float64List convertAudioData(Uint8List audioData) {
    var buffer = audioData.buffer;
    var samples = Float64List(buffer.lengthInBytes ~/ 2);
    var dataView = ByteData.sublistView(audioData);

    for (int i = 0; i < samples.length; i++) {
      var sample = dataView.getInt16(i * 2, Endian.little);
      samples[i] = sample / 32768.0;
    }

    return samples;
  }
}
