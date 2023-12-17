part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardSetupEvent extends DashboardEvent {
  const DashboardSetupEvent();
}

class SpeechTranslationEvent extends DashboardEvent {
  const SpeechTranslationEvent(this.filePath);

  final String filePath;

  @override
  List<Object> get props => [filePath];
}
