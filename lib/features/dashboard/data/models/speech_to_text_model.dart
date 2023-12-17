class SpeechToTextModel {
  String transcription;

  SpeechToTextModel({
    required this.transcription,
  });

  factory SpeechToTextModel.fromJson(Map<String, dynamic> json) =>
      SpeechToTextModel(
        transcription: json["transcription"],
      );

  Map<String, dynamic> toJson() => {
        "transcription": transcription,
      };
}
