part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<String> translations;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.translations = const [],
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object> get props => [translations, isLoading];
}
