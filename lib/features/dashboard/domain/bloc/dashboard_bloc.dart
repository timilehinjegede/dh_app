import 'dart:io';

import 'package:dexter_health/features/dashboard/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dexter_health/core/core.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ISpeechToTextRepository speechToTextRepository;

  final List<String> translations = [];

  // the endpoint returns the same response `{transcription: Untertitelung des ZDF, 2020}`
  // so to differentiate between the various responses;
  // I appended a counter to each of the responses so it is evident the last three recent
  // translations are shown on the UI.
  var counter = 0;

  DashboardBloc({
    required this.speechToTextRepository,
  }) : super(const DashboardState()) {
    on<DashboardSetupEvent>(_onDashboardSetup);
    on<SpeechTranslationEvent>(_onSpeechReceived);
  }

  void _onDashboardSetup(
    DashboardSetupEvent event,
    Emitter<DashboardState> emit,
  ) async {
    SpeechToTextService listeningService;

    listeningService = SpeechToTextService(
      onData: (File file) {
        counter = counter + 1;
        // Handle file, possibly dispatch an event to process it
        // add(ProcessFileEvent(file));
        add(SpeechTranslationEvent(file.path));
      },
    );

    listeningService.startListening();

    emit(const DashboardState());
  }

  // called whenever the speech is received
  void _onSpeechReceived(
    SpeechTranslationEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardState(
      isLoading: true,
      translations: translations.reversed.take(3).toList(),
    ));

    try {
      final response = await speechToTextRepository.speechToText(
        event.filePath,
      );

      // update the translation variable to keep track of successful api calls
      translations.add('$counter: ${response.transcription}');

      emit(
        DashboardState(
          translations: translations.reversed.take(3).toList(),
        ),
      );
    } on ApiException catch (e) {
      emit(DashboardState(error: e.message));
    }
  }
}
