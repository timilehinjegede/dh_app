// ignore_for_file: non_constant_identifier_names, constant_identifier_names

// base urls
import 'package:dexter_health/core/core.dart';

final BASE_URL = AppConfig.baseUrl;

class _AppEndpoints {
  final String speechToText = '$BASE_URL/stt_flutter_tech_assignment';
}

/// endpoints
final appEndpoints = _AppEndpoints();
