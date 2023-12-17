import 'package:dexter_health/core/core.dart';
import 'package:dexter_health/features/dashboard/data/models/speech_to_text_model.dart';

abstract class ISpeechToTextRemoteSource {
  Future<SpeechToTextModel> speechToText(String filePath);
}

class SpeechToTextRemoteSource implements ISpeechToTextRemoteSource {
  SpeechToTextRemoteSource(this.dioHttpApi);

  final IApiClient dioHttpApi;

  @override
  Future<SpeechToTextModel> speechToText(String filePath) async {
    final response = await dioHttpApi.uploadFile(
      appEndpoints.speechToText,
      filePath: filePath,
    );

    return SpeechToTextModel.fromJson(response.data);
  }
}
