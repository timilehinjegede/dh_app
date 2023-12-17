import 'package:dexter_health/features/dashboard/data/datasources/speech_to_text_remote_source.dart';
import 'package:dexter_health/features/dashboard/data/models/speech_to_text_model.dart';

abstract class ISpeechToTextRepository {
  Future<SpeechToTextModel> speechToText(String filePath);
}

class SpeechToTextRepository implements ISpeechToTextRepository {
  SpeechToTextRepository(this.remoteSource);

  final ISpeechToTextRemoteSource remoteSource;

  @override
  Future<SpeechToTextModel> speechToText(String filePath) async {
    return remoteSource.speechToText(filePath);
  }
}
