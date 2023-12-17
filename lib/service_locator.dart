import 'package:dexter_health/core/api/api.dart';
import 'package:dexter_health/features/dashboard/data/datasources/speech_to_text_remote_source.dart';
import 'package:dexter_health/features/dashboard/domain/domain.dart';
import 'package:get_it/get_it.dart';

import 'features/dashboard/domain/bloc/dashboard_bloc.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  // register dio api client
  serviceLocator.registerLazySingleton<IApiClient>(
    () => DioHttpApi(),
  );

  // register remote sources
  serviceLocator.registerLazySingleton<ISpeechToTextRemoteSource>(
    () => SpeechToTextRemoteSource(serviceLocator<IApiClient>()),
  );

  // register repositories
  serviceLocator.registerLazySingleton<ISpeechToTextRepository>(
    () => SpeechToTextRepository(serviceLocator<ISpeechToTextRemoteSource>()),
  );

  // Register blocs
  serviceLocator.registerFactory<DashboardBloc>(
    () => DashboardBloc(
      speechToTextRepository: serviceLocator<ISpeechToTextRepository>(),
    ),
  );
}
